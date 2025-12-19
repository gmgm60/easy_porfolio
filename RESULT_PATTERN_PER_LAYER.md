# Result Pattern Per Layer (Clean Architecture + `result_dart`)

This guide explains **which `result_dart` APIs to use in each Clean Architecture layer**, **why**, and **how**—with concrete examples. It follows Flutter’s “Result objects” guidance (keep results through the layers; unwrap at the edge) and Dart’s exception model (exceptions are **unchecked**).  
**Refs:** Flutter architecture note on Result objects, Dart error-handling docs, `result_dart` package.  
- Flutter Result objects: https://docs.flutter.dev/app-architecture/design-patterns/result  
- Dart exceptions (unchecked): https://dart.dev/language/error-handling  
- `result_dart` on pub.dev: https://pub.dev/packages/result_dart

---

## 0) What `result_dart` gives you

- **Core union:** `ResultDart<S, F>` with concrete states `Success<S, F>` and `Failure<S, F>`.
- **Async type:** `AsyncResultDart<S, F>` = `Future<ResultDart<S, F>>` + async operators (same names on `Future<Result<...>>`).
- **Shortcuts:** `Result<S>` and `AsyncResult<S>` (failure defaults to `Exception`), `Unit`/`unit` for void-like generics.
- **Helpers & extensions:** `toSuccess`/`toFailure`, `id`/`identity`, plus many chain operators (`map`, `flatMap`, `mapError`, `recover`, etc.).

> The library is inspired by Kotlin/Swift Result and functional patterns; see pub.dev for signatures and examples: https://pub.dev/packages/result_dart

---

## 1) Layer rules (Clean Architecture)

- **Domain (Entities, Value Objects, UseCases)**: Pure business rules, **no transport concerns**. Return `ResultDart<DomainType, FailureType>` (typed failures). Compose rules with `map`, `flatMap`, `mapFold`, `pure`, `pureFold`.
- **Data (Models, Repo Impl, DataSources)**: Catch **library exceptions** (Dio, Drift) once; **convert** to domain failures via `mapError` / `recover` / `mapFold`; return `ResultDart<DomainType, AppFailure>`.
- **Presentation / State management**: Unwrap at the **edge** with `fold` / `getOrElse` / `getOrDefault` / `getOrNull` / `getOrThrow`; decide what to render.

Why this works well in Dart/Flutter:
- Dart exceptions are **unchecked** (methods don’t declare throws). Returning Result makes outcomes explicit and forces handling.  
  Ref: https://dart.dev/language/error-handling
- Flutter’s Result-objects guidance shows how Results simplify control-flow vs nested `try/catch`.  
  Ref: https://docs.flutter.dev/app-architecture/design-patterns/result

---

## 2) Domain layer — APIs, why, and how

**Goal:** determinstic business logic with typed failures; no HTTP/DB or IO here.

| API | Why (Domain) | Example |
|---|---|---|
| `map` | Transform success only (e.g., normalize fields) | `r.map((p) => p.name.trim())` |
| `flatMap` | Chain rule → rule with short-circuit on first failure | `validateName(p).flatMap(validatePrice)` |
| `mapFold` | Transform **both** success and failure while staying in Result | `r.mapFold(Entity.fromDto, (e) => DomFail.parse(e.toString()))` |
| `pure` | Replace success payload (e.g., discard to `Unit`) | `r.pure(unit)` |
| `pureFold` | Replace both sides with constants/normalized shapes | `r.pureFold('OK', DomFail.unknown())` |

**Example (linear composition):**
```dart
sealed class DomFail { const DomFail(); }
final class EmptyCart extends DomFail { const EmptyCart(); }
final class PriceTooLow extends DomFail { const PriceTooLow(this.min, this.got); final int min, got; }

ResultDart<int, DomFail> _sum(List<int> xs) =>
  xs.isEmpty ? Failure(const EmptyCart()) : Success(xs.reduce((a,b)=>a+b));

ResultDart<int, DomFail> _min(int cents) =>
  cents >= 100 ? Success(cents) : Failure(PriceTooLow(100, cents));

ResultDart<int, DomFail> priceCart(List<int> xs) =>
  _sum(xs).flatMap(_min).map((ok) => ok - 10); // no try/catch pyramids
```

---

## 3) Data layer — APIs, why, and how

**Goal:** Catch/normalize **transport & technical** errors (Dio, Drift) once; return `ResultDart<Domain, AppFailure>` upward.

