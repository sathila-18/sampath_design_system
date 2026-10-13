import 'package:flutter/widgets.dart';

import '../icon_containers/sampath_octagon_border.dart';
import 'avatar_base.dart';

/// The main avatar, on the brand octagon: `Brand avatar` (DESIGN.md §9.3).
///
/// ```dart
/// SampathBrandAvatar(image: NetworkImage(url), initials: 'SD')
/// SampathBrandAvatar(initials: 'SD', size: SampathAvatarSize.large)
/// SampathBrandAvatar() // user icon
/// ```
///
/// The type comes from the content: [image] shows the photo; without one,
/// [initials] (shown exactly as given); with neither, the `user` icon. While
/// the photo loads, or if it fails, the initials or icon show instead.
///
/// Without [semanticLabel] the avatar is decorative and hidden from screen
/// readers.
class SampathBrandAvatar extends StatelessWidget {
  const SampathBrandAvatar({
    super.key,
    this.image,
    this.initials,
    this.size = SampathAvatarSize.medium,
    this.semanticLabel,
  });

  final ImageProvider? image;
  final String? initials;
  final SampathAvatarSize size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) => AvatarBase(
    shape: const SampathOctagonBorder(),
    // Figma strokes the vector on its edge (half outside).
    strokeAlign: BorderSide.strokeAlignCenter,
    size: size,
    image: image,
    initials: initials,
    semanticLabel: semanticLabel,
  );
}
