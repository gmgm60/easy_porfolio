import 'package:easy_porfolio/core/theme/app_colors.dart';
import 'package:easy_porfolio/core/theme/text_styles.dart';
import 'package:easy_porfolio/core/theme/text_tokens.dart';
import 'package:flutter/material.dart';


/// Builds a comprehensive ThemeData by applying sub-themes for Material components.
/// Uses only tokens and colors (no Theme.of during construction).
ThemeData applyComponentThemes(
  ThemeData baseTheme,
  AppColors appColors,
  AppTypographyTokens typographyTokens,
  BuildContext context,
) {
  final r = TextStyles(
    colors: appColors,
    tokens: typographyTokens,
    buildContext: context,
  );
  final label = baseTheme.textTheme.labelLarge;
  final title = baseTheme.textTheme.titleLarge;
  final appBarStyle = r.headlineMediumTextStyle.copyWith(
    color: appColors.textPrimary,
    fontWeight: FontWeight.bold,
  );
  return baseTheme.copyWith(
    // ===== App Bar =====
    appBarTheme: AppBarTheme(
      backgroundColor: appColors.surfaceVariant,
      foregroundColor: appColors.textPrimary,
      elevation: 0,
      centerTitle: true,
      titleTextStyle: title!.merge(appBarStyle),
      toolbarTextStyle: r.bodyMediumTextStyle,

      iconTheme: IconThemeData(color: appColors.onBackground),
      actionsIconTheme: IconThemeData(color: appColors.onBackground),
    ),

    // ===== Cards =====
    cardTheme: CardThemeData(
      color: appColors.surface,
      elevation: 0,
      margin: EdgeInsets.zero,
      shape: RoundedRectangleBorder(
        side: BorderSide(color: appColors.border),
        borderRadius: BorderRadius.circular(16),
      ),
      shadowColor: Colors.transparent,
    ),

    // ===== Buttons =====
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        padding: EdgeInsets.zero,

        foregroundColor: appColors.onPrimary,
        backgroundColor: appColors.primary,
        textStyle: label?.merge(r.buttonTextStyle),
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        padding: EdgeInsets.zero,
        foregroundColor: appColors.onPrimary,
        backgroundColor: appColors.primary,
        textStyle: label
            ?.merge(r.buttonTextStyle)
            .copyWith(color: appColors.onSurface),
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        padding: EdgeInsets.zero,

        foregroundColor: appColors.primary,
        side: BorderSide(color: appColors.primary),
        textStyle: label
            ?.merge(r.buttonTextStyle)
            .copyWith(color: appColors.primary),
        minimumSize: const Size(100, 40),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        padding: EdgeInsets.zero,

        foregroundColor: appColors.primary,
        textStyle: label?.merge(r.actionTextStyle),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
    ),
    iconButtonTheme: IconButtonThemeData(
      style: ButtonStyle(
        visualDensity: VisualDensity.standard,

        padding: const WidgetStatePropertyAll<EdgeInsetsGeometry>(
          EdgeInsets.zero,
        ),

        // side: WidgetStatePropertyAll<BorderSide?>(
        //   BorderSide(color: appColors.primary),
        // ),
        iconColor: WidgetStatePropertyAll(appColors.primary),
        foregroundColor: WidgetStatePropertyAll(appColors.onSurface),
        minimumSize: const WidgetStatePropertyAll<Size?>(Size(40, 40)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        ),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: appColors.primary,
      foregroundColor: appColors.onPrimary,
      shape: const CircleBorder(),
    ),

    // ===== Search (M3 SearchBar + SearchView) =====
    searchBarTheme: SearchBarThemeData(
      backgroundColor: WidgetStatePropertyAll(appColors.surfaceVariant),
      elevation: const WidgetStatePropertyAll(0),
      side: WidgetStatePropertyAll(BorderSide(color: appColors.border)),
      shape: WidgetStatePropertyAll(
        RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      ),
      hintStyle: WidgetStatePropertyAll(r.labelMediumTextStyle),
      textStyle: WidgetStatePropertyAll(r.bodyMediumTextStyle),
      padding: const WidgetStatePropertyAll(
        EdgeInsets.symmetric(horizontal: 12, vertical: 8),
      ),
    ),
    searchViewTheme: SearchViewThemeData(
      backgroundColor: appColors.surface,
      headerTextStyle: r.bodyMediumTextStyle,
      headerHintStyle: r.labelMediumTextStyle,
      dividerColor: appColors.divider,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),

      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
    ),

    // ===== Inputs =====
    inputDecorationTheme: InputDecorationTheme(

      filled: true,
      fillColor: appColors.surface,
    isDense: true,
      isCollapsed: true,
      visualDensity: VisualDensity.standard,
      hintStyle: r.labelMediumTextStyle,
      labelStyle: r.labelLargeTextStyle,
      helperStyle: r.captionTextStyle,
      errorStyle: r.captionTextStyle.copyWith(color: appColors.error),
      suffixIconConstraints:const BoxConstraints(minWidth: 30,minHeight: 30) ,
      prefixIconConstraints:const BoxConstraints(minWidth: 30,minHeight: 30) ,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      enabledBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appColors.borderStrong),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appColors.primary, width: .5),
        borderRadius: BorderRadius.circular(8),
      ),
      errorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appColors.error, width: .5),
        borderRadius: BorderRadius.circular(8),
      ),
      focusedErrorBorder: OutlineInputBorder(
        borderSide: BorderSide(color: appColors.error, width: .5),
        borderRadius: BorderRadius.circular(8),
      ),
      prefixIconColor: appColors.textSecondary,
      suffixIconColor: appColors.textSecondary,

    ),

    // ===== Segmented / Toggle =====
    segmentedButtonTheme: SegmentedButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(r.labelLargeTextStyle),
        foregroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? appColors.onPrimary
              : appColors.textPrimary,
        ),
        backgroundColor: WidgetStateProperty.resolveWith(
          (s) => s.contains(WidgetState.selected)
              ? appColors.primary
              : appColors.surface,
        ),
        side: WidgetStatePropertyAll(BorderSide(color: appColors.border)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        ),
      ),
    ),
    toggleButtonsTheme: ToggleButtonsThemeData(
      textStyle: r.labelLargeTextStyle,
      color: appColors.textPrimary,
      selectedColor: appColors.onPrimary,
      fillColor: appColors.primary.withValues(alpha: 0.12),
      borderColor: appColors.border,
      selectedBorderColor: appColors.primary,
      borderRadius: BorderRadius.circular(12),
      constraints: const BoxConstraints(minHeight: 40, minWidth: 40),
    ),

    // ===== Dropdowns & Menus =====
    dropdownMenuTheme: DropdownMenuThemeData(
      textStyle: r.bodyMediumTextStyle,
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: appColors.surface,
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.border),
          borderRadius: BorderRadius.circular(12),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: appColors.primary, width: 1.5),
          borderRadius: BorderRadius.circular(12),
        ),
      ),
      menuStyle: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(appColors.surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(8),
        side: WidgetStatePropertyAll(BorderSide(color: appColors.border)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),

    menuBarTheme: MenuBarThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(appColors.surface),
        elevation: const WidgetStatePropertyAll(0),
        side: WidgetStatePropertyAll(BorderSide(color: appColors.border)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
        padding: const WidgetStatePropertyAll(
          EdgeInsets.symmetric(horizontal: 8),
        ),
      ),
    ),
    menuTheme: MenuThemeData(
      style: MenuStyle(
        backgroundColor: WidgetStatePropertyAll(appColors.surface),
        surfaceTintColor: const WidgetStatePropertyAll(Colors.transparent),
        elevation: const WidgetStatePropertyAll(8),
        side: WidgetStatePropertyAll(BorderSide(color: appColors.border)),
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
        ),
      ),
    ),
    menuButtonTheme: MenuButtonThemeData(
      style: ButtonStyle(
        textStyle: WidgetStatePropertyAll(r.bodyMediumTextStyle),
        foregroundColor: WidgetStatePropertyAll(appColors.textPrimary),
      ),
    ),

    // ===== Selection controls =====
    checkboxTheme: CheckboxThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? appColors.primary
            : appColors.border,
      ),
      checkColor: WidgetStatePropertyAll(appColors.onPrimary),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
    ),
    radioTheme: RadioThemeData(
      fillColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? appColors.primary
            : appColors.border,
      ),
    ),
    switchTheme: SwitchThemeData(
      thumbColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? appColors.onPrimary
            : appColors.border,
      ),
      trackColor: WidgetStateProperty.resolveWith(
        (s) => s.contains(WidgetState.selected)
            ? appColors.primary
            : appColors.border,
      ),
    ),

    // ===== Lists =====
    listTileTheme: ListTileThemeData(
      dense: true,
      visualDensity: VisualDensity.compact,
      iconColor: appColors.textSecondary,
      textColor: appColors.textPrimary,
      // titleTextStyle: r.titleMediumTextStyle,
      // subtitleTextStyle: r.bodySmallTextStyle,
      contentPadding: EdgeInsets.zero,
    ),

    // ===== Chips =====
    chipTheme: baseTheme.chipTheme.copyWith(
      backgroundColor: appColors.surface,
      selectedColor: appColors.primary.withValues(alpha: 0.12),
      labelStyle: r.labelLargeTextStyle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      side: BorderSide(color: appColors.border),
    ),

    // ===== Navigation =====
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: appColors.surface,
      indicatorColor: appColors.primary.withValues(alpha: 0.12),
      labelTextStyle: WidgetStatePropertyAll(r.labelMediumTextStyle),
      elevation: 0,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: appColors.surface,
      selectedItemColor: appColors.primary,
      unselectedItemColor: appColors.textMuted,
      selectedLabelStyle: r.labelMediumTextStyle.copyWith(
        color: appColors.textPrimary,
      ),
      unselectedLabelStyle: r.labelMediumTextStyle.copyWith(
        color: appColors.textMuted,
      ),
      type: BottomNavigationBarType.fixed,
      elevation: 0,
    ),
    navigationRailTheme: NavigationRailThemeData(
      backgroundColor: appColors.surface,
      selectedIconTheme: IconThemeData(color: appColors.primary),
      unselectedIconTheme: IconThemeData(color: appColors.textSecondary),
      selectedLabelTextStyle: r.labelMediumTextStyle.copyWith(
        color: appColors.primary,
      ),
      unselectedLabelTextStyle: r.labelMediumTextStyle.copyWith(
        color: appColors.textSecondary,
      ),
      indicatorColor: appColors.primary.withValues(alpha: 0.12),
    ),
    navigationDrawerTheme: NavigationDrawerThemeData(
      backgroundColor: appColors.surface,
      surfaceTintColor: Colors.transparent,
      indicatorColor: appColors.primary.withValues(alpha: 0.12),
      elevation: 0,
    ),
    drawerTheme: DrawerThemeData(
      backgroundColor: appColors.surface,
      surfaceTintColor: Colors.transparent,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bottomAppBarTheme: BottomAppBarThemeData(
      color: appColors.surface,
      elevation: 0,
      surfaceTintColor: Colors.transparent,
      shape: const AutomaticNotchedShape(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.vertical(top: Radius.circular(16)),
        ),
      ),
    ),

    // ===== Tabs =====
    tabBarTheme: TabBarThemeData(
      labelStyle: r.titleMediumTextStyle,
      unselectedLabelStyle: r.titleMediumTextStyle.copyWith(
        color: appColors.textSecondary,
      ),
      labelColor: appColors.primary,
      unselectedLabelColor: appColors.textSecondary,
      indicatorSize: TabBarIndicatorSize.label,
      dividerColor: appColors.divider,
    ),

    // ===== Overlays =====
    dialogTheme: DialogThemeData(
      elevation: 0.6,
      insetPadding: const EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: appColors.surface,
      titleTextStyle: r.titleLargeTextStyle,
      contentTextStyle: r.bodyMediumTextStyle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
    ),
    bottomSheetTheme: BottomSheetThemeData(
      backgroundColor: appColors.surface,
      modalBackgroundColor: appColors.surface,
      showDragHandle: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    ),
    bannerTheme: MaterialBannerThemeData(
      backgroundColor: appColors.surface,
      contentTextStyle: r.bodyMediumTextStyle,
      padding: const EdgeInsets.all(16),
      elevation: 0,
    ),
    snackBarTheme: SnackBarThemeData(
      backgroundColor: appColors.onSurface,
      contentTextStyle: r.bodyMediumTextStyle.copyWith(
        color: appColors.surface,
      ),
      actionTextColor: appColors.primary,
      behavior: SnackBarBehavior.floating,
    ),
    tooltipTheme: TooltipThemeData(
      decoration: BoxDecoration(
        color: appColors.onSurface,
        borderRadius: BorderRadius.circular(8),
      ),
      textStyle: r.labelMediumTextStyle.copyWith(color: appColors.surface),
    ),
    popupMenuTheme: PopupMenuThemeData(
      color: appColors.surface,
      textStyle: r.bodyMediumTextStyle,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      elevation: 6,
    ),

    // ===== Pickers =====
    datePickerTheme: DatePickerThemeData(
      backgroundColor: appColors.surface,
      headerForegroundColor: appColors.textPrimary,
      headerBackgroundColor: appColors.surface,
      dayForegroundColor: WidgetStatePropertyAll(appColors.textPrimary),
      todayForegroundColor: WidgetStatePropertyAll(appColors.primary),
      rangePickerHeaderForegroundColor: appColors.textPrimary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      yearForegroundColor: WidgetStatePropertyAll(appColors.textPrimary),
      weekdayStyle: r.labelMediumTextStyle,
      dayStyle: r.bodyMediumTextStyle,
    ),
    timePickerTheme: TimePickerThemeData(
      backgroundColor: appColors.surface,
      hourMinuteTextColor: appColors.textPrimary,
      dialHandColor: appColors.primary,
      dialBackgroundColor: appColors.primary.withValues(alpha: 0.08),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      helpTextStyle: r.labelMediumTextStyle,
      hourMinuteTextStyle: r.titleLargeTextStyle,
    ),

    // ===== Text selection / Cursor =====
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: appColors.primary,
      selectionColor: appColors.primary.withValues(alpha: 0.25),
      selectionHandleColor: appColors.primary,
    ),

    // ===== Scrolling / Feedback =====
    scrollbarTheme: ScrollbarThemeData(
      thumbColor: WidgetStatePropertyAll(
        appColors.primary.withValues(alpha: 0.5),
      ),
      trackColor: WidgetStatePropertyAll(appColors.divider),
      radius: const Radius.circular(12),
      thickness: const WidgetStatePropertyAll(6),
    ),
    progressIndicatorTheme: ProgressIndicatorThemeData(
      color: appColors.primary,
      linearTrackColor: appColors.divider,
      circularTrackColor: appColors.divider,
    ),

    // ===== Sliders =====
    sliderTheme: SliderThemeData(
      activeTrackColor: appColors.primary,
      inactiveTrackColor: appColors.divider,
      thumbColor: appColors.primary,
      overlayColor: appColors.primary.withValues(alpha: 0.12),
      valueIndicatorTextStyle: r.labelSmallTextStyle.copyWith(
        color: appColors.onPrimary,
      ),
    ),

    // ===== Dividers / Icons =====
    dividerTheme: DividerThemeData(
      color: appColors.borderStrong,
      thickness: 1,
      space: 1,
    ),
    iconTheme: IconThemeData(color: appColors.onSurface,),

    // ===== Data / Lists =====
    expansionTileTheme: ExpansionTileThemeData(
      backgroundColor: appColors.surface,
      collapsedBackgroundColor: appColors.surface,
      textColor: appColors.textPrimary,
      collapsedTextColor: appColors.textPrimary,
      iconColor: appColors.primary,
      collapsedIconColor: appColors.textSecondary,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      collapsedShape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12),
      ),
    ),

    // ===== Badges (M3) =====
    badgeTheme: BadgeThemeData(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      backgroundColor: appColors.primary,
      textColor: appColors.onPrimary,
    ),
  );
}
