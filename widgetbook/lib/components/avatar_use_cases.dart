import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';
import '../shared/code_snippet.dart';
import '../shared/variant_grid.dart';

/// Use cases for `SampathBrandAvatar` and `SampathAvatar` (DESIGN.md §9.3)
/// and `SampathAvatarGroup` (§9.4).
List<WidgetbookComponent> avatarComponents() => [
  _component(AvatarShape.brand),
  _component(AvatarShape.circle),
  _groupComponent(),
];

/// The two mapped avatars.
enum AvatarShape {
  brand('Brand avatar', 'SampathBrandAvatar', 'Figma Brand avatar (20:962)'),
  circle('Avatar', 'SampathAvatar', 'Figma Avatar (932:1387)');

  const AvatarShape(this.label, this.className, this.source);

  final String label;
  final String className;
  final String source;

  Widget build({
    ImageProvider? image,
    String? initials,
    SampathAvatarSize size = SampathAvatarSize.medium,
  }) => switch (this) {
    brand => SampathBrandAvatar(image: image, initials: initials, size: size),
    circle => SampathAvatar(image: image, initials: initials, size: size),
  };
}

/// Figma `Type`. In code it follows the content, so this only picks what
/// the preview passes.
enum AvatarType { image, icon, text }

/// The sample photo from the Figma image fill (Widgetbook only).
const sampleAvatarPhoto = AssetImage('assets/images/avatar_sample.jpg');

/// Stands for the developer's photo in the code box.
const _photoCode = 'NetworkImage(photoUrl)';

/// The `SampathBrandAvatar(...)` / `SampathAvatar(...)` call, defaults left
/// out. Initials go with Image too (they show while it loads).
String avatarSnippet(
  AvatarShape shape, {
  AvatarType type = AvatarType.icon,
  String initials = '',
  SampathAvatarSize size = SampathAvatarSize.medium,
}) => dartCall(shape.className, const [], {
  if (type == AvatarType.image) 'image': _photoCode,
  if (type != AvatarType.icon && initials.isNotEmpty)
    'initials': dartString(initials),
  if (size != SampathAvatarSize.medium)
    'size': 'SampathAvatarSize.${size.name}',
});

WidgetbookComponent _component(AvatarShape shape) => WidgetbookComponent(
  name: shape.label,
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final type = context.knobs.object.dropdown<AvatarType>(
          label: 'Type',
          description: 'In code: image, else initials, else the user icon',
          options: AvatarType.values,
          labelBuilder: (t) => t.name,
        );
        final size = context.knobs.object.dropdown<SampathAvatarSize>(
          label: 'Size',
          options: SampathAvatarSize.values,
          initialOption: SampathAvatarSize.medium,
          labelBuilder: _sizeLabel,
        );
        final initials = context.knobs.string(
          label: 'Initials',
          description: 'Shown exactly as given; also the Image fallback',
          initialValue: 'SD',
        );
        final shown = type == AvatarType.icon ? null : initials;
        return PreviewWithCode(
          code: avatarSnippet(
            shape,
            type: type,
            initials: initials,
            size: size,
          ),
          preview: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              shape.build(
                image: type == AvatarType.image ? sampleAvatarPhoto : null,
                initials: shown,
                size: size,
              ),
              const SizedBox(height: SampathSpacing.l),
              TokenLabel(shape.label, '${_sizeLabel(size)} · ${type.name}'),
            ],
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Sizes × types',
      builder: (context) => AvatarGrid(shape: shape),
    ),
  ],
);

/// Every size × type of one avatar, as laid out in Figma.
class AvatarGrid extends StatelessWidget {
  const AvatarGrid({super.key, required this.shape});

  final AvatarShape shape;

  @override
  Widget build(BuildContext context) => VariantGrid(
    title: '${shape.label} · sizes × types',
    source: shape.source,
    // Fits the 100 px XXXLarge.
    columnWidth: SampathSpacing.x11l,
    columns: [for (final s in SampathAvatarSize.values) _sizeLabel(s)],
    rows: [
      for (final type in AvatarType.values)
        (
          type.name,
          [
            for (final size in SampathAvatarSize.values)
              shape.build(
                image: type == AvatarType.image ? sampleAvatarPhoto : null,
                initials: type == AvatarType.text ? 'SD' : null,
                size: size,
              ),
          ],
        ),
    ],
  );
}

