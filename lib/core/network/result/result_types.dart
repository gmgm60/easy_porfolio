
import 'package:easy_porfolio/core/network/failure/app_failure.dart';
import 'package:result_dart/result_dart.dart';


typedef AppResult<S extends Object> = ResultDart<S,AppFailure>;
typedef AppAsyncResult<S extends Object> = AsyncResultDart<S,AppFailure>;

/// For void-like operations
typedef AppUnitResult = AppResult<Unit>;
typedef AppUnitAsyncResult = AppAsyncResult<Unit>;
