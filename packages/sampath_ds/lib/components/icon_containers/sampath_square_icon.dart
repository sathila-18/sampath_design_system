import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icon_data.dart';
import '../../tokens/sampath_colors.dart';
import '../../tokens/sampath_radius.dart';
import 'icon_container.dart';

/// Figma `Size` of `Square Icon`: box, radius and icon size.
enum SampathSquareIconSize {
  /// 24 × 24, `Radius-S`, `16px` icon.
  xSmall(24, SampathRadius.s, SampathIconSize.s16),

  /// 42 × 42, `Radius-M`, `20px` icon.
  small(42, SampathRadius.m, SampathIconSize.s20),

  /// 50 × 50, `Radius-M`, `24px` icon.
  medium(50, SampathRadius.m, SampathIconSize.s24),

  /// 64 × 64, `Radius-L`, `36px` icon.
  large(64, SampathRadius.l, SampathIconSize.s36);

  const SampathSquareIconSize(this.dimension, this.radius, this.iconSize);

  final double dimension;
  final double radius;
  final SampathIconSize iconSize;
}

/// Figma `State` of `Square Icon`.
enum SampathSquareIconState { brand, success, error, warning, info }

/// Icon on a rounded square: `Square Icon` (DESIGN.md §9.1).
///
/// ```dart
/// SampathSquareIcon(SampathIcons.checkCircle,
///     size: SampathSquareIconSize.medium,
///     state: SampathSquareIconState.success)
/// ```
///
/// Any registry icon fits, including brand icons (which keep their colors).
class SampathSquareIcon extends StatelessWidget {
  const SampathSquareIcon(
    this.icon, {
    super.key,
    this.size = SampathSquareIconSize.medium,
    this.state = SampathSquareIconState.brand,
    this.semanticLabel,
  });

  final SampathIconData icon;
  final SampathSquareIconSize size;
  final SampathSquareIconState state;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (background, iconColor) = switch (state) {
      SampathSquareIconState.brand => (c.bgIcons, SampathIconColor.brand),
      SampathSquareIconState.success => (c.bgSuccess, SampathIconColor.success),
      SampathSquareIconState.error => (c.bgError, SampathIconColor.error),
      SampathSquareIconState.warning => (c.bgWarning, SampathIconColor.warning),
      SampathSquareIconState.info => (c.bgInfo, SampathIconColor.info),
    };
    return IconContainer(
      dimension: size.dimension,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(size.radius),
      ),
      background: background,
      icon: icon,
      iconSize: size.iconSize,
      iconColor: iconColor,
      semanticLabel: semanticLabel,
    );
  }
}
