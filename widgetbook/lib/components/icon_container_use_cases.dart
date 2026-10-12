import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';
import 'icon_use_cases.dart';

/// Use cases for the icon containers (DESIGN.md §9.1, §8.2 #16–19).
List<WidgetbookComponent> iconContainerComponents() => [
  WidgetbookComponent(
    name: 'Icon Badge',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final icon = pickIconKnobs(context);
          final large = context.knobs.object.dropdown<bool>(
            label: 'Size',
            options: const [false, true],
            labelBuilder: (l) => l ? '68px bg (large)' : '46px bg (medium)',
          );
          final state = context.knobs.object.dropdown<SampathIconBadgeState>(
            label: 'State',
            options: SampathIconBadgeState.values,
            labelBuilder: (s) => s.name,
          );
          return _Single(
            name: large ? '68px bg' : '46px bg',
            detail: state.name,
            child: large
                ? SampathIconBadge.large(icon, state: state)
                : SampathIconBadge.medium(icon, state: state),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes × states',
        builder: (context) {
          final icon = pickIconKnobs(context);
          return _Grid(
            title: 'Icon Badge · sizes × states',
            source: 'Figma 46px bg (20:309), 68px bg (20:369)',
            columns: [for (final s in SampathIconBadgeState.values) s.name],
            rows: [
              (
                '46px bg',
                [
                  for (final s in SampathIconBadgeState.values)
                    SampathIconBadge.medium(icon, state: s),
                ],
              ),
              (
                '68px bg',
                [
                  for (final s in SampathIconBadgeState.values)
                    SampathIconBadge.large(icon, state: s),
                ],
              ),
            ],
          );
        },
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'Square Icon',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final icon = pickIconKnobs(context);
          final size = context.knobs.object.dropdown<SampathSquareIconSize>(
            label: 'Size',
            options: SampathSquareIconSize.values,
            initialOption: SampathSquareIconSize.medium,
            labelBuilder: (s) => s.name,
          );
          final state = context.knobs.object.dropdown<SampathSquareIconState>(
            label: 'State',
            options: SampathSquareIconState.values,
            labelBuilder: (s) => s.name,
          );
          return _Single(
            name: 'Square Icon',
            detail: '${size.name} · ${state.name}',
            child: SampathSquareIcon(icon, size: size, state: state),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes × states',
        builder: (context) {
          final icon = pickIconKnobs(context);
          return _Grid(
            title: 'Square Icon · sizes × states',
            source: 'Figma Square Icon (71:4274)',
            columns: [for (final s in SampathSquareIconState.values) s.name],
            rows: [
              for (final size in SampathSquareIconSize.values.reversed)
                (
                  size.name,
                  [
                    for (final s in SampathSquareIconState.values)
                      SampathSquareIcon(icon, size: size, state: s),
                  ],
                ),
            ],
          );
        },
      ),
    ],
  ),
  WidgetbookComponent(
    name: 'Circle Icon',
    useCases: [
      WidgetbookUseCase(
        name: 'Default',
        builder: (context) {
          final icon = pickIconKnobs(context);
          final size = context.knobs.object.dropdown<SampathCircleIconSize>(
            label: 'Size',
            options: SampathCircleIconSize.values,
            initialOption: SampathCircleIconSize.large,
            labelBuilder: (s) => s.name,
          );
          return _Single(
            name: 'Circle Icon',
            detail: size.name,
            child: SampathCircleIcon(icon, size: size),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes',
        builder: (context) {
          final icon = pickIconKnobs(context);
          return _Grid(
            title: 'Circle Icon · sizes',
            source: 'Figma Circle Icon (624:4882)',
            columns: [for (final s in SampathCircleIconSize.values) s.name],
            rows: [
              (
                '',
                [
                  for (final s in SampathCircleIconSize.values)
                    SampathCircleIcon(icon, size: s),
                ],
              ),
            ],
          );
        },
      ),
    ],
  ),
];

class _Single extends StatelessWidget {
  const _Single({
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
        child,
        const SizedBox(height: SampathSpacing.l),
        TokenLabel(name, detail),
      ],
    ),
  );
}

class _Grid extends StatelessWidget {
  const _Grid({
    required this.title,
    required this.source,
    required this.columns,
    required this.rows,
  });

  final String title;
  final String source;
  final List<String> columns;
  final List<(String, List<Widget>)> rows;

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
                defaultColumnWidth: const FixedColumnWidth(SampathSpacing.x9l),
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
