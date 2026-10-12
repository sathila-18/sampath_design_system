import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

class GradientsPage extends StatelessWidget {
  const GradientsPage({super.key});

  // Square, wide and tall: the Figma transform keeps the direction right at
  // every aspect ratio.
  static const _sizes = [
    Size(SampathSpacing.x11l, SampathSpacing.x11l),
    Size(SampathSpacing.x12l, SampathSpacing.x11l),
    Size(SampathSpacing.x9l, SampathSpacing.x11l + SampathSpacing.x9l),
  ];

  @override
  Widget build(BuildContext context) {
    return FoundationPage(
      title: 'Gradients',
      source:
          'Color styles · DESIGN.md §4.2 · same in Light and Dark · '
          'direction from the Figma gradient transform',
      sections: [
        for (final MapEntry(:key, :value)
            in SampathGradients.byFigmaName.entries)
          FoundationSection(
            title: key,
            wrap: true,
            children: [
              for (final size in _sizes)
                Container(
                  width: size.width,
                  height: size.height,
                  decoration: BoxDecoration(
                    gradient: value,
                    borderRadius: BorderRadius.circular(SampathRadius.l),
                  ),
                ),
              if (key == 'Vermilion')
                const TokenLabel(
                  '⚠️ Off-brand stops',
                  '#f26722 → #dc5e1f · design to update (DESIGN.md §10 #2)',
                ),
            ],
          ),
      ],
    );
  }
}