| API | Why (Data) | Example |
|---|---|---|
| `mapError` | Convert library errors to `AppFailure` | `raw.mapError(mapDio)` |
| `flatMapError` | Remediation path returning a Result (e.g., cache fallback) | `raw.flatMapError((f)=> f is Net ? Success(cache) : Failure(f))` |
| `recover` | Policy fallback; convert some failures into success | `httpCall.recover((f)=> Success(cachedPage))` |
| `mapFold` | Boundary reshape (DTO→Domain and Error→AppFailure) in one step | `raw.mapFold(toDomain, mapTransportToFailure)` |
| `onSuccess`/`onFailure` | Telemetry without breaking the chain | `repoCall.onFailure(reportToSentry)` |
| `toAsyncResult` | Wrap a throwing `Future` into `Future<Result>` | `await someFuture.toAsyncResult()` |
| Async operators | Same names on `Future<Result<...>>` for linear async pipelines | `await repo.fetch().map(...).mapError(...).recover(...)` |

**Boundary example (remote DTO + Dio → domain types + AppFailure):**
```dart
Future<ResultDart<User, AppFailure>> getUser(String id) async {
  final raw = await api.fetchUserDto(id); // Future<ResultDart<UserDto, DioException>>
  return raw.mapFold<User, AppFailure>(
    (dto) => dto.toDomain(),
    (dio)  => errorHandler.fromDio(dio),
  );
}
```

Dio wraps HTTP/network errors in `DioException` with a rich `type` (timeout, cancel, badResponse, etc.). Map those to domain failures **once**.  
Refs: Dio package and API docs  
- https://pub.dev/packages/dio  
- https://pub.dev/documentation/yjy_dio_5_4_0/latest/dio/DioException-class.html

Drift wraps engine errors as `DriftWrappedException`, `InvalidDataException`, etc.—map these to DB failures.  
Refs:  
- https://pub.dev/documentation/drift/latest/drift/DriftWrappedException-class.html  
- https://drift.simonbinder.eu/

---

## 4) Presentation / State management (UI edge)

**Goal:** Unwrap once and render. Don’t do transport mapping here.

| API | Why (Presentation) | Example |
|---|---|---|
| `fold` | Collapse Result to a concrete value (widget/text/state) | `r.fold(buildOk, buildError)` |
| `getOrElse` | Fallback computed from failure | `title = r.getOrElse((f)=>'Offline')` |
| `getOrDefault` | Literal fallback | `name = r.getOrDefault('Guest')` |
| `getOrNull` | Nullable extraction | `final s = r.getOrNull()` |
| `getOrThrow` | Hard fail (tests/strict flow) | `final v = r.getOrThrow()` |
| `isSuccess` / `isError` | Quick guards | `if (r.isError()) showRetry()` |
| `exceptionOrNull` | Log/inspect failure without branching | `log(r.exceptionOrNull()?.toString())` |

Riverpod treats providers as “memoized functions” that expose state; you can surface `Result` to widgets and `fold` there, or fold inside the provider and expose a view model.  
Refs:  
- https://riverpod.dev/docs/concepts2/providers  
- https://riverpod.dev/ko/docs/concepts/providers

---

## 5) API cheat-sheet (by job)

- **Inspect:** `isSuccess`, `isError`, `exceptionOrNull`  
- **Extract:** `getOrThrow`, `getOrNull`, `getOrDefault`, `getOrElse`  
- **Success path:** `map`, `flatMap`, `pure`  
- **Failure path:** `mapError`, `flatMapError`, `pureError`  
- **Both sides:** `mapFold`, `pureFold`  
- **Side-effects:** `onSuccess`, `onFailure`  
- **Recovery:** `recover`  
- **Utils:** `swap`, `toAsyncResult`  
- **Async:** same names on `Future<Result<...>>` via async extension

See `result_dart` for exact signatures/examples: https://pub.dev/packages/result_dart

---

## 6) When to use each type

- `ResultDart<Domain, AppFailure>`: **recommended** across Domain & Data; precise, machine-readable failures.
- `Result<Domain>`: shortcut using `Exception` as failure—OK for prototypes or where domain failures aren’t needed.
- `AsyncResultDart/AsyncResult`: for async flows (most repos).
- `Unit`: for write/void-like ops (e.g., save/commit) in generics.

---

## 7) Why Results instead of throwing across layers?

- Dart exceptions are **unchecked**; callers aren’t forced to handle them, making bugs and crashes easy. Results make outcomes explicit at the type level and enable linear, testable pipelines.  
  Ref: https://dart.dev/language/error-handling
- Flutter’s Result pattern shows fewer nested `try/catch`, cleaner control flow, and unwrapping at the edge.  
  Ref: https://docs.flutter.dev/app-architecture/design-patterns/result
