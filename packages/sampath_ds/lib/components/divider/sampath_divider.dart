import 'package:flutter/widgets.dart';

import '../../tokens/sampath_colors.dart';

/// Figma `Type` of `Divider`: the line's thickness.
///
/// Thicknesses are component sizes, not spacing (DESIGN.md §9.2).
enum SampathDividerType {
  /// `Divider` · 1 px line between items.
  divider(1),

  /// `Section Divider` · 8 px band between sections.
  section(8);

  const SampathDividerType(this.thickness);

  final double thickness;
}

/// A full-width `border-default` line: `Divider` (DESIGN.md §9.2).
///
/// ```dart
/// SampathDivider()                                   // between items
/// SampathDivider(type: SampathDividerType.section)   // between sections
/// ```
///
/// Takes the width of its parent. Decorative: not read by screen readers.
class SampathDivider extends StatelessWidget {
  const SampathDivider({super.key, this.type = SampathDividerType.divider});

  final SampathDividerType type;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: double.infinity,
    height: type.thickness,
    child: ColoredBox(color: context.colors.borderDefault),
  );
}
