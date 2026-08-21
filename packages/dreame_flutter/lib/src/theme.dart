import 'package:flutter/material.dart';

import 'generated/tokens.g.dart';

@immutable
class DreameColors extends ThemeExtension<DreameColors> {
  const DreameColors({
    required this.page,
    required this.card,
    required this.elevated,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textDisabled,
    required this.brand,
    required this.brandSurface,
    required this.brandPressed,
    required this.brandDisabled,
    required this.brandText,
    required this.border,
    required this.borderFocus,
    required this.error,
    required this.inputDisabled,
    required this.backdrop,
  });

  final Color page,
      card,
      elevated,
      textPrimary,
      textSecondary,
      textTertiary,
      textDisabled;
  final Color brand, brandSurface, brandPressed, brandDisabled, brandText;
  final Color border, borderFocus, error, inputDisabled, backdrop;

  static const light = DreameColors(
    page: DreameSemanticLightTokens.backgroundPage,
    card: DreameSemanticLightTokens.backgroundCard,
    elevated: DreameSemanticLightTokens.backgroundElevated,
    textPrimary: DreameSemanticLightTokens.textPrimary,
    textSecondary: DreameSemanticLightTokens.textSecondary,
    textTertiary: DreameSemanticLightTokens.textTertiary,
    textDisabled: DreameSemanticLightTokens.textDisabled,
    brand: DreameSemanticLightTokens.brandDefault,
    brandSurface: DreameComponentLightTokens.buttonPrimaryBgDefault,
    brandPressed: DreameComponentLightTokens.buttonPrimaryBgPressed,
    brandDisabled: DreameComponentLightTokens.buttonPrimaryBgDisabled,
    brandText: DreameComponentLightTokens.buttonPrimaryTextDefault,
    border: DreameComponentLightTokens.inputBorderDefault,
    borderFocus: DreameComponentLightTokens.inputBorderFocus,
    error: DreameSemanticLightTokens.textError,
    inputDisabled: DreameComponentLightTokens.inputBgDisabled,
    backdrop: DreameSemanticLightTokens.backdropDefault,
  );
  static const dark = DreameColors(
    page: DreameSemanticDarkTokens.backgroundPage,
    card: DreameSemanticDarkTokens.backgroundCard,
    elevated: DreameSemanticDarkTokens.backgroundElevated,
    textPrimary: DreameSemanticDarkTokens.textPrimary,
    textSecondary: DreameSemanticDarkTokens.textSecondary,
    textTertiary: DreameSemanticDarkTokens.textTertiary,
    textDisabled: DreameSemanticDarkTokens.textDisabled,
    brand: DreameSemanticDarkTokens.brandDefault,
    brandSurface: DreameComponentDarkTokens.buttonPrimaryBgDefault,
    brandPressed: DreameComponentDarkTokens.buttonPrimaryBgPressed,
    brandDisabled: DreameComponentDarkTokens.buttonPrimaryBgDisabled,
    brandText: DreameComponentDarkTokens.buttonPrimaryTextDefault,
    border: DreameComponentDarkTokens.inputBorderDefault,
    borderFocus: DreameComponentDarkTokens.inputBorderFocus,
    error: DreameSemanticDarkTokens.textError,
    inputDisabled: DreameComponentDarkTokens.inputBgDisabled,
    backdrop: DreameSemanticDarkTokens.backdropDefault,
  );

  @override
  DreameColors copyWith({
    Color? page,
    Color? card,
    Color? elevated,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textDisabled,
    Color? brand,
    Color? brandSurface,
    Color? brandPressed,
    Color? brandDisabled,
    Color? brandText,
    Color? border,
    Color? borderFocus,
    Color? error,
    Color? inputDisabled,
    Color? backdrop,
  }) =>
      DreameColors(
        page: page ?? this.page,
        card: card ?? this.card,
        elevated: elevated ?? this.elevated,
        textPrimary: textPrimary ?? this.textPrimary,
        textSecondary: textSecondary ?? this.textSecondary,
        textTertiary: textTertiary ?? this.textTertiary,
        textDisabled: textDisabled ?? this.textDisabled,
        brand: brand ?? this.brand,
        brandSurface: brandSurface ?? this.brandSurface,
        brandPressed: brandPressed ?? this.brandPressed,
        brandDisabled: brandDisabled ?? this.brandDisabled,
        brandText: brandText ?? this.brandText,
        border: border ?? this.border,
        borderFocus: borderFocus ?? this.borderFocus,
        error: error ?? this.error,
        inputDisabled: inputDisabled ?? this.inputDisabled,
        backdrop: backdrop ?? this.backdrop,
      );

  @override
  DreameColors lerp(covariant DreameColors? other, double t) {
    if (other == null) return this;
    return DreameColors(
      page: Color.lerp(page, other.page, t)!,
      card: Color.lerp(card, other.card, t)!,
      elevated: Color.lerp(elevated, other.elevated, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      brand: Color.lerp(brand, other.brand, t)!,
      brandSurface: Color.lerp(brandSurface, other.brandSurface, t)!,
      brandPressed: Color.lerp(brandPressed, other.brandPressed, t)!,
      brandDisabled: Color.lerp(brandDisabled, other.brandDisabled, t)!,
      brandText: Color.lerp(brandText, other.brandText, t)!,
      border: Color.lerp(border, other.border, t)!,
      borderFocus: Color.lerp(borderFocus, other.borderFocus, t)!,
      error: Color.lerp(error, other.error, t)!,
      inputDisabled: Color.lerp(inputDisabled, other.inputDisabled, t)!,
      backdrop: Color.lerp(backdrop, other.backdrop, t)!,
    );
  }
}

class DreameTheme {
  const DreameTheme._();
  static ThemeData light() => _make(Brightness.light, DreameColors.light);
  static ThemeData dark() => _make(Brightness.dark, DreameColors.dark);
  static ThemeData _make(Brightness brightness, DreameColors colors) =>
      ThemeData(
        brightness: brightness,
        scaffoldBackgroundColor: colors.page,
        fontFamily: 'PingFang SC',
        colorScheme: ColorScheme.fromSeed(
          seedColor: colors.brand,
          brightness: brightness,
          surface: colors.card,
          error: colors.error,
        ),
        extensions: <ThemeExtension<dynamic>>[colors],
      );
}

extension DreameThemeContext on BuildContext {
  DreameColors get dreameColors =>
      Theme.of(this).extension<DreameColors>() ??
      (Theme.of(this).brightness == Brightness.dark
          ? DreameColors.dark
          : DreameColors.light);
}
