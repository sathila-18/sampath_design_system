import 'package:flutter/widgets.dart';

import '../../tokens/sampath_spacing.dart';
import 'avatar_base.dart';
import 'sampath_brand_avatar.dart';

/// One person in a [SampathAvatarGroup]: the same content a
/// `SampathBrandAvatar` takes (photo, else initials, else the `user` icon).
@immutable
class SampathAvatarEntry {
  const SampathAvatarEntry({this.image, this.initials});

  final ImageProvider? image;
  final String? initials;
}

/// Figma `Size` of `Avatar Group` (DESIGN.md §9.4): the avatar size and how
/// far each avatar overlaps the one before it.
enum SampathAvatarGroupSize {
  /// `XSmall` · 24 px avatars, 4 px overlap (`Space-XS`).
  xSmall(SampathAvatarSize.xSmall, SampathSpacing.xs),

  /// `Medium` · 40 px avatars, 8 px overlap (`Space-M`).
  medium(SampathAvatarSize.medium, SampathSpacing.m),

  /// `XLarge` · 56 px avatars, 12 px overlap (`Space-L`).
  xLarge(SampathAvatarSize.xLarge, SampathSpacing.l);

  const SampathAvatarGroupSize(this.avatarSize, this.overlap);

  final SampathAvatarSize avatarSize;
  final double overlap;
}

/// A row of overlapping brand avatars: `Avatar Group` (DESIGN.md §9.4).
///
/// ```dart
/// SampathAvatarGroup(
///   avatars: [
///     SampathAvatarEntry(image: NetworkImage(url), initials: 'SD'),
///     SampathAvatarEntry(initials: 'AK'),
///   ],
///   semanticLabel: '2 people',
/// )
/// ```
///
/// Shows up to [maxSpots] avatars. With more people, the first 6 show and
/// the last spot is a Text avatar with "+N", N being the number not shown.
/// Each avatar sits on top of the one before it.
///
/// Without [semanticLabel] the group is decorative and hidden from screen
/// readers.
class SampathAvatarGroup extends StatelessWidget {
  const SampathAvatarGroup({
    super.key,
    required this.avatars,
    this.size = SampathAvatarGroupSize.medium,
    this.semanticLabel,
  });

  /// The largest Figma variant (`Count=7`).
  static const int maxSpots = 7;

  final List<SampathAvatarEntry> avatars;
  final SampathAvatarGroupSize size;

  /// Read for the whole group, for example "8 people".
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final overflow = avatars.length > maxSpots;
    final shown = overflow ? avatars.take(maxSpots - 1) : avatars;
    final spots = <Widget>[
      for (final a in shown)
        SampathBrandAvatar(
          image: a.image,
          initials: a.initials,
          size: size.avatarSize,
        ),
      if (overflow)
        SampathBrandAvatar(
          initials: '+${avatars.length - (maxSpots - 1)}',
          size: size.avatarSize,
        ),
    ];
    if (spots.isEmpty) return const SizedBox.shrink();

    final dimension = size.avatarSize.dimension;
    final step = dimension - size.overlap;
    final group = SizedBox(
      width: dimension + step * (spots.length - 1),
      height: dimension,
      child: Stack(
        // The brand outline draws half a pixel outside each avatar.
        clipBehavior: Clip.none,
        children: [
          for (final (i, spot) in spots.indexed)
            Positioned(left: step * i, top: 0, child: spot),
        ],
      ),
    );

    final label = semanticLabel;
    if (label == null) return ExcludeSemantics(child: group);
    return Semantics(
      label: label,
      container: true,
      child: ExcludeSemantics(child: group),
    );
  }
}
