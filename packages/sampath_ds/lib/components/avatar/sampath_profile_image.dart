import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icon_data.dart';
import '../../icons/sampath_icons.dart';
import '../../tokens/sampath_colors.dart';
import '../../tokens/sampath_spacing.dart';
import '../../tokens/styles.dart';
import 'avatar_base.dart';
import 'sampath_brand_avatar.dart';

/// The person's photo with an add / change photo button: `Profile image`
/// (DESIGN.md §9.5).
///
/// ```dart
/// SampathProfileImage(image: NetworkImage(url), onEditPhoto: pickPhoto)
/// SampathProfileImage(onEditPhoto: pickPhoto) // user icon, "Add photo"
/// SampathProfileImage(image: NetworkImage(url)) // no button
/// ```
///
/// A 100 px `SampathBrandAvatar`: the photo, else the `user` icon (also while
/// the photo loads or if it fails). The button at the bottom right shows
/// only with [onEditPhoto]: the camera icon ("Add photo") without a photo,
/// the edit icon ("Change photo") with one. Tapping it calls [onEditPhoto].
class SampathProfileImage extends StatelessWidget {
  const SampathProfileImage({
    super.key,
    this.image,
    this.onEditPhoto,
    this.editPhotoLabel,
  });

  final ImageProvider? image;

  /// Shows the button and is called when it's tapped.
  final VoidCallback? onEditPhoto;

  /// Overrides the button's screen reader label ("Add photo" /
  /// "Change photo"), for example with a translation.
  final String? editPhotoLabel;

  static const _avatarSize = SampathAvatarSize.xxxLarge;

  @override
  Widget build(BuildContext context) {
    final avatar = SampathBrandAvatar(image: image, size: _avatarSize);
    final onTap = onEditPhoto;
    if (onTap == null) return avatar;

    final hasPhoto = image != null;
    return SizedBox.square(
      dimension: _avatarSize.dimension,
      child: Stack(
        // The button's ring draws outside its 24 px circle.
        clipBehavior: Clip.none,
        children: [
          avatar,
          Positioned(
            right: 0,
            bottom: 0,
            child: _EditPhotoButton(
              icon: hasPhoto ? SampathIcons.editPencil : SampathIcons.camera,
              label:
                  editPhotoLabel ?? (hasPhoto ? 'Change photo' : 'Add photo'),
              onTap: onTap,
            ),
          ),
        ],
      ),
    );
  }
}

/// The 24 px circle Figma calls `Online Indicator` (§10 #27), inside an
/// invisible 44 × 44 tap area anchored to the avatar's bottom-right corner.
///
/// While pressed, the circle is `fg-action_pressed`. The color switches
/// instantly (no animation), so there's nothing to turn off for Reduce
/// motion.
class _EditPhotoButton extends StatefulWidget {
  const _EditPhotoButton({
    required this.icon,
    required this.label,
    required this.onTap,
  });

  /// Figma `Online Indicator`: 24 × 24.
  static const double _size = 24;

  final SampathIconData icon;
  final String label;
  final VoidCallback onTap;

  @override
  State<_EditPhotoButton> createState() => _EditPhotoButtonState();
}

class _EditPhotoButtonState extends State<_EditPhotoButton> {
  bool _pressed = false;

  void _setPressed(bool value) {
    if (_pressed != value) setState(() => _pressed = value);
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final onTap = widget.onTap;
    return Semantics(
      button: true,
      label: widget.label,
      excludeSemantics: true,
      onTap: onTap,
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: onTap,
          onTapDown: (_) => _setPressed(true),
          onTapUp: (_) => _setPressed(false),
          onTapCancel: () => _setPressed(false),
          child: SizedBox.square(
            dimension: SampathTouchTarget.min,
            child: Align(
              alignment: Alignment.bottomRight,
              child: Padding(
                // Figma: 2 px in from the avatar's right and bottom edges.
                padding: const EdgeInsets.all(SampathSpacing.xxs),
                child: Container(
                  width: _EditPhotoButton._size,
                  height: _EditPhotoButton._size,
                  decoration: ShapeDecoration(
                    color: _pressed ? colors.fgActionPressed : colors.fgAction,
                    shape: CircleBorder(
                      side: BorderSide(
                        color: colors.borderDefault,
                        width: SampathBorderWidth.thin,
                        // Figma strokes the circle outside.
                        strokeAlign: BorderSide.strokeAlignOutside,
                      ),
                    ),
                  ),
                  alignment: Alignment.center,
                  child: SampathIcon(
                    widget.icon,
                    size: SampathIconSize.s16,
                    color: SampathIconColor.inverse,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
