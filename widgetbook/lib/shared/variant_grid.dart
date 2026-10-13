import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import '../foundations/foundation_page.dart';

/// A variants table: a header row of [columns], then one labeled row per
/// entry in [rows]. Used by the "Sizes × …" use cases.
class VariantGrid extends StatelessWidget {
  const VariantGrid({
    super.key,
    required this.title,
    required this.source,
    required this.columns,
    required this.rows,
    this.columnWidth = SampathSpacing.x9l,
  });

  final String title;
  final String source;
  final List<String> columns;
  final List<(String, List<Widget>)> rows;

  /// Width of each variant column; fits the widest cell.
  final double columnWidth;

  @override
  Widget build(BuildContext context) {
    final caption = SampathTextStyles.captionLarge.copyWith(
      color: context.colors.textSecondary,
    );
    return FoundationPage(
      title: title,
      source: '$source · switch Light / Dark with the Theme addon',
      sections: [
        FoundationSection(
          title: 'Grid',
          children: [
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Table(
                defaultColumnWidth: FixedColumnWidth(columnWidth),
                defaultVerticalAlignment: TableCellVerticalAlignment.middle,
                children: [
                  TableRow(
                    children: [
                      const SizedBox.shrink(),
                      for (final c in columns) Text(c, style: caption),
                    ],
                  ),
                  for (final (label, cells) in rows)
                    TableRow(
                      children: [
                        Text(label, style: caption),
                        for (final cell in cells)
                          Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: SampathSpacing.m,
                            ),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: cell,
                            ),
                          ),
                      ],
                    ),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
