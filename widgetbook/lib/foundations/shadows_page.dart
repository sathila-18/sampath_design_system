import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

import 'foundation_page.dart';

class ShadowsPage extends StatelessWidget {
  const ShadowsPage({super.key});

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    Widget card(List<BoxShadow> shadows) => Container(
      width: SampathSpacing.x11l + SampathSpacing.x5l,
      height: SampathSpacing.x9l,
      decoration: BoxDecoration(
        color: colors.bgSecondary,
        borderRadius: BorderRadius.circular(SampathRadius.l),
        boxShadow: shadows,
      ),
    );
    Widget item(String name, String detail, Widget sample) => Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        sample,
        const SizedBox(height: SampathSpacing.l),
        TokenLabel(name, detail),
      ],
    );

    return FoundationPage(
      title: 'Shadows',
      source: 'Effect styles · DESIGN.md §4.3 · same in Light and Dark',
      sections: [
        FoundationSection(
          title: 'Effect styles',
          wrap: true,
          children: [
            item(
              'Shadow/Resting_cards',
              '0, 1, 3 · #000 5%',
              card(SampathShadows.restingCards),
            ),
            item(
              'Shadow/Panel_sheets',
              '0, 2, 10 · #000 4%',
              card(SampathShadows.panelSheets),
            ),
            item(
              'Shadow/Sticky',
              '0, −2, 16 · #221f1f 8%',
              card(SampathShadows.sticky),
            ),
            item(
              'Shadow/Back',
              'drop 0, 2, 10 · inner 0, 1, 0 white 40%',
              const _BackCircle(),
            ),
          ],
        ),
        FoundationSection(
          title: 'Shadow/Floating_nav-search',
          children: [
            const TokenLabel(
              'Two drops + background blur 20 (σ 10)',
              'Over a busy background to show the blur',
            ),
            const SizedBox(height: SampathSpacing.l),
            const _FloatingSample(),
          ],
        ),
      ],
    );
  }
}

class _BackCircle extends StatelessWidget {
  const _BackCircle();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Container(
      width: SampathSpacing.x6l,
      height: SampathSpacing.x6l,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: colors.bgSecondary,
        border: Border.all(color: colors.alphaBorder),
        boxShadow: SampathShadows.back,
      ),
      child: CustomPaint(
        foregroundPainter: const SampathInnerShadowPainter(
          shape: CircleBorder(),
          shadows: SampathShadows.backInner,
        ),
        child: const SizedBox.expand(),
      ),
    );
  }
}

class _FloatingSample extends StatelessWidget {
  const _FloatingSample();

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return SizedBox(
      height: SampathSpacing.x10l + SampathSpacing.x6l,
      child: Stack(
        children: [
          // Busy background: stripes of brand and status colors.
          Positioned.fill(
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                for (final c in [
                  colors.bgBrand,
                  colors.fgInfo,
                  colors.fgSuccess,
                  colors.fgWarning,
                  colors.fgError,
                  colors.bgBrand,
                ])
                  Expanded(child: ColoredBox(color: c)),
              ],
            ),
          ),
          Center(
            child: Container(
              width: SampathSpacing.x12l,
              height: SampathSpacing.x8l,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(SampathRadius.full),
                boxShadow: SampathShadows.floatingNavSearch,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(SampathRadius.full),
                child: BackdropFilter(
                  filter: SampathShadows.floatingNavSearchBlur,
                  child: ColoredBox(color: colors.alphaNav),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
