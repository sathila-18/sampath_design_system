// The live code box: snippet text per knob combination, and the Copy button.
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:sampath_widgetbook/components/divider_use_cases.dart';
import 'package:sampath_widgetbook/components/icon_container_use_cases.dart';
import 'package:sampath_widgetbook/components/icon_use_cases.dart';
import 'package:sampath_widgetbook/shared/code_snippet.dart';
import 'package:sampath_widgetbook/theme.dart';

void main() {
  group('dartCall', () {
    test('stays on one line up to 80 characters', () {
      final call = dartCall('Foo', ['a' * 75]);
      expect(call, hasLength(80));
      expect(call, isNot(contains('\n')));
    });

    test('wraps past 80 characters, one argument per line', () {
      expect(dartCall('Foo', ['a' * 76]), 'Foo(\n  ${'a' * 76},\n)');
      expect(
        dartCall('Foo', ['a' * 40], {'size': 'b' * 40}),
        'Foo(\n  ${'a' * 40},\n  size: ${'b' * 40},\n)',
      );
    });
  });

  group('Icon', () {
    test('defaults', () {
      expect(iconSnippet(SampathIcons.lock), 'SampathIcon(SampathIcons.lock)');
    });

    test('non-default size and color', () {
      expect(
        iconSnippet(
          SampathIcons.bell,
          size: SampathIconSize.s36,
          color: SampathIconColor.error,
        ),
        'SampathIcon(\n'
        '  SampathIcons.bell,\n'
        '  size: SampathIconSize.s36,\n'
        '  color: SampathIconColor.error,\n'
        ')',
      );
    });

    test('brand icon never shows color', () {
      expect(
        iconSnippet(
          SampathIcons.assistant,
          size: SampathIconSize.s48,
          color: SampathIconColor.error,
        ),
        'SampathIcon(SampathIcons.assistant, size: SampathIconSize.s48)',
      );
    });
  });

  group('Icon Badge', () {
    test('defaults', () {
      expect(
        iconBadgeSnippet(SampathIcons.lock),
        'SampathIconBadge.medium(SampathIcons.lock)',
      );
    });

    test('large with a state', () {
      expect(
        iconBadgeSnippet(
          SampathIcons.lock,
          large: true,
          state: SampathIconBadgeState.warning,
        ),
        'SampathIconBadge.large(SampathIcons.lock, '
        'state: SampathIconBadgeState.warning)',
      );
    });

    test('brand icon', () {
      expect(
        iconBadgeSnippet(SampathIcons.transfer, large: true),
        'SampathIconBadge.large(SampathIcons.transfer)',
      );
    });
  });

  group('Square Icon', () {
    test('defaults', () {
      expect(
        squareIconSnippet(SampathIcons.lock),
        'SampathSquareIcon(SampathIcons.lock)',
      );
    });

    test('non-default size and state', () {
      expect(
        squareIconSnippet(
          SampathIcons.lock,
          size: SampathSquareIconSize.large,
          state: SampathSquareIconState.success,
        ),
        'SampathSquareIcon(\n'
        '  SampathIcons.lock,\n'
        '  size: SampathSquareIconSize.large,\n'
        '  state: SampathSquareIconState.success,\n'
        ')',
      );
    });

    test('only state changed', () {
      expect(
        squareIconSnippet(
          SampathIcons.creditCard,
          state: SampathSquareIconState.info,
        ),
        'SampathSquareIcon(SampathIcons.creditCard, '
        'state: SampathSquareIconState.info)',
      );
    });

    test('brand icon', () {
      expect(
        squareIconSnippet(
          SampathIcons.insights,
          size: SampathSquareIconSize.small,
        ),
        'SampathSquareIcon(SampathIcons.insights, '
        'size: SampathSquareIconSize.small)',
      );
    });
  });

  group('Divider', () {
    test('defaults', () {
      expect(dividerSnippet(), 'SampathDivider()');
    });

    test('section', () {
      expect(
        dividerSnippet(type: SampathDividerType.section),
        'SampathDivider(type: SampathDividerType.section)',
      );
    });

    test('dash', () {
      expect(dividerDashSnippet, 'SampathDividerDash()');
    });
  });

  group('Circle Icon', () {
    test('defaults', () {
      expect(
        circleIconSnippet(SampathIcons.paypal),
        'SampathCircleIcon(SampathIcons.paypal)',
      );
    });

    test('non-default size', () {
      expect(
        circleIconSnippet(SampathIcons.user, size: SampathCircleIconSize.small),
        'SampathCircleIcon(SampathIcons.user, '
        'size: SampathCircleIconSize.small)',
      );
    });
  });

  group('CodeSnippet widget', () {
    final themes = {'Light': CatalogueTheme.light, 'Dark': CatalogueTheme.dark};
    for (final theme in themes.entries) {
      testWidgets('copies and shows Copied · ${theme.key}', (tester) async {
        tester.view.physicalSize = const Size(390, 844); // phone width
        tester.view.devicePixelRatio = 1;
        addTearDown(tester.view.reset);

        String? copied;
        tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
          SystemChannels.platform,
          (call) async {
            if (call.method == 'Clipboard.setData') {
              copied = (call.arguments as Map)['text'] as String;
            }
            return null;
          },
        );
        addTearDown(
          () => tester.binding.defaultBinaryMessenger.setMockMethodCallHandler(
            SystemChannels.platform,
            null,
          ),
        );

        const code =
            'SampathSquareIcon(SampathIcons.lock, '
            'size: SampathSquareIconSize.large, '
            'state: SampathSquareIconState.success)';
        await tester.pumpWidget(
          MaterialApp(
            theme: theme.value,
            home: const Scaffold(
              body: PreviewWithCode(
                preview: SampathSquareIcon(
                  SampathIcons.lock,
                  size: SampathSquareIconSize.large,
                  state: SampathSquareIconState.success,
                ),
                code: code,
              ),
            ),
          ),
        );
        expect(tester.takeException(), isNull);
        expect(find.text(code), findsOneWidget);
        expect(
          // The font the text is actually laid out with, after SelectableText
          // merges our style into the theme's DefaultTextStyle.
          tester
              .widget<EditableText>(find.byType(EditableText))
              .style
              .fontFamily,
          'RobotoMono',
        );

        // No soft wrap: the text sits in a horizontal scroll view.
        expect(
          find.ancestor(
            of: find.byType(SelectableText),
            matching: find.byWidgetPredicate(
              (w) =>
                  w is SingleChildScrollView &&
                  w.scrollDirection == Axis.horizontal,
            ),
          ),
          findsOneWidget,
        );

        await tester.tap(find.text('Copy'));
        await tester.pump();
        expect(copied, code);
        expect(find.text('Copied'), findsOneWidget);

        await tester.pump(CodeSnippet.copiedDuration);
        expect(find.text('Copy'), findsOneWidget);
      });
    }
  });
}
