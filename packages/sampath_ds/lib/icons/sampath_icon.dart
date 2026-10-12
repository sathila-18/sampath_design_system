import 'package:flutter/widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../tokens/sampath_colors.dart';
import 'sampath_icon_data.dart';

/// Icon sizes from the Figma `Icon sizes` page (DESIGN.md §9.1).
///
/// These five are the only sizes allowed. They are component sizes, not
/// spacing, so they live here rather than in the token scale (36 has no
/// spacing token).
enum SampathIconSize {
  /// `16px` · tags, chips, helper text, checkbox tick. Figma stroke 1.
  s16(16),

  /// `20px` · small buttons, list, bottom nav.
  s20(20),

  /// `24px` · default. Buttons, header, inputs.
  s24(24),

  /// `36px` · large square icons, bottom sheet.
  s36(36),

  /// `48px` · spinner, face scan.
  s48(48);

  const SampathIconSize(this.dimension);

  final double dimension;
}

/// Icon colors. The first seven are the Figma `State` variant (DESIGN.md
/// §9.1); the rest are the other `fg-*` tokens that component specs use.
///
/// Ignored for brand icons and partner logos.
enum SampathIconColor {
  // Figma `State` variants.
  primary,
  secondary,
  disabled,
  success,
  error,
  info,
  warning,

  // Other fg-* tokens.
  brand,
  placeholder,
  active,
  disabledOnBg,
  inverse,
  darkBoth,
  whiteBoth,
  action,
  actionPressed,
  gold;

  Color resolve(SampathColors c) => switch (this) {
    primary => c.fgPrimary,
    secondary => c.fgSecondary,
    disabled => c.fgDisabled,
    success => c.fgSuccess,
    error => c.fgError,
    info => c.fgInfo,
    warning => c.fgWarning,
    brand => c.fgBrand,
    placeholder => c.fgPlaceholder,
    active => c.fgActive,
    disabledOnBg => c.fgDisabledOnBg,
    inverse => c.fgInverse,
    darkBoth => c.fgDarkBoth,
    whiteBoth => c.fgWhiteBoth,
    action => c.fgAction,
    actionPressed => c.fgActionPressed,
    gold => c.fgGold,
  };
}

/// The one way to show an icon (DESIGN.md §6.2).
///
/// ```dart
/// SampathIcon(SampathIcons.lock, size: SampathIconSize.s24,
///     color: SampathIconColor.secondary, semanticLabel: 'Locked')
/// ```
///
/// Without [semanticLabel] the icon is decorative and hidden from screen
/// readers. Pass a label whenever the icon carries meaning on its own.
class SampathIcon extends StatelessWidget {
  const SampathIcon(
    this.icon, {
    super.key,
    this.size = SampathIconSize.s24,
    this.color = SampathIconColor.primary,
    this.semanticLabel,
  });

  final SampathIconData icon;
  final SampathIconSize size;

  /// Utility icons only. Brand icons and partner logos keep their colors.
  final SampathIconColor color;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final dimension = size.dimension;
    final Widget artwork = switch (icon) {
      SampathUtilityIcon(:final builder) => builder(
        color.resolve(context.colors),
        dimension,
      ),
      SampathAssetIcon(:final assetPath) => SvgPicture.asset(
        assetPath,
        package: 'sampath_ds',
        width: dimension,
        height: dimension,
      ),
    };
    final box = SizedBox.square(dimension: dimension, child: artwork);
    final label = semanticLabel;
    if (label == null) return ExcludeSemantics(child: box);
    return Semantics(
      label: label,
      image: true,
      child: ExcludeSemantics(child: box),
    );
  }
}
