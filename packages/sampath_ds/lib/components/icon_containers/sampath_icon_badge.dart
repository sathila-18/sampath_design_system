import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icon_data.dart';
import '../../tokens/sampath_colors.dart';
import 'icon_container.dart';
import 'sampath_octagon_border.dart';

/// Figma `State` of `46px bg` and `68px bg`.
///
/// `success` is Figma's `Positive` in `46px bg` (DESIGN.md §10 #8).
enum SampathIconBadgeState {
  primary,
  secondary,
  disabled,
  success,
  error,
  info,
  warning,
}

/// Icon in the brand octagon: `46px bg` and `68px bg` (DESIGN.md §9.1).
///
/// ```dart
/// SampathIconBadge.medium(SampathIcons.wallet,
///     state: SampathIconBadgeState.success)
/// ```
///
/// Any registry icon fits, including brand icons (which keep their colors).
class SampathIconBadge extends StatelessWidget {
  /// `46px bg`: 42 × 42 octagon, `24px` icon.
  const SampathIconBadge.medium(
    this.icon, {
    super.key,
    this.state = SampathIconBadgeState.primary,
    this.semanticLabel,
  }) : _dimension = 42,
       _iconSize = SampathIconSize.s24;

  /// `68px bg`: 68 × 68 octagon, `36px` icon.
  const SampathIconBadge.large(
    this.icon, {
    super.key,
    this.state = SampathIconBadgeState.primary,
    this.semanticLabel,
  }) : _dimension = 68,
       _iconSize = SampathIconSize.s36;

  final SampathIconData icon;
  final SampathIconBadgeState state;
  final String? semanticLabel;
  final double _dimension;
  final SampathIconSize _iconSize;

  @override
  Widget build(BuildContext context) {
    final c = context.colors;
    final (background, iconColor) = switch (state) {
      SampathIconBadgeState.primary => (c.bgIcons, SampathIconColor.brand),
      SampathIconBadgeState.secondary => (
        c.bgIcons,
        SampathIconColor.secondary,
      ),
      SampathIconBadgeState.disabled => (
        c.bgDisabled,
        SampathIconColor.disabledOnBg,
      ),
      SampathIconBadgeState.success => (c.fgSuccess, SampathIconColor.inverse),
      SampathIconBadgeState.error => (c.fgError, SampathIconColor.inverse),
      SampathIconBadgeState.info => (c.fgInfo, SampathIconColor.inverse),
      SampathIconBadgeState.warning => (c.fgWarning, SampathIconColor.inverse),
    };
    return IconContainer(
      dimension: _dimension,
      shape: const SampathOctagonBorder(),
      background: background,
      icon: icon,
      iconSize: _iconSize,
      iconColor: iconColor,
      semanticLabel: semanticLabel,
    );
  }
}
