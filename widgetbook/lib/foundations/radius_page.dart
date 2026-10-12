import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

class RadiusPage extends StatelessWidget {
  const RadiusPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return FoundationPage(
      title: 'Radius',
      source: 'Alias Spacing & Radius › Radius · DESIGN.md §3.6',
      sections: [
        FoundationSection(
          title: 'Scale',
          wrap: true,
          children: [
            for (final MapEntry(:key, :value)
                in SampathRadius.byFigmaName.entries)
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: SampathSpacing.x9l,
                    height: SampathSpacing.x9l,
                    decoration: BoxDecoration(
                      color: colors.bgSecondary,
                      border: Border.all(color: colors.borderActive),
                      borderRadius: BorderRadius.circular(value),
                    ),
                  ),
                  const SizedBox(height: SampathSpacing.s),
                  TokenLabel(key, formatNumber(value)),
                ],
              ),
          ],
        ),
      ],
    );
  }
}
