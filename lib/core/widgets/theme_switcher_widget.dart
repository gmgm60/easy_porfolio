 import 'package:easy_porfolio/core/theme/app_theme_types.dart';
import 'package:easy_porfolio/core/theme/extension/font_scaling_extension.dart';
import 'package:easy_porfolio/core/theme/extension/theme_accessors_extension.dart';
import 'package:easy_porfolio/features/theme/presentation/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart'; // 1. Import Riverpod

 /// An animated switch widget to toggle between light and dark themes.
 class ThemeSwitcherWidget extends ConsumerWidget {
   const ThemeSwitcherWidget({super.key});

   @override
   Widget build(BuildContext context, WidgetRef ref) {
     final themeMode = ref.watch(themeProvider);
     final colors = context.appColors;
     final radius = context.radiusTokens;

     final isDarkMode = themeMode == AppThemeType.dark;

     // Pill + knob colors (match your screenshots)
     final pillColor = isDarkMode
         ? colors.surface.withValues(alpha: 0.9)
         : Colors.white.withValues(alpha:0.95);

     final knobColor = colors.surface;

     // Icon colors in each state
     final sunActiveColor = colors.info; // on top of dark knob
     final sunInactiveColor =Colors.white.withValues(alpha:0.35);

     final moonActiveColor = colors.info; // on top of light bg
     final moonInactiveColor = colors.onSurface.withValues(alpha:0.35);


     return GestureDetector(
       onTap: () => ref.read(themeProvider.notifier).toggleTheme(),
       child: MouseRegion(
         cursor: SystemMouseCursors.click,
         child: AnimatedContainer(
           duration: const Duration(milliseconds: 260),
           curve: Curves.easeOutCubic,
           width: 72,
           height: 32,
           padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 4),
           decoration: BoxDecoration(
             borderRadius: radius.all24,
             color: pillColor,
             boxShadow: isDarkMode
                 ? []
                 : [
               BoxShadow(
                 color: Colors.black.withValues(alpha:0.06),
                 blurRadius: 18,
                 offset: const Offset(0, 10),
               ),
             ],
           ),
           child: Stack(
             alignment: Alignment.center,
             children: [
               // Knob
               AnimatedAlign(
                 duration: const Duration(milliseconds: 260),
                 curve: Curves.easeOutCubic,
                 alignment:
                 isDarkMode ? Alignment.centerRight : Alignment.centerLeft,
                 child: Container(
                   width: 24,
                   height: 24,
                   decoration: BoxDecoration(
                     shape: BoxShape.circle,
                     color: knobColor,
                   ),
                 ),
               ),
               // Icons layer
               Row(
                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
                 children: [
                   _Icon(
                     icon: Icons.wb_sunny_rounded,
                     isSelected: !isDarkMode,
                     activeColor: sunActiveColor,
                     inactiveColor: sunInactiveColor,
                   ),
                   _Icon(
                     icon: Icons.nightlight_round,
                     isSelected: isDarkMode,
                     activeColor: moonActiveColor,
                     inactiveColor: moonInactiveColor,
                   ),
                 ],
               ),
             ],
           ),
         ),
       ),
     );
   }
 }

 /// A private helper widget for the icons to handle animated styling.
 class _Icon extends StatelessWidget {
   const _Icon({
     required this.icon,
     required this.isSelected,
     required this.activeColor,
     required this.inactiveColor,
   });

   final IconData icon;
   final bool isSelected;
   final Color activeColor;
   final Color inactiveColor;

   @override
   Widget build(BuildContext context) {
     return AnimatedSwitcher(
       duration: const Duration(milliseconds: 200),
       switchInCurve: Curves.easeOutCubic,
       switchOutCurve: Curves.easeInCubic,
       child: Icon(
         icon,
         key: ValueKey<bool>(isSelected),
         size: 18.dp(context),
         color: isSelected ? activeColor : inactiveColor,
       ),
     );
   }
 }
