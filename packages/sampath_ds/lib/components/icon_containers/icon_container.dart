import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icon_data.dart';

/// Shared body of the icon containers: a filled [shape] with [icon] centered.
///
/// Internal. Use `SampathIconBadge`, `SampathSquareIcon` or
/// `SampathCircleIcon`.
class IconContainer extends StatelessWidget {
  const IconContainer({
    super.key,
    required this.dimension,
    required this.shape,
    required this.background,
    required this.icon,
    required this.iconSize,
    required this.iconColor,
    this.semanticLabel,
  });

  final double dimension;
  final ShapeBorder shape;
  final Color background;
  final SampathIconData icon;
  final SampathIconSize iconSize;
  final SampathIconColor iconColor;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => SizedBox.square(
    dimension: dimension,
    child: DecoratedBox(
      decoration: ShapeDecoration(color: background, shape: shape),
      child: Center(
        child: SampathIcon(
          icon,
          size: iconSize,
          color: iconColor,
          semanticLabel: semanticLabel,
        ),
      ),
    ),
  );
}
