import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

class LayoutPage extends StatelessWidget {
  const LayoutPage({super.key});

  @override
  Widget build(BuildContext context) {
    final groups = <String, List<MapEntry<String, double>>>{};
    for (final entry in SampathLayout.byFigmaName.entries) {
      groups.putIfAbsent(entry.key.split('/').first, () => []).add(entry);
    }
    return FoundationPage(
      title: 'Layout',
      source: 'Component collection › Mobile · DESIGN.md §2, §3.7',
      sections: [
        for (final MapEntry(key: group, value: tokens) in groups.entries)
          FoundationSection(
            title: group,
            children: [
              for (final MapEntry(:key, :value) in tokens)
                Row(
                  children: [
                    // Fixed column so labels line up whatever the value.
                    SizedBox(
                      width: SampathSpacing.x5l,
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Container(
                          width: value,
                          height: SampathSpacing.x3l,
                          color: context.colors.bgBrand,
                        ),
                      ),
                    ),
                    const SizedBox(width: SampathLayout.iconText),
                    Expanded(
                      child: TokenLabel(
                        key.split('/').last,
                        formatNumber(value) +
                            (key == 'Layout/section-gap_large'
                                ? ' · not used yet'
                                : ''),
                      ),
                    ),
                  ],
                ),
            ],
          ),
      ],
    );
  }
}
