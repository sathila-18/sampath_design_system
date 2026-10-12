import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';

/// Scrollable page with a title and sections, shared by the Foundations pages.
class FoundationPage extends StatelessWidget {
  const FoundationPage({
    super.key,
    required this.title,
    required this.source,
    required this.sections,
  });

  final String title;

  /// Where the values come from, e.g. "DESIGN.md §3.3 · generated".
  final String source;
  final List<FoundationSection> sections;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ListView(
      padding: const EdgeInsets.all(SampathLayout.screenMargin),
      children: [
        Text(
          title,
          style: SampathTextStyles.headlineLargeH4.copyWith(
            color: colors.textPrimary,
          ),
        ),
        const SizedBox(height: SampathSpacing.xs),
        Text(
          source,
          style: SampathTextStyles.bodySmall.copyWith(
            color: colors.textSecondary,
          ),
        ),
        for (final section in sections) ...[
          const SizedBox(height: SampathLayout.sectionGap),
          section,
        ],
      ],
    );
  }
}

class FoundationSection extends StatelessWidget {
  const FoundationSection({
    super.key,
    required this.title,
    required this.children,
    this.wrap = false,
  });

  final String title;
  final List<Widget> children;

  /// Lay children out in a wrapping grid instead of a column.
  final bool wrap;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: SampathTextStyles.headlineSmallH6.copyWith(
            color: context.colors.textPrimary,
          ),
        ),
        const SizedBox(height: SampathSpacing.l),
        if (wrap)
          Wrap(
            spacing: SampathSpacing.xl,
            runSpacing: SampathSpacing.xl,
            children: children,
          )
        else
          for (final (i, child) in children.indexed) ...[
            if (i > 0) const SizedBox(height: SampathSpacing.m),
            child,
          ],
      ],
    );
  }
}

/// Token name (Figma) with a secondary detail line.
class TokenLabel extends StatelessWidget {
  const TokenLabel(this.name, this.detail, {super.key});

  final String name;
  final String detail;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          name,
          style: SampathTextStyles.labelMedium.copyWith(
            color: colors.textPrimary,
          ),
        ),
        Text(
          detail,
          style: SampathTextStyles.captionLarge.copyWith(
            color: colors.textSecondary,
          ),
        ),
      ],
    );
  }
}

String formatNumber(double value) =>
    value == value.roundToDouble() ? '${value.toInt()}' : '$value';
