import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'brand_theme.dart' show BrandTheme;

abstract final class AppTheme {
  const AppTheme();

  // Define a sensible default scheme for fallback when no parameter is provided
  static const FlexScheme _defaultScheme = FlexScheme.material;

  // Helper to determine the primary color for the BrandTheme extension
  static Color _getPrimaryColor({
    required Brightness brightness,
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    // If custom is selected, use the custom primary color
    if (flexSchemeEnum == FlexScheme.custom) {
      return flexSchemeColor?.primary ??
          _defaultScheme.colors(brightness).primary;
    }
    // Otherwise, use the enum's primary color, falling back to default
    return (flexSchemeEnum ?? _defaultScheme).colors(brightness).primary;
  }

  // The FlexColorScheme defined light mode ThemeData.
  static ThemeData light({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) => FlexThemeData.light(
    // Use custom colors ONLY if the switch is set to FlexScheme.custom
    colors: (flexSchemeEnum == FlexScheme.custom) ? flexSchemeColor : null,
    // Use enum ONLY if the switch is NOT set to FlexScheme.custom (or is null)
    scheme: (flexSchemeEnum != FlexScheme.custom) ? flexSchemeEnum : null,
    // Component theme configurations for light mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    extensions: <BrandTheme>[
      BrandTheme(
        isDarkThemeMode: false,
        brandColor: _getPrimaryColor(
          brightness: Brightness.light,
          flexSchemeColor: flexSchemeColor,
          flexSchemeEnum: flexSchemeEnum,
        ),
      ),
    ],
  );

  // The FlexColorScheme defined dark mode ThemeData.
  static ThemeData dark({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) => FlexThemeData.dark(
    // Use custom colors ONLY if the switch is set to FlexScheme.custom
    colors: (flexSchemeEnum == FlexScheme.custom) ? flexSchemeColor : null,
    // Use enum ONLY if the switch is NOT set to FlexScheme.custom (or is null)
    scheme: (flexSchemeEnum != FlexScheme.custom) ? flexSchemeEnum : null,
    // Component theme configurations for dark mode.
    subThemesData: const FlexSubThemesData(
      interactionEffects: true,
      tintedDisabledControls: true,
      blendOnColors: true,
      useM2StyleDividerInM3: true,
      inputDecoratorIsFilled: true,
      inputDecoratorBorderType: FlexInputBorderType.outline,
      alignedDropdown: true,
      navigationRailUseIndicator: true,
    ),
    // Direct ThemeData properties.
    visualDensity: FlexColorScheme.comfortablePlatformDensity,
    cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
    extensions: <BrandTheme>[
      BrandTheme(
        isDarkThemeMode: true,
        brandColor: _getPrimaryColor(
          brightness: Brightness.dark,
          flexSchemeColor: flexSchemeColor,
          flexSchemeEnum: flexSchemeEnum,
        ),
      ),
    ],
  );
}
