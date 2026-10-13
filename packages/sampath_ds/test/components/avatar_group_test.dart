import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: child),
    );

List<SampathAvatarEntry> _people(int n) => [
  for (var i = 0; i < n; i++) SampathAvatarEntry(initials: 'P$i'),
];

Iterable<SampathBrandAvatar> _avatars(WidgetTester t) =>
    t.widgetList<SampathBrandAvatar>(find.byType(SampathBrandAvatar));

void main() {
  // Figma 14:1155: width of each variant (Count=2, 3, 5, 7).
  const figmaWidths = {
    SampathAvatarGroupSize.xSmall: {2: 44.0, 3: 64.0, 5: 104.0, 7: 144.0},
    SampathAvatarGroupSize.medium: {2: 72.0, 3: 104.0, 5: 168.0, 7: 232.0},
    SampathAvatarGroupSize.xLarge: {2: 100.0, 3: 144.0, 5: 232.0, 7: 320.0},
  };

  for (final MapEntry(key: size, value: widths) in figmaWidths.entries) {
    for (final MapEntry(key: count, value: width) in widths.entries) {
      testWidgets('${size.name} × $count matches Figma ($width wide)', (
        t,
      ) async {
        await t.pumpWidget(
          _app(SampathAvatarGroup(avatars: _people(count), size: size)),
        );
        final group = find.byType(SampathAvatarGroup);
        expect(t.getSize(group).width, width);
        expect(t.getSize(group).height, size.avatarSize.dimension);
        final avatars = find.byType(SampathBrandAvatar);
        expect(avatars, findsNWidgets(count));
        final left = t.getTopLeft(group).dx;
        final step = size.avatarSize.dimension - size.overlap;
        for (var i = 0; i < count; i++) {
          expect(t.getTopLeft(avatars.at(i)).dx - left, step * i);
        }
        expect(_avatars(t).every((a) => a.size == size.avatarSize), isTrue);
      });
    }
  }

  test('overlaps are Space-XS / Space-M / Space-L', () {
    expect(SampathAvatarGroupSize.xSmall.overlap, SampathSpacing.xs);
    expect(SampathAvatarGroupSize.medium.overlap, SampathSpacing.m);
    expect(SampathAvatarGroupSize.xLarge.overlap, SampathSpacing.l);
  });

  testWidgets('default size is medium', (t) async {
    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(2))));
    expect(_avatars(t).first.size, SampathAvatarSize.medium);
  });

  testWidgets('7 people: all 7 shown, no +N', (t) async {
    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(7))));
    expect(_avatars(t).map((a) => a.initials), [
      for (var i = 0; i < 7; i++) 'P$i',
    ]);
  });

  testWidgets('more than 7: first 6, then +N', (t) async {
    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(10))));
    final avatars = _avatars(t).toList();
    expect(avatars, hasLength(7));
    expect(avatars.take(6).map((a) => a.initials), [
      for (var i = 0; i < 6; i++) 'P$i',
    ]);
    expect(avatars.last.initials, '+4');
    expect(avatars.last.image, isNull);
    expect(find.text('+4'), findsOneWidget);
  });

  testWidgets('8 people: +2', (t) async {
    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(8))));
    expect(_avatars(t).last.initials, '+2');
  });

  testWidgets('passes image and initials through', (t) async {
    const photo = AssetImage('missing.png');
    await t.pumpWidget(
      _app(
        const SampathAvatarGroup(
          avatars: [
            SampathAvatarEntry(image: photo, initials: 'SD'),
            SampathAvatarEntry(),
          ],
        ),
      ),
    );
    final avatars = _avatars(t).toList();
    expect(avatars[0].image, photo);
    expect(avatars[0].initials, 'SD');
    expect(avatars[1].image, isNull);
    expect(avatars[1].initials, isNull);
  });

  testWidgets('later avatars paint on top of earlier ones', (t) async {
    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(3))));
    final stack = t.widget<Stack>(
      find.descendant(
        of: find.byType(SampathAvatarGroup),
        matching: find.byType(Stack),
      ),
    );
    final order = [
      for (final c in stack.children)
        ((c as Positioned).child as SampathBrandAvatar).initials,
    ];
    expect(order, ['P0', 'P1', 'P2']);
    expect(stack.clipBehavior, Clip.none);
  });

  testWidgets('empty list renders nothing', (t) async {
    await t.pumpWidget(_app(const SampathAvatarGroup(avatars: [])));
    expect(find.byType(SampathBrandAvatar), findsNothing);
    expect(t.getSize(find.byType(SampathAvatarGroup)), Size.zero);
  });

  testWidgets('renders in Dark', (t) async {
    await t.pumpWidget(
      _app(SampathAvatarGroup(avatars: _people(9)), colors: SampathColors.dark),
    );
    expect(t.takeException(), isNull);
    expect(find.text('+3'), findsOneWidget);
  });

  testWidgets('semantics: one label for the group, else decorative', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(SampathAvatarGroup(avatars: _people(8), semanticLabel: '8 people')),
    );
    expect(find.bySemanticsLabel('8 people'), findsOneWidget);
    expect(find.bySemanticsLabel('+2'), findsNothing);

    await t.pumpWidget(_app(SampathAvatarGroup(avatars: _people(8))));
    expect(find.bySemanticsLabel('+2'), findsNothing);
    expect(find.bySemanticsLabel('8 people'), findsNothing);
    handle.dispose();
  });
}
