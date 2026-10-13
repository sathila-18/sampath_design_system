import 'package:flutter/widgets.dart';

import 'avatar_base.dart';

/// The secondary avatar, on a circle: `Avatar` (DESIGN.md §9.3).
///
/// ```dart
/// SampathAvatar(image: NetworkImage(url), initials: 'SD')
/// SampathAvatar(initials: 'SD', size: SampathAvatarSize.small)
/// SampathAvatar() // user icon
/// ```
///
/// Same content rules as `SampathBrandAvatar`: [image], else [initials],
/// else the `user` icon, with the initials or icon shown while the photo
/// loads or if it fails.
///
/// Without [semanticLabel] the avatar is decorative and hidden from screen
/// readers.
class SampathAvatar extends StatelessWidget {
  const SampathAvatar({
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
    // Radius-Full.
    shape: const CircleBorder(),
    // Figma draws the border inside the box.
    strokeAlign: BorderSide.strokeAlignInside,
    size: size,
    image: image,
    initials: initials,
    semanticLabel: semanticLabel,
  );
}
