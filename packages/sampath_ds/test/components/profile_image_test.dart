import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:sampath_ds/sampath_ds.dart';

Widget _app(Widget child, {SampathColors colors = SampathColors.light}) =>
    MaterialApp(
      theme: ThemeData(extensions: [colors]),
      home: Center(child: child),
    );

const _photo = AssetImage('missing.png');

Finder get _circle => find.byWidgetPredicate(
  (w) => w is Container && w.decoration is ShapeDecoration,
);

SampathIcon _buttonIcon(WidgetTester t) => t.widget<SampathIcon>(
  find.descendant(of: _circle, matching: find.byType(SampathIcon)),
);

void main() {
  testWidgets('100 px brand avatar, image passed through', (t) async {
    await t.pumpWidget(
      _app(SampathProfileImage(image: _photo, onEditPhoto: () {})),
    );
    final avatar = t.widget<SampathBrandAvatar>(
      find.byType(SampathBrandAvatar),
    );
    expect(avatar.size, SampathAvatarSize.xxxLarge);
    expect(avatar.image, _photo);
    expect(avatar.initials, isNull);
    expect(t.getSize(find.byType(SampathProfileImage)), const Size(100, 100));
  });

  testWidgets('no onEditPhoto: no button', (t) async {
    await t.pumpWidget(_app(const SampathProfileImage(image: _photo)));
    expect(_circle, findsNothing);
    expect(
      find.byWidgetPredicate(
        (w) =>
            w is SampathIcon &&
            (w.icon == SampathIcons.camera ||
                w.icon == SampathIcons.editPencil),
      ),
      findsNothing,
    );
    expect(find.byType(GestureDetector), findsNothing);
    expect(t.getSize(find.byType(SampathProfileImage)), const Size(100, 100));
  });

  testWidgets('button matches Figma: 24 px at (74, 74), ring outside', (
    t,
  ) async {
    await t.pumpWidget(_app(SampathProfileImage(onEditPhoto: () {})));
    final origin = t.getTopLeft(find.byType(SampathProfileImage));
    expect(t.getTopLeft(_circle) - origin, const Offset(74, 74));
    expect(t.getSize(_circle), const Size(24, 24));

    final deco = t.widget<Container>(_circle).decoration! as ShapeDecoration;
    expect(deco.color, SampathColors.light.fgAction);
    final side = (deco.shape as CircleBorder).side;
    expect(side.color, SampathColors.light.borderDefault);
    expect(side.width, SampathBorderWidth.thin);
    expect(side.strokeAlign, BorderSide.strokeAlignOutside);

    final icon = _buttonIcon(t);
    expect(icon.size, SampathIconSize.s16);
    expect(icon.color, SampathIconColor.inverse);
    // 16 px icon centered: 4 px inset, as in Figma.
    final iconBox = find.descendant(
      of: _circle,
      matching: find.byType(SampathIcon),
    );
    expect(t.getTopLeft(iconBox) - origin, const Offset(78, 78));
  });

  testWidgets('no photo: camera, "Add photo"', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(_app(SampathProfileImage(onEditPhoto: () {})));
    expect(_buttonIcon(t).icon, SampathIcons.camera);
    expect(
      t.getSemantics(find.bySemanticsLabel('Add photo')),
      matchesSemantics(label: 'Add photo', isButton: true, hasTapAction: true),
    );
    handle.dispose();
  });

  testWidgets('photo: edit pencil, "Change photo"', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(SampathProfileImage(image: _photo, onEditPhoto: () {})),
    );
    expect(_buttonIcon(t).icon, SampathIcons.editPencil);
    expect(find.bySemanticsLabel('Change photo'), findsOneWidget);
    expect(find.bySemanticsLabel('Add photo'), findsNothing);
    handle.dispose();
  });

  testWidgets('editPhotoLabel overrides the label', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(
      _app(SampathProfileImage(onEditPhoto: () {}, editPhotoLabel: 'ඡායාරූපය')),
    );
    expect(find.bySemanticsLabel('ඡායාරූපය'), findsOneWidget);
    expect(find.bySemanticsLabel('Add photo'), findsNothing);
    handle.dispose();
  });

  testWidgets('tap area is 44 × 44 and calls onEditPhoto', (t) async {
    var taps = 0;
    await t.pumpWidget(_app(SampathProfileImage(onEditPhoto: () => taps++)));
    final origin = t.getTopLeft(find.byType(SampathProfileImage));
    final area = find.byWidgetPredicate(
      (w) => w is SizedBox && w.width == SampathTouchTarget.min,
    );
    expect(t.getSize(area), const Size(44, 44));
    expect(t.getTopLeft(area) - origin, const Offset(56, 56));

    // On the circle, and in the invisible area around it.
    await t.tapAt(origin + const Offset(86, 86));
    await t.tapAt(origin + const Offset(58, 58));
    await t.tapAt(origin + const Offset(99, 99));
    expect(taps, 3);

    // Outside the tap area: nothing.
    await t.tapAt(origin + const Offset(50, 50));
    expect(taps, 3);
  });

  testWidgets('touch target is 44', (t) async {
    expect(SampathTouchTarget.min, 44);
  });

  testWidgets('Dark: fg-action and border-default from the Dark set', (
    t,
  ) async {
    await t.pumpWidget(
      _app(SampathProfileImage(onEditPhoto: () {}), colors: SampathColors.dark),
    );
    final deco = t.widget<Container>(_circle).decoration! as ShapeDecoration;
    expect(deco.color, SampathColors.dark.fgAction);
    expect(
      (deco.shape as CircleBorder).side.color,
      SampathColors.dark.borderDefault,
    );
  });

  testWidgets('meets the tap target guideline', (t) async {
    final handle = t.ensureSemantics();
    await t.pumpWidget(_app(SampathProfileImage(onEditPhoto: () {})));
    await expectLater(t, meetsGuideline(iOSTapTargetGuideline));
    handle.dispose();
  });

  testWidgets('pressed: circle is fg-action_pressed until released', (t) async {
    Color circleColor() =>
        (t.widget<Container>(_circle).decoration! as ShapeDecoration).color!;

    await t.pumpWidget(_app(SampathProfileImage(onEditPhoto: () {})));
    expect(circleColor(), SampathColors.light.fgAction);

    final origin = t.getTopLeft(find.byType(SampathProfileImage));
    final gesture = await t.startGesture(origin + const Offset(86, 86));
    await t.pump(kPressTimeout);
    expect(circleColor(), SampathColors.light.fgActionPressed);

    await gesture.up();
    await t.pump();
    expect(circleColor(), SampathColors.light.fgAction);

    // Dragging off cancels the press.
    final drag = await t.startGesture(origin + const Offset(86, 86));
    await t.pump(kPressTimeout);
    await drag.moveBy(const Offset(-200, -200));
    await t.pump();
    expect(circleColor(), SampathColors.light.fgAction);
    await drag.up();
  });

  testWidgets('pressed in Dark uses the Dark fg-action_pressed', (t) async {
    await t.pumpWidget(
      _app(SampathProfileImage(onEditPhoto: () {}), colors: SampathColors.dark),
    );
    final origin = t.getTopLeft(find.byType(SampathProfileImage));
    final gesture = await t.startGesture(origin + const Offset(86, 86));
    await t.pump(kPressTimeout);
    expect(
      (t.widget<Container>(_circle).decoration! as ShapeDecoration).color,
      SampathColors.dark.fgActionPressed,
    );
    await gesture.up();
  });
}
