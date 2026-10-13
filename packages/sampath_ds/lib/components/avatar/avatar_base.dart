import 'package:flutter/widgets.dart';

import '../../icons/sampath_icon.dart';
import '../../icons/sampath_icons.dart';
import '../../tokens/sampath_colors.dart';
import '../../tokens/sampath_typography.dart';
import '../../tokens/styles.dart';

/// Figma `Size` of `Brand avatar` and `Avatar` (DESIGN.md §9.3).
///
/// There's no Type parameter: it follows the content (image, else
/// initials, else the `user` icon).
enum SampathAvatarSize {
  /// `Xsmall` · 24 × 24, `16px` icon, `Label/Small`.
  xSmall(24, SampathIconSize.s16, SampathTextStyles.labelSmall),

  /// `Small` · 32 × 32, `20px` icon, `Label/Small`.
  small(32, SampathIconSize.s20, SampathTextStyles.labelSmall),

  /// `Medium` · 40 × 40, `24px` icon, `Label/Large`.
  medium(40, SampathIconSize.s24, SampathTextStyles.labelLarge),

  /// `Large` · 48 × 48, `36px` icon, `Title/Large`.
  large(48, SampathIconSize.s36, SampathTextStyles.titleLarge),

  /// `XLarge` · 56 × 56, `36px` icon, `Headline/Large-H4`.
  xLarge(56, SampathIconSize.s36, SampathTextStyles.headlineLargeH4),

  /// `XXLarge` · 64 × 64, `48px` icon, `Display/Small-H3`.
  xxLarge(64, SampathIconSize.s48, SampathTextStyles.displaySmallH3),

  /// `XXXLarge` · 100 × 100, `48px` icon, `Display/Large-H1`.
  xxxLarge(100, SampathIconSize.s48, SampathTextStyles.displayLargeH1);

  const SampathAvatarSize(this.dimension, this.iconSize, this.textStyle);

  final double dimension;
  final SampathIconSize iconSize;

  /// Initials style, colored `text-secondary`.
  final TextStyle textStyle;
}

/// Shared body of `SampathBrandAvatar` and `SampathAvatar`: everything but
/// the shape.
///
/// Internal. The mapped widgets pass [shape] and the stroke alignment.
class AvatarBase extends StatelessWidget {
  const AvatarBase({
    super.key,
    required this.shape,
    required this.strokeAlign,
    required this.size,
    this.image,
    this.initials,
    this.semanticLabel,
  });

  /// The outline, without a side; the base adds the `border-subtle` side.
  final OutlinedBorder shape;

  /// Where the 1 px outline sits on the shape's edge
  /// (`BorderSide.strokeAlign*`).
  final double strokeAlign;

  final SampathAvatarSize size;
  final ImageProvider? image;
  final String? initials;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    final outline = shape.copyWith(
      side: BorderSide(
        color: colors.borderSubtle,
        width: SampathBorderWidth.thin,
        strokeAlign: strokeAlign,
      ),
    );

    // Text or Icon type, on bg-secondary. Also stands in for a photo that
    // is still loading or failed.
    final hasInitials = initials != null && initials!.isNotEmpty;
    final Widget fallback = ColoredBox(
      color: colors.bgSecondary,
      child: Center(
        child: hasInitials
            ? Text(
                initials!,
                maxLines: 1,
                softWrap: false,
                textAlign: TextAlign.center,
                // Fixed-size artwork: initials don't grow with text scale.
                textScaler: TextScaler.noScaling,
                style: size.textStyle.copyWith(color: colors.textSecondary),
              )
            : SampathIcon(
                SampathIcons.user,
                size: size.iconSize,
                color: SampathIconColor.secondary,
              ),
      ),
    );

    final photo = image;
    final Widget content = photo == null
        ? fallback
        : Image(
            image: photo,
            fit: BoxFit.cover,
            width: size.dimension,
            height: size.dimension,
            gaplessPlayback: true,
            frameBuilder: (context, child, frame, sync) =>
                sync || frame != null ? child : fallback,
            errorBuilder: (context, error, stack) => fallback,
          );

    final avatar = SizedBox.square(
      dimension: size.dimension,
      child: DecoratedBox(
        // Outline on top of the content, as in Figma.
        position: DecorationPosition.foreground,
        decoration: ShapeDecoration(shape: outline),
        child: ClipPath(
          clipper: ShapeBorderClipper(shape: shape),
          child: content,
        ),
      ),
    );

    final label = semanticLabel;
    if (label == null) return ExcludeSemantics(child: avatar);
    return Semantics(
      label: label,
      image: true,
      child: ExcludeSemantics(child: avatar),
    );
  }
}
