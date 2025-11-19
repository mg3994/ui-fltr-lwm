import 'package:flutter/material.dart'
    show BuildContext, Color, Theme, ThemeExtension;

/// A theme Extension example with a single custom brand color property.
///
/// You can add as many colors and other theme properties as you need, and
/// you can add multiple different ThemeExtension sub classes as well.
class BrandTheme extends ThemeExtension<BrandTheme> {
  const BrandTheme({required this.isDarkThemeMode, required this.brandColor});
  final Color brandColor;
  final bool isDarkThemeMode;

  static BrandTheme of(BuildContext context) {
    return Theme.of(context).extension<BrandTheme>()!;
  }

  // You must override the copyWith method.
  @override
  BrandTheme copyWith({Color? brandColor, bool? isDarkThemeMode}) => BrandTheme(
    brandColor: brandColor ?? this.brandColor,
    isDarkThemeMode: isDarkThemeMode ?? this.isDarkThemeMode,
  );

  // You must override the lerp method.
  @override
  BrandTheme lerp(ThemeExtension<BrandTheme>? other, double t) {
    if (other is! BrandTheme) {
      return this;
    }
    return BrandTheme(
      brandColor: Color.lerp(brandColor, other.brandColor, t)!,
      isDarkThemeMode: other.isDarkThemeMode,
    );
  }
}
