import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

/// Sample phrases for checking line height per script.
enum SampleLanguage {
  english('English', 'The quick brown fox jumps over the lazy dog'),
  // "Welcome to Sampath Bank of Sri Lanka". ශ්‍රී stacks tall above and
  // below; ු / ී test the marks under and over the line.
  sinhala('Sinhala', 'ශ්‍රී ලංකාවේ සම්පත් බැංකුවට සාදරයෙන් පිළිගනිමු'),
  // "Hello! Welcome to Sampath Bank". ி / ு / ோ test marks around the base.
  tamil('Tamil', 'வணக்கம்! சம்பத் வங்கிக்கு உங்களை வரவேற்கிறோம்');

  const SampleLanguage(this.label, this.phrase);

  final String label;
  final String phrase;
}

class TypographyPage extends StatelessWidget {
  TypographyPage({super.key, String? sample})
    : sample = sample ?? defaultSample;

  static final defaultSample = SampleLanguage.english.phrase;

  /// Sample text, driven by the Language and Custom text knobs.
  final String sample;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    // Catalogue only: bgActive is too dark a band in Dark mode, so use the
    // lighter bgActiveHover there. Components never branch on theme.
    final band = Theme.of(context).brightness == Brightness.dark
        ? colors.bgActiveHover
        : colors.bgActive;
    final groups = <String, List<MapEntry<String, TextStyle>>>{};
    for (final entry in SampathTextStyles.byFigmaName.entries) {
      groups.putIfAbsent(entry.key.split('/').first, () => []).add(entry);
    }
    return FoundationPage(
      title: 'Typography',
      source:
          'Hanken Grotesk · ${SampathTextStyles.byFigmaName.length} text '
          'styles · DESIGN.md §3.4 · tinted band = line height',
      sections: [
        for (final MapEntry(key: group, value: styles) in groups.entries)
          FoundationSection(
            title: group,
            children: [
              for (final MapEntry(key: name, value: style) in styles)
                _StyleSample(
                  name: name,
                  style: style.copyWith(color: colors.textPrimary),
                  sample: sample,
                  band: band,
                ),
            ],
          ),
      ],
    );
  }
}

class _StyleSample extends StatelessWidget {
  const _StyleSample({
    required this.name,
    required this.style,
    required this.sample,
    required this.band,
  });

  final String name;
  final TextStyle style;
  final String sample;
  final Color band;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TokenLabel(name, _spec(style)),
        const SizedBox(height: SampathSpacing.xs),
        // Single line.
        ColoredBox(
          color: band,
          child: Text(
            sample,
            style: style,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        const SizedBox(height: SampathSpacing.m),
        // Two lines, wrapped at the phone content width (375 − 2 × 16), to
        // show the spacing between lines.
        ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: SampathSpacing.x12l),
          child: ColoredBox(
            color: band,
            child: Text(
              '$sample $sample',
              style: style,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ),
      ],
    );
  }

  static String _spec(TextStyle s) {
    final size = s.fontSize!;
    final lineHeight = double.parse((size * s.height!).toStringAsFixed(2));
    return '${s.fontWeight!.value} · ${formatNumber(size)} / '
        '${formatNumber(lineHeight)}';
  }
}
