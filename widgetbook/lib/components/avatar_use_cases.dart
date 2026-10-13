import 'package:flutter/material.dart';
import 'package:sampath_ds/sampath_ds.dart';
import 'package:widgetbook/widgetbook.dart';

import '../foundations/foundation_page.dart';
import '../shared/code_snippet.dart';
import '../shared/variant_grid.dart';

/// Use cases for `SampathBrandAvatar` and `SampathAvatar` (DESIGN.md §9.3).
List<WidgetbookComponent> avatarComponents() => [
  _component(AvatarShape.brand),
  _component(AvatarShape.circle),
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
