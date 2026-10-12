import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icon_data.dart';
import '../../tokens/sampath_colors.dart';
import 'icon_container.dart';

/// Figma `Size` of `Circle Icon`.
enum SampathCircleIconSize {
  /// 36 × 36, `16px` icon.
  small(36, SampathIconSize.s16),

  /// 56 × 56, `24px` icon.
  large(56, SampathIconSize.s24);

  const SampathCircleIconSize(this.dimension, this.iconSize);

  final double dimension;
  final SampathIconSize iconSize;
}

/// Icon on a `bg-secondary` circle: `Circle Icon` (DESIGN.md §9.1).
///
/// No shadow: Figma's `Shadow/Resting_cards` is to be removed (§10 #19).
/// Any registry icon fits, including brand icons (which keep their colors).
class SampathCircleIcon extends StatelessWidget {
  const SampathCircleIcon(
    this.icon, {
    super.key,
    this.size = SampathCircleIconSize.large,
    this.semanticLabel,
  });

  final SampathIconData icon;
  final SampathCircleIconSize size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => IconContainer(
    dimension: size.dimension,
    // Radius-Full.
    shape: const CircleBorder(),
    background: context.colors.bgSecondary,
    icon: icon,
    iconSize: size.iconSize,
    iconColor: SampathIconColor.brand,
    semanticLabel: semanticLabel,
  );
}
