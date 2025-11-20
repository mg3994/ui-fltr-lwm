import 'package:flex_color_scheme/flex_color_scheme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'brand_theme.dart' show BrandTheme;

/// Central theme configuration for the app.
/// Provides light and dark ThemeData using FlexColorScheme and Google Fonts.
abstract final class AppTheme {
  // Private constructor to prevent instantiation.
  const AppTheme._();

  // Default fallback scheme.
  static const FlexScheme _defaultScheme = FlexScheme.material;

  /// Helper to get the primary brand color based on brightness and optional custom scheme.
  static Color _getPrimaryColor({
    required Brightness brightness,
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    if (flexSchemeEnum == FlexScheme.custom) {
      return flexSchemeColor?.primary ??
          _defaultScheme.colors(brightness).primary;
    }
    return (flexSchemeEnum ?? _defaultScheme).colors(brightness).primary;
  }

  /// Light theme data.
  static ThemeData light({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    return FlexThemeData.light(
      colors: (flexSchemeEnum == FlexScheme.custom) ? flexSchemeColor : null,
      scheme: (flexSchemeEnum != FlexScheme.custom) ? flexSchemeEnum : null,
      subThemesData: const FlexSubThemesData(
        interactionEffects: true,
        tintedDisabledControls: true,
        useM2StyleDividerInM3: true,
        inputDecoratorIsFilled: true,
        inputDecoratorBorderType: FlexInputBorderType.outline,
        alignedDropdown: true,
        navigationRailUseIndicator: true,
      ),
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      // Apply premium font.
      textTheme: GoogleFonts.interTextTheme(),
      primaryTextTheme: GoogleFonts.interTextTheme(),
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
  }

  /// Dark theme data.
  static ThemeData dark({
    FlexSchemeColor? flexSchemeColor,
    FlexScheme? flexSchemeEnum,
  }) {
    return FlexThemeData.dark(
      colors: (flexSchemeEnum == FlexScheme.custom) ? flexSchemeColor : null,
      scheme: (flexSchemeEnum != FlexScheme.custom) ? flexSchemeEnum : null,
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
      visualDensity: FlexColorScheme.comfortablePlatformDensity,
      cupertinoOverrideTheme: const CupertinoThemeData(applyThemeToAll: true),
      // Apply premium font for dark mode.
      textTheme: GoogleFonts.interTextTheme(ThemeData.dark().textTheme),
      primaryTextTheme: GoogleFonts.interTextTheme(
        ThemeData.dark().primaryTextTheme,
      ),
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
}
