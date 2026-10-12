import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

/// Light and Dark themes for the catalogue canvas. Registers the semantic
/// colors so `context.colors` works in every use case.
abstract final class CatalogueTheme {
  static final ThemeData light = _build(Brightness.light, SampathColors.light);
  static final ThemeData dark = _build(Brightness.dark, SampathColors.dark);

  static ThemeData _build(Brightness brightness, SampathColors colors) {
    return ThemeData(
      brightness: brightness,
      extensions: [colors],
      scaffoldBackgroundColor: colors.bgPrimary,
      textTheme: TextTheme(
        bodyMedium: SampathTextStyles.bodyMedium.copyWith(
          color: colors.textPrimary,
        ),
      ),
    );
  }
}
