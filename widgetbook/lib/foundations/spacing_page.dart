import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

class SpacingPage extends StatelessWidget {
  const SpacingPage({super.key});

  // DESIGN.md §2: normal steps, edge cases, and values not used in the app.
  static const _normal = {
    'Space-M',
    'Space-L',
    'Space-XL',
    'Space-3XL',
    'Space-4XL',
  };
  static const _edge = {'Space-XXS', 'Space-XS', 'Space-S'};

  @override
  Widget build(BuildContext context) {
    const all = SampathSpacing.byFigmaName;
    List<Widget> rows(bool Function(String) where) => [
      for (final MapEntry(:key, :value) in all.entries)
        if (where(key)) _SpaceRow(name: key, value: value),
    ];
    return FoundationPage(
      title: 'Spacing',
      source: 'Alias Spacing & Radius › Spacing · DESIGN.md §2, §3.5',
      sections: [
        FoundationSection(
          title: 'Normal steps',
          children: rows(_normal.contains),
        ),
        FoundationSection(
          title: 'Edge cases only',
          children: rows(_edge.contains),
        ),
        FoundationSection(
          title: 'Not used inside the app (40 and up)',
          children: rows(
            (k) =>
                !_normal.contains(k) &&
                !_edge.contains(k) &&
                all[k]! >= SampathSpacing.x5l,
          ),
        ),
      ],
    );
  }
}

class _SpaceRow extends StatelessWidget {
  const _SpaceRow({required this.name, required this.value});

  final String name;
  final double value;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          width: SampathSpacing.x11l,
          child: TokenLabel(name, formatNumber(value)),
        ),
        Flexible(
          child: Container(
            // Capped so the 1024+ layout sizes still fit on screen.
            width: value,
            height: SampathSpacing.xl,
            color: context.colors.bgBrand,
          ),
        ),
      ],
    );
  }
}