String _sizeLabel(SampathAvatarSize s) =>
    '${s.name} · ${s.dimension.toInt()}px';

/// Five faces from the Figma `Avatar Group` image fills, cropped square to
/// the face (Widgetbook only), in an order where neighbors differ.
const _groupFaces = [
  SampathAvatarEntry(
    image: AssetImage('assets/images/avatar_group_1.jpg'),
    initials: 'NP',
  ),
  SampathAvatarEntry(
    image: AssetImage('assets/images/avatar_group_2.jpg'),
    initials: 'AR',
  ),
  SampathAvatarEntry(image: sampleAvatarPhoto, initials: 'SD'),
  SampathAvatarEntry(
    image: AssetImage('assets/images/avatar_group_4.jpg'),
    initials: 'KF',
  ),
  SampathAvatarEntry(
    image: AssetImage('assets/images/avatar_group_3.jpg'),
    initials: 'MH',
  ),
];

/// Sample people for the group previews, cycling through the faces.
List<SampathAvatarEntry> samplePeople(int count) => [
  for (var i = 0; i < count; i++) _groupFaces[i % _groupFaces.length],
];

/// "1 person" / "8 people".
String peopleLabel(int count) => count == 1 ? '1 person' : '$count people';

/// The `SampathAvatarGroup(...)` call, default size left out. `people`
/// stands for the developer's list of `SampathAvatarEntry`.
String avatarGroupSnippet({
  required int count,
  SampathAvatarGroupSize size = SampathAvatarGroupSize.medium,
}) => dartCall('SampathAvatarGroup', const [], {
  'avatars': 'people',
  if (size != SampathAvatarGroupSize.medium)
    'size': 'SampathAvatarGroupSize.${size.name}',
  'semanticLabel': dartString(peopleLabel(count)),
});

WidgetbookComponent _groupComponent() => WidgetbookComponent(
  name: 'Avatar Group',
  useCases: [
    WidgetbookUseCase(
      name: 'Default',
      builder: (context) {
        final size = context.knobs.object.dropdown<SampathAvatarGroupSize>(
          label: 'Size',
          options: SampathAvatarGroupSize.values,
          initialOption: SampathAvatarGroupSize.medium,
          labelBuilder: _groupSizeLabel,
        );
        final count = context.knobs.int.slider(
          label: 'Number of people',
          description: 'Over 7: the first 6, then +N',
          // Figma's Count=7 sample: 6 avatars and "+4".
          initialValue: 10,
          min: 1,
          max: 20,
        );
        return PreviewWithCode(
          code: avatarGroupSnippet(count: count, size: size),
          preview: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              SampathAvatarGroup(
                avatars: samplePeople(count),
                size: size,
                semanticLabel: peopleLabel(count),
              ),
              const SizedBox(height: SampathSpacing.l),
              TokenLabel(
                'Avatar Group',
                '${_groupSizeLabel(size)} · ${peopleLabel(count)}',
              ),
            ],
          ),
        );
      },
    ),
    WidgetbookUseCase(
      name: 'Sizes × people',
      builder: (context) => const AvatarGroupGrid(),
    ),
  ],
);

/// Every Figma `Avatar Group` variant (3 sizes × 2, 3, 5, 7 people), plus
/// 10 people to show the "+N" spot as in Figma's Count=7 sample.
class AvatarGroupGrid extends StatelessWidget {
  const AvatarGroupGrid({super.key});

  static const counts = [2, 3, 5, 7, 10];

  @override
  Widget build(BuildContext context) => VariantGrid(
    title: 'Avatar Group · sizes × people',
    source: 'Figma Avatar Group (14:1155), sizes as columns',
    // Fits the 320 px XLarge × 7.
    columnWidth: SampathSpacing.x12l,
    columns: [
      for (final s in SampathAvatarGroupSize.values) _groupSizeLabel(s),
    ],
    rows: [
      for (final count in counts)
        (
          count > SampathAvatarGroup.maxSpots
              ? '${peopleLabel(count)} (6 + "+N")'
              : peopleLabel(count),
          [
            for (final size in SampathAvatarGroupSize.values)
              SampathAvatarGroup(
                avatars: samplePeople(count),
                size: size,
                semanticLabel: peopleLabel(count),
              ),
          ],
        ),
    ],
  );
}

String _groupSizeLabel(SampathAvatarGroupSize s) =>
    '${s.name} · ${s.avatarSize.dimension.toInt()}px';
