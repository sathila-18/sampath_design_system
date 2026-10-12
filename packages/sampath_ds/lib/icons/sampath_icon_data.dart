import 'package:flutter/widgets.dart';

/// Builds a utility icon at [size] in [color].
typedef SampathIconBuilder = Widget Function(Color color, double size);

/// An entry in the [SampathIcons] registry. Pass it to `SampathIcon`.
@immutable
sealed class SampathIconData {
  const SampathIconData(this.figmaName);

  /// The icon's name in Figma, e.g. `nav-arrow-down` or `assistant`.
  final String figmaName;
}

/// A line icon recolored per use with an `fg-*` token (Iconoir today).
final class SampathUtilityIcon extends SampathIconData {
  const SampathUtilityIcon(super.figmaName, this.builder);

  final SampathIconBuilder builder;
}

/// Where an asset icon comes from. Neither kind is ever recolored.
enum SampathAssetIconKind {
  /// Sampath pictogram from the brand icon file.
  brand,

  /// Third-party logo. Follow the owner's brand rules.
  partner,
}

/// A full-color SVG shipped in `assets/icons/`.
final class SampathAssetIcon extends SampathIconData {
  const SampathAssetIcon(super.figmaName, this.kind, this.assetPath);

  final SampathAssetIconKind kind;

  /// Path inside the sampath_ds package.
  final String assetPath;
}
