import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';
import '../shared/code_snippet.dart';
import '../shared/variant_grid.dart';
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
            code: iconBadgeSnippet(icon, large: large, state: state),
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
          return VariantGrid(
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
            code: squareIconSnippet(icon, size: size, state: state),
            child: SampathSquareIcon(icon, size: size, state: state),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes × states',
        builder: (context) {
          final icon = pickIconKnobs(context);
          return VariantGrid(
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
            code: circleIconSnippet(icon, size: size),
            child: SampathCircleIcon(icon, size: size),
          );
        },
      ),
      WidgetbookUseCase(
        name: 'Sizes',
        builder: (context) {
          final icon = pickIconKnobs(context);
          return VariantGrid(
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

/// The `SampathIconBadge.medium/.large(...)` call, defaults left out.
String iconBadgeSnippet(
  SampathIconData icon, {
  bool large = false,
  SampathIconBadgeState state = SampathIconBadgeState.primary,
}) => dartCall(
  large ? 'SampathIconBadge.large' : 'SampathIconBadge.medium',
  [iconRef(icon)],
  {
    if (state != SampathIconBadgeState.primary)
      'state': 'SampathIconBadgeState.${state.name}',
  },
);

/// The `SampathSquareIcon(...)` call, defaults left out.
String squareIconSnippet(
  SampathIconData icon, {
  SampathSquareIconSize size = SampathSquareIconSize.medium,
  SampathSquareIconState state = SampathSquareIconState.brand,
}) => dartCall(
  'SampathSquareIcon',
  [iconRef(icon)],
  {
    if (size != SampathSquareIconSize.medium)
      'size': 'SampathSquareIconSize.${size.name}',
    if (state != SampathSquareIconState.brand)
      'state': 'SampathSquareIconState.${state.name}',
  },
);

/// The `SampathCircleIcon(...)` call, defaults left out.
String circleIconSnippet(
  SampathIconData icon, {
  SampathCircleIconSize size = SampathCircleIconSize.large,
}) => dartCall(
  'SampathCircleIcon',
  [iconRef(icon)],
  {
    if (size != SampathCircleIconSize.large)
      'size': 'SampathCircleIconSize.${size.name}',
  },
);

class _Single extends StatelessWidget {
  const _Single({
    required this.name,
    required this.detail,
    required this.code,
    required this.child,
  });

  final String name;
  final String detail;
  final String code;
  final Widget child;

  @override
  Widget build(BuildContext context) => PreviewWithCode(
    code: code,
    preview: Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        child,
        const SizedBox(height: SampathSpacing.l),
        TokenLabel(name, detail),
      ],
    ),
  );
}
