import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';

/// Use cases for `SampathDivider` and `SampathDividerDash` (DESIGN.md §9.2).
List<WidgetbookComponent> dividerComponents() => [
  WidgetbookComponent(
    name: 'Divider',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final type = context.knobs.object.dropdown<SampathDividerType>(
            label: 'Type',
            options: SampathDividerType.values,
            labelBuilder: _typeLabel,
          );
          return _Preview(
            name: _typeLabel(type),
            detail: '${type.thickness.toInt()}px · border-default',
            child: SampathDivider(type: type),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'All types',
        builder: (context) => FoundationPage(
          title: 'Divider',
          source:
              'Figma Divider (28:367), Divider dash (596:1256) · '
              'switch Light / Dark with the Theme addon',
          sections: [
            for (final type in SampathDividerType.values)
              FoundationSection(
                title: '${_typeLabel(type)} · ${type.thickness.toInt()}px',
                children: [_Frame(child: SampathDivider(type: type))],
              ),
            const FoundationSection(
              title: 'Divider dash · 1px, dash 1.5 / gap 1.5',
              children: [_Frame(child: SampathDividerDash())],
            ),
          ],
        ),
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'Divider dash',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) => const _Preview(
          name: 'Divider dash',
          detail: '1px · dash 1.5 / gap 1.5 · border-default',
          child: SampathDividerDash(),
        ),
      ),
    ],
  ),
];

String _typeLabel(SampathDividerType t) => switch (t) {
  SampathDividerType.divider => 'Divider',
  SampathDividerType.section => 'Section Divider',
};

// Phone-width frame, like the Figma artboard (375 = 343 + 2 × 16 margin).
class _Frame extends StatelessWidget {
  const _Frame({required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) => SizedBox(
    width: _phoneWidth,
    child: Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: SampathLayout.screenMargin,
        vertical: SampathSpacing.xl,
      ),
      child: child,
    ),
  );
}

const double _phoneWidth = 375;

class _Preview extends StatelessWidget {
  const _Preview({
    required this.name,
    required this.detail,
    required this.child,
  });

  final String name;
  final String detail;
  final Widget child;

  @override
  Widget build(BuildContext context) => Center(
    child: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        _Frame(child: child),
        const SizedBox(height: SampathSpacing.l),
        TokenLabel(name, detail),
      ],
    ),
  );
}
