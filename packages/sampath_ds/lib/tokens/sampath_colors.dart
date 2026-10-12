// GENERATED CODE — DO NOT EDIT BY HAND.
// Source: tokens/design.tokens.json · Generator: tool/generate_tokens.dart
// To change a value, re-export the tokens from Figma and rerun the generator.

import 'package:flutter/material.dart';

/// Semantic colors (`Color collection`), Light and Dark.
///
/// Components read these through `context.colors`. Register
/// [SampathColors.light] / [SampathColors.dark] as a theme
/// extension on the app's `ThemeData`.
@immutable
final class SampathColors extends ThemeExtension<SampathColors> {
  const SampathColors({
    required this.bgPrimary,
    required this.bgSecondary,
    required this.bgTertiary,
    required this.bgNeutral,
    required this.bgBrand,
    required this.bgActive,
    required this.bgActiveHover,
    required this.bgActionPrimary,
    required this.bgActionPrimaryPressed,
    required this.bgActionSecondary,
    required this.bgActionSecondaryPressed,
    required this.bgActionInverse,
    required this.bgActionDestructive,
    required this.bgDisabled,
    required this.bgDark,
    required this.bgSuccess,
    required this.bgSuccessSecondary,
    required this.bgError,
    required this.bgErrorSecondary,
    required this.bgWarning,
    required this.bgInfo,
    required this.bgInfoSecondary,
    required this.bgIcons,
    required this.bgAvatar,
    required this.bgPriority,
    required this.bgGold,
    required this.textPrimary,
    required this.textSecondary,
    required this.textTertiary,
    required this.textPlaceholder,
    required this.textDisabled,
    required this.textDisabledOnBg,
    required this.textInverse,
    required this.textDarkBoth,
    required this.textInverseSubtle,
    required this.textAction,
    required this.textActionPressed,
    required this.textActive,
    required this.textSuccess,
    required this.textSuccessSecondary,
    required this.textError,
    required this.textErrorSecondary,
    required this.textInfo,
    required this.textInfoSecondary,
    required this.textWarning,
    required this.textWarningSecondary,
    required this.textGold,
    required this.borderDefault,
    required this.borderSubtle,
    required this.borderStrong,
    required this.borderActive,
    required this.borderFocused,
    required this.borderActionPrimary,
    required this.borderDisabled,
    required this.borderInverse,
    required this.borderSuccess,
    required this.borderError,
    required this.borderInfo,
    required this.borderWarning,
    required this.borderGold,
    required this.fgPrimary,
    required this.fgSecondary,
    required this.fgBrand,
    required this.fgPlaceholder,
    required this.fgActive,
    required this.fgDisabled,
    required this.fgDisabledOnBg,
    required this.fgInverse,
    required this.fgDarkBoth,
    required this.fgWhiteBoth,
    required this.fgAction,
    required this.fgActionPressed,
    required this.fgSuccess,
    required this.fgError,
    required this.fgInfo,
    required this.fgWarning,
    required this.fgGold,
    required this.alphaSm,
    required this.alphaMd,
    required this.alphaLg,
    required this.alphaLight,
    required this.alphaNav,
    required this.alphaNavBackground,
    required this.alphaShade,
    required this.alphaBoth,
    required this.alphaBorder,
    required this.alphaSuccess,
    required this.alphaBrand,
    required this.alphaError,
  });

  /// Use this for main background of the screens
  ///
  /// Figma: `bg-primary`
  final Color bgPrimary;

  /// Use this color for card frames, popups, modals, input field, bottom nav, action icons
  ///
  /// Figma: `bg-secondary`
  final Color bgSecondary;

  /// Use this for info callout notification backgrounds
  ///
  /// Figma: `bg-tertiary`
  final Color bgTertiary;

  /// Use this for badge neutral background
  ///
  /// Figma: `bg-neutral`
  final Color bgNeutral;

  /// Use this for brand related backgrounds
  ///
  /// Figma: `bg-brand`
  final Color bgBrand;

  /// Use this color for active or selected state backgrounds
  ///
  /// Figma: `bg-active`
  final Color bgActive;

  /// Use this color for hover state of active or selected backgrounds
  ///
  /// Figma: `bg-active-hover`
  final Color bgActiveHover;

  /// Mainly use for primary button backgrounds
  ///
  /// Figma: `bg-action-primary`
  final Color bgActionPrimary;

  /// Mainly use for pressed or hover states of primary button backgrounds
  ///
  /// Figma: `bg-action-primary_pressed`
  final Color bgActionPrimaryPressed;

  /// Use this for swipe button background
  ///
  /// Figma: `bg-action-secondary`
  final Color bgActionSecondary;

  /// Mainly use for pressed or hover states of secondary button backgrounds
  ///
  /// Figma: `bg-action-secondary_pressed`
  final Color bgActionSecondaryPressed;

  /// Use this white call to actions
  ///
  /// Figma: `bg-action-inverse`
  final Color bgActionInverse;

  /// Use this color for destructive buttons
  ///
  /// Figma: `bg-action-destructive`
  final Color bgActionDestructive;

  /// Use this for disabled backgrounds
  ///
  /// Figma: `bg-disabled`
  final Color bgDisabled;

  /// Use this for toast/snackbar backgrounds
  ///
  /// Figma: `bg-dark`
  final Color bgDark;

  /// Use this for success backgrounds. (notification, badge)
  ///
  /// Figma: `bg-success`
  final Color bgSuccess;

  /// Secondary version for success backgrounds. (notification, badge)
  ///
  /// Figma: `bg-success_secondary`
  final Color bgSuccessSecondary;

  /// Use this for error backgrounds. (notification, badge)
  ///
  /// Figma: `bg-error`
  final Color bgError;

  /// Secondary version for error backgrounds. (notification, badge)
  ///
  /// Figma: `bg-error_secondary`
  final Color bgErrorSecondary;

  /// Use this for warning backgrounds. (notification, badge)
  ///
  /// Figma: `bg-warning`
  final Color bgWarning;

  /// Use this for info backgrounds. (notification, badge)
  ///
  /// Figma: `bg-info`
  final Color bgInfo;

  /// Secondary color for info backgrounds. (notification, badge)
  ///
  /// Figma: `bg-info_secondary`
  final Color bgInfoSecondary;

  /// Use this for icon or avatar backgrounds
  ///
  /// Figma: `bg-icons`
  final Color bgIcons;

  /// Use this for avatar backgrounds with logos
  ///
  /// Figma: `bg-avatar`
  final Color bgAvatar;

  /// Use this for priority banners
  ///
  /// Figma: `bg-priority`
  final Color bgPriority;

  /// Use this for loyalty backgrounds
  ///
  /// Figma: `bg-gold`
  final Color bgGold;

  /// Use this for Titles and headings
  ///
  /// Figma: `text-primary`
  final Color textPrimary;

  /// Use this for description texts
  ///
  /// Figma: `text-secondary`
  final Color textSecondary;

  /// Use this for captions, overlines, hints
  ///
  /// Figma: `text-tertiary`
  final Color textTertiary;

  /// Use this for input field placeholder text
  ///
  /// Figma: `text-placeholder`
  final Color textPlaceholder;

  /// Use this for disabled text
  ///
  /// Figma: `text-disabled`
  final Color textDisabled;

  /// Use this for disabled text on backgrounds. (buttons, badge, chips)
  ///
  /// Figma: `text-disabled-on_bg`
  final Color textDisabledOnBg;

  /// Use this text color on brand backgrounds
  ///
  /// Figma: `text-inverse`
  final Color textInverse;

  /// Use this text color on brand backgrounds when needed in both dark and light modes
  ///
  /// Figma: `text-dark_both`
  final Color textDarkBoth;

  /// Secondary text color for on brand backgrounds
  ///
  /// Figma: `text-inverse_subtle`
  final Color textInverseSubtle;

  /// Use this for text links, secondary buttons
  ///
  /// Figma: `text-action`
  final Color textAction;

  /// Pressed state color for text-link
  ///
  /// Figma: `text-action_pressed`
  final Color textActionPressed;

  /// Use this for input field labels in typing or complete states
  ///
  /// Figma: `text-active`
  final Color textActive;

  /// Use this for success texts
  ///
  /// Figma: `text-success`
  final Color textSuccess;

  /// Secondary darker version of a success color (notifications, banners)
  ///
  /// Figma: `text-success_secondary`
  final Color textSuccessSecondary;

  /// Use this for error texts
  ///
  /// Figma: `text-error`
  final Color textError;

  /// Secondary darker version of a error text (notifications, banners)
  ///
  /// Figma: `text-error_secondary`
  final Color textErrorSecondary;

  /// Use this for information texts
  ///
  /// Figma: `text-info`
  final Color textInfo;

  /// Secondary darker version of a informartion text (notifications, banners)
  ///
  /// Figma: `text-info_secondary`
  final Color textInfoSecondary;

  /// Use this for warning texts
  ///
  /// Figma: `text-warning`
  final Color textWarning;

  /// Secondary darker version of a warning text (notifications, banners)
  ///
  /// Figma: `text-warning_secondary`
  final Color textWarningSecondary;

  /// Use this for loyalty texts
  ///
  /// Figma: `text-gold`
  final Color textGold;

  /// default border color. Can use this for dividers as well
  ///
  /// Figma: `border-default`
  final Color borderDefault;

  /// Subtle version of border color
  ///
  /// Figma: `border-subtle`
  final Color borderSubtle;

  /// Strong version of border color (radio buttons)
  ///
  /// Figma: `border-strong`
  final Color borderStrong;

  /// Use for active or selected states. Can use for typing state of input fields.
  ///
  /// Figma: `border-active`
  final Color borderActive;

  /// Use this for focus ring, or focused states
  ///
  /// Figma: `border-focused`
  final Color borderFocused;

  /// Use this for outline (secondary) buttons
  ///
  /// Figma: `border-action-primary`
  final Color borderActionPrimary;

  /// Use for disabled borders
  ///
  /// Figma: `border-disabled`
  final Color borderDisabled;

  /// Borders on brand color
  ///
  /// Figma: `border-inverse`
  final Color borderInverse;

  /// Border for success color
  ///
  /// Figma: `border-success`
  final Color borderSuccess;

  /// Border for error color
  ///
  /// Figma: `border-error`
  final Color borderError;

  /// Border for information color
  ///
  /// Figma: `border-info`
  final Color borderInfo;

  /// Border for warning color
  ///
  /// Figma: `border-warning`
  final Color borderWarning;

  /// Border for loyalty color
  ///
  /// Figma: `border-gold`
  final Color borderGold;

  /// Primary icon color
  ///
  /// Figma: `fg-primary`
  final Color fgPrimary;

  /// Secondary icon color. (input fields, Close, chevron)
  ///
  /// Figma: `fg-secondary`
  final Color fgSecondary;

  /// Brand related icons
  ///
  /// Figma: `fg-brand`
  final Color fgBrand;

  /// Icon color for input field icons
  ///
  /// Figma: `fg-placeholder`
  final Color fgPlaceholder;

  /// Icons on active state
  ///
  /// Figma: `fg-active`
  final Color fgActive;

  /// disabled icon
  ///
  /// Figma: `fg-disabled`
  final Color fgDisabled;

  /// Disabled icon color on background
  ///
  /// Figma: `fg-disabled-on_bg`
  final Color fgDisabledOnBg;

  /// Icons on brand color
  ///
  /// Figma: `fg-inverse`
  final Color fgInverse;

  /// Darker icons for both light and dark modes
  ///
  /// Figma: `fg-dark_both`
  final Color fgDarkBoth;

  /// Light icons on brand backgrounds for both dark and light modes
  ///
  /// Figma: `fg-white_both`
  final Color fgWhiteBoth;

  /// Color for action icons
  ///
  /// Figma: `fg-action`
  final Color fgAction;

  /// Pressed or hover state color for action icons
  ///
  /// Figma: `fg-action_pressed`
  final Color fgActionPressed;

  /// Color for success icons
  ///
  /// Figma: `fg-success`
  final Color fgSuccess;

  /// Color for error icons
  ///
  /// Figma: `fg-error`
  final Color fgError;

  /// Color for information icon
  ///
  /// Figma: `fg-info`
  final Color fgInfo;

  /// Color for warning icons
  ///
  /// Figma: `fg-warning`
  final Color fgWarning;

  /// Color for loyalty icons
  ///
  /// Figma: `fg-gold`
  final Color fgGold;

  /// mainly used in the small CTAs inside branded cards
  ///
  /// Figma: `Alpha-sm`
  final Color alphaSm;

  ///
  /// Figma: `Alpha-md`
  final Color alphaMd;

  /// Used in scan QR code interface overlay
  ///
  /// Figma: `Alpha-lg`
  final Color alphaLg;

  /// Use this to show more depth to elements on brand background
  ///
  /// Figma: `Alpha-light`
  final Color alphaLight;

  /// Use this in bottom navigation backgrounds, and loading overlay
  ///
  /// Figma: `Alpha-nav`
  final Color alphaNav;

  ///
  /// Figma: `Alpha-nav_background`
  final Color alphaNavBackground;

  ///
  /// Figma: `Alpha-shade`
  final Color alphaShade;

  /// Used in overlay backgrounds
  ///
  /// Figma: `Alpha-both`
  final Color alphaBoth;

  /// used for borders of back icon circle
  ///
  /// Figma: `Alpha-border`
  final Color alphaBorder;

  ///
  /// Figma: `Alpha-success`
  final Color alphaSuccess;

  ///
  /// Figma: `Alpha-brand`
  final Color alphaBrand;

  ///
  /// Figma: `Alpha-error`
  final Color alphaError;

  static const light = SampathColors(
    bgPrimary: Color(0xFFF7F3EF),
    bgSecondary: Color(0xFFFFFFFF),
    bgTertiary: Color(0xFFFCD5BA),
    bgNeutral: Color(0xFFF7F3EF),
    bgBrand: Color(0xFFF47921),
    bgActive: Color(0xFFFDE7D6),
    bgActiveHover: Color(0xFFFCD5BA),
    bgActionPrimary: Color(0xFFDE6E1E),
    bgActionPrimaryPressed: Color(0xFFAD5617),
    bgActionSecondary: Color(0xFFE1DDD9),
    bgActionSecondaryPressed: Color(0xFFFCD5BA),
    bgActionInverse: Color(0xFFFFFFFF),
    bgActionDestructive: Color(0xFFC5221F),
    bgDisabled: Color(0xFFE1DDD9),
    bgDark: Color(0xFF080809),
    bgSuccess: Color(0xFFBEE4CC),
    bgSuccessSecondary: Color(0xFFEAF6EF),
    bgError: Color(0xFFEDBABA),
    bgErrorSecondary: Color(0xFFF9E9E9),
    bgWarning: Color(0xFFF4DABF),
    bgInfo: Color(0xFFCDBFF5),
    bgInfoSecondary: Color(0xFFEFEAFC),
    bgIcons: Color(0xFFFDE7D6),
    bgAvatar: Color(0xFFE8E8E8),
    bgPriority: Color(0xFFFBE1A6),
    bgGold: Color(0xFFFCE7B8),
    textPrimary: Color(0xFF141D27),
    textSecondary: Color(0xFF62686E),
    textTertiary: Color(0xFF434A52),
    textPlaceholder: Color(0xFF62686E),
    textDisabled: Color(0xFFB6B9BC),
    textDisabledOnBg: Color(0xFF93979C),
    textInverse: Color(0xFFFFFFFF),
    textDarkBoth: Color(0xFF141D27),
    textInverseSubtle: Color(0xFFB6B9BC),
    textAction: Color(0xFFDE6E1E),
    textActionPressed: Color(0xFFAD5617),
    textActive: Color(0xFFF47921),
    textSuccess: Color(0xFF2EA85A),
    textSuccessSecondary: Color(0xFF195C32),
    textError: Color(0xFFC5221F),
    textErrorSecondary: Color(0xFF6C1311),
    textInfo: Color(0xFF5E2FE0),
    textInfoSecondary: Color(0xFF341A7B),
    textWarning: Color(0xFFDD8731),
    textWarningSecondary: Color(0xFF7A4A1B),
    textGold: Color(0xFF8A7C5B),
    borderDefault: Color(0xFFE1DDD9),
    borderSubtle: Color(0xFFE8E8E8),
    borderStrong: Color(0xFF888683),
    borderActive: Color(0xFFF47921),
    borderFocused: Color(0xFFF47921),
    borderActionPrimary: Color(0xFFF47921),
    borderDisabled: Color(0xFF939394),
    borderInverse: Color(0xFFFFFFFF),
    borderSuccess: Color(0xFF2EA85A),
    borderError: Color(0xFFC5221F),
    borderInfo: Color(0xFF5E2FE0),
    borderWarning: Color(0xFFDD8731),
    borderGold: Color(0xFFE4CD97),
    fgPrimary: Color(0xFF141D27),
    fgSecondary: Color(0xFF62686E),
    fgBrand: Color(0xFFF47921),
    fgPlaceholder: Color(0xFF939394),
    fgActive: Color(0xFFDE6E1E),
    fgDisabled: Color(0xFFB6B9BC),
    fgDisabledOnBg: Color(0xFF93979C),
    fgInverse: Color(0xFFFFFFFF),
    fgDarkBoth: Color(0xFF62686E),
    fgWhiteBoth: Color(0xFFFFFFFF),
    fgAction: Color(0xFFDE6E1E),
    fgActionPressed: Color(0xFFAD5617),
    fgSuccess: Color(0xFF2EA85A),
    fgError: Color(0xFFC5221F),
    fgInfo: Color(0xFF5E2FE0),
    fgWarning: Color(0xFFDD8731),
    fgGold: Color(0xFF8A7C5B),
    alphaSm: Color(0x29141416),
    alphaMd: Color(0x66141416),
    alphaLg: Color(0xBF141416),
    alphaLight: Color(0x1FFFFFFF),
    alphaNav: Color(0xBFFFFFFF),
    alphaNavBackground: Color(0x66FFFFFF),
    alphaShade: Color(0x00F7F3EF),
    alphaBoth: Color(0x6B141416),
    alphaBorder: Color(0x14141416),
    alphaSuccess: Color(0x292EA85A),
    alphaBrand: Color(0x29F47921),
    alphaError: Color(0x29C5221F),
  );

  static const dark = SampathColors(
    bgPrimary: Color(0xFF141416),
    bgSecondary: Color(0xFF1E1E21),
    bgTertiary: Color(0xFFAD5617),
    bgNeutral: Color(0xFF080809),
    bgBrand: Color(0xFFF47921),
    bgActive: Color(0xFF66330E),
    bgActiveHover: Color(0xFF864312),
    bgActionPrimary: Color(0xFFF47921),
    bgActionPrimaryPressed: Color(0xFFAD5617),
    bgActionSecondary: Color(0xFF080809),
    bgActionSecondaryPressed: Color(0xFF864312),
    bgActionInverse: Color(0xFFFFFFFF),
    bgActionDestructive: Color(0xFFD14E4C),
    bgDisabled: Color(0xFF626263),
    bgDark: Color(0xFF27145E),
    bgSuccess: Color(0xFF244A3E),
    bgSuccessSecondary: Color(0xFF195C32),
    bgError: Color(0xFF6B211B),
    bgErrorSecondary: Color(0xFF6C1311),
    bgWarning: Color(0xFF5D3915),
    bgInfo: Color(0xFF27145E),
    bgInfoSecondary: Color(0xFF341A7B),
    bgIcons: Color(0xFF66330E),
    bgAvatar: Color(0xFF080809),
    bgPriority: Color(0xFF695F46),
    bgGold: Color(0xFF8A7C5B),
    textPrimary: Color(0xFFFDFBFA),
    textSecondary: Color(0xFFE1DDD9),
    textTertiary: Color(0xFFAFADAA),
    textPlaceholder: Color(0xFFB6B9BC),
    textDisabled: Color(0xFF62686E),
    textDisabledOnBg: Color(0xFFB6B9BC),
    textInverse: Color(0xFFFFFFFF),
    textDarkBoth: Color(0xFF141D27),
    textInverseSubtle: Color(0xFFB6B9BC),
    textAction: Color(0xFFF47921),
    textActionPressed: Color(0xFFF6944D),
    textActive: Color(0xFFF47921),
    textSuccess: Color(0xFF58B97B),
    textSuccessSecondary: Color(0xFFBEE4CC),
    textError: Color(0xFFD14E4C),
    textErrorSecondary: Color(0xFFEDBABA),
    textInfo: Color(0xFF7E59E6),
    textInfoSecondary: Color(0xFFCDBFF5),
    textWarning: Color(0xFFE49F5A),
    textWarningSecondary: Color(0xFFF4DABF),
    textGold: Color(0xFFFDF1D6),
    borderDefault: Color(0xFF686664),
    borderSubtle: Color(0xFF434A52),
    borderStrong: Color(0xFFE1DDD9),
    borderActive: Color(0xFFF47921),
    borderFocused: Color(0xFFF47921),
    borderActionPrimary: Color(0xFFF47921),
    borderDisabled: Color(0xFF626263),
    borderInverse: Color(0xFFFFFFFF),
    borderSuccess: Color(0xFF2EA85A),
    borderError: Color(0xFFC5221F),
    borderInfo: Color(0xFF5E2FE0),
    borderWarning: Color(0xFFDD8731),
    borderGold: Color(0xFFFBE1A6),
    fgPrimary: Color(0xFFFDFBFA),
    fgSecondary: Color(0xFFE1DDD9),
    fgBrand: Color(0xFFF6944D),
    fgPlaceholder: Color(0xFFB6B6B7),
    fgActive: Color(0xFFF6944D),
    fgDisabled: Color(0xFF62686E),
    fgDisabledOnBg: Color(0xFFB6B9BC),
    fgInverse: Color(0xFFFFFFFF),
    fgDarkBoth: Color(0xFF62686E),
    fgWhiteBoth: Color(0xFFFFFFFF),
    fgAction: Color(0xFFF6944D),
    fgActionPressed: Color(0xFFF8A56A),
    fgSuccess: Color(0xFF58B97B),
    fgError: Color(0xFFD14E4C),
    fgInfo: Color(0xFF7E59E6),
    fgWarning: Color(0xFFE49F5A),
    fgGold: Color(0xFFFCE7B8),
    alphaSm: Color(0x29141416),
    alphaMd: Color(0x66141416),
    alphaLg: Color(0xBF141416),
    alphaLight: Color(0x1FFFFFFF),
    alphaNav: Color(0x0FFFFFFF),
    alphaNavBackground: Color(0x66141416),
    alphaShade: Color(0x00141416),
    alphaBoth: Color(0x6B141416),
    alphaBorder: Color(0x05141416),
    alphaSuccess: Color(0x292EA85A),
    alphaBrand: Color(0x29F47921),
    alphaError: Color(0x29C5221F),
  );

  @override
  SampathColors copyWith({
    Color? bgPrimary,
    Color? bgSecondary,
    Color? bgTertiary,
    Color? bgNeutral,
    Color? bgBrand,
    Color? bgActive,
    Color? bgActiveHover,
    Color? bgActionPrimary,
    Color? bgActionPrimaryPressed,
    Color? bgActionSecondary,
    Color? bgActionSecondaryPressed,
    Color? bgActionInverse,
    Color? bgActionDestructive,
    Color? bgDisabled,
    Color? bgDark,
    Color? bgSuccess,
    Color? bgSuccessSecondary,
    Color? bgError,
    Color? bgErrorSecondary,
    Color? bgWarning,
    Color? bgInfo,
    Color? bgInfoSecondary,
    Color? bgIcons,
    Color? bgAvatar,
    Color? bgPriority,
    Color? bgGold,
    Color? textPrimary,
    Color? textSecondary,
    Color? textTertiary,
    Color? textPlaceholder,
    Color? textDisabled,
    Color? textDisabledOnBg,
    Color? textInverse,
    Color? textDarkBoth,
    Color? textInverseSubtle,
    Color? textAction,
    Color? textActionPressed,
    Color? textActive,
    Color? textSuccess,
    Color? textSuccessSecondary,
    Color? textError,
    Color? textErrorSecondary,
    Color? textInfo,
    Color? textInfoSecondary,
    Color? textWarning,
    Color? textWarningSecondary,
    Color? textGold,
    Color? borderDefault,
    Color? borderSubtle,
    Color? borderStrong,
    Color? borderActive,
    Color? borderFocused,
    Color? borderActionPrimary,
    Color? borderDisabled,
    Color? borderInverse,
    Color? borderSuccess,
    Color? borderError,
    Color? borderInfo,
    Color? borderWarning,
    Color? borderGold,
    Color? fgPrimary,
    Color? fgSecondary,
    Color? fgBrand,
    Color? fgPlaceholder,
    Color? fgActive,
    Color? fgDisabled,
    Color? fgDisabledOnBg,
    Color? fgInverse,
    Color? fgDarkBoth,
    Color? fgWhiteBoth,
    Color? fgAction,
    Color? fgActionPressed,
    Color? fgSuccess,
    Color? fgError,
    Color? fgInfo,
    Color? fgWarning,
    Color? fgGold,
    Color? alphaSm,
    Color? alphaMd,
    Color? alphaLg,
    Color? alphaLight,
    Color? alphaNav,
    Color? alphaNavBackground,
    Color? alphaShade,
    Color? alphaBoth,
    Color? alphaBorder,
    Color? alphaSuccess,
    Color? alphaBrand,
    Color? alphaError,
  }) {
    return SampathColors(
      bgPrimary: bgPrimary ?? this.bgPrimary,
      bgSecondary: bgSecondary ?? this.bgSecondary,
      bgTertiary: bgTertiary ?? this.bgTertiary,
      bgNeutral: bgNeutral ?? this.bgNeutral,
      bgBrand: bgBrand ?? this.bgBrand,
      bgActive: bgActive ?? this.bgActive,
      bgActiveHover: bgActiveHover ?? this.bgActiveHover,
      bgActionPrimary: bgActionPrimary ?? this.bgActionPrimary,
      bgActionPrimaryPressed:
          bgActionPrimaryPressed ?? this.bgActionPrimaryPressed,
      bgActionSecondary: bgActionSecondary ?? this.bgActionSecondary,
      bgActionSecondaryPressed:
          bgActionSecondaryPressed ?? this.bgActionSecondaryPressed,
      bgActionInverse: bgActionInverse ?? this.bgActionInverse,
      bgActionDestructive: bgActionDestructive ?? this.bgActionDestructive,
      bgDisabled: bgDisabled ?? this.bgDisabled,
      bgDark: bgDark ?? this.bgDark,
      bgSuccess: bgSuccess ?? this.bgSuccess,
      bgSuccessSecondary: bgSuccessSecondary ?? this.bgSuccessSecondary,
      bgError: bgError ?? this.bgError,
      bgErrorSecondary: bgErrorSecondary ?? this.bgErrorSecondary,
      bgWarning: bgWarning ?? this.bgWarning,
      bgInfo: bgInfo ?? this.bgInfo,
      bgInfoSecondary: bgInfoSecondary ?? this.bgInfoSecondary,
      bgIcons: bgIcons ?? this.bgIcons,
      bgAvatar: bgAvatar ?? this.bgAvatar,
      bgPriority: bgPriority ?? this.bgPriority,
      bgGold: bgGold ?? this.bgGold,
      textPrimary: textPrimary ?? this.textPrimary,
      textSecondary: textSecondary ?? this.textSecondary,
      textTertiary: textTertiary ?? this.textTertiary,
      textPlaceholder: textPlaceholder ?? this.textPlaceholder,
      textDisabled: textDisabled ?? this.textDisabled,
      textDisabledOnBg: textDisabledOnBg ?? this.textDisabledOnBg,
      textInverse: textInverse ?? this.textInverse,
      textDarkBoth: textDarkBoth ?? this.textDarkBoth,
      textInverseSubtle: textInverseSubtle ?? this.textInverseSubtle,
      textAction: textAction ?? this.textAction,
      textActionPressed: textActionPressed ?? this.textActionPressed,
      textActive: textActive ?? this.textActive,
      textSuccess: textSuccess ?? this.textSuccess,
      textSuccessSecondary: textSuccessSecondary ?? this.textSuccessSecondary,
      textError: textError ?? this.textError,
      textErrorSecondary: textErrorSecondary ?? this.textErrorSecondary,
      textInfo: textInfo ?? this.textInfo,
      textInfoSecondary: textInfoSecondary ?? this.textInfoSecondary,
      textWarning: textWarning ?? this.textWarning,
      textWarningSecondary: textWarningSecondary ?? this.textWarningSecondary,
      textGold: textGold ?? this.textGold,
      borderDefault: borderDefault ?? this.borderDefault,
      borderSubtle: borderSubtle ?? this.borderSubtle,
      borderStrong: borderStrong ?? this.borderStrong,
      borderActive: borderActive ?? this.borderActive,
      borderFocused: borderFocused ?? this.borderFocused,
      borderActionPrimary: borderActionPrimary ?? this.borderActionPrimary,
      borderDisabled: borderDisabled ?? this.borderDisabled,
      borderInverse: borderInverse ?? this.borderInverse,
      borderSuccess: borderSuccess ?? this.borderSuccess,
      borderError: borderError ?? this.borderError,
      borderInfo: borderInfo ?? this.borderInfo,
      borderWarning: borderWarning ?? this.borderWarning,
      borderGold: borderGold ?? this.borderGold,
      fgPrimary: fgPrimary ?? this.fgPrimary,
      fgSecondary: fgSecondary ?? this.fgSecondary,
      fgBrand: fgBrand ?? this.fgBrand,
      fgPlaceholder: fgPlaceholder ?? this.fgPlaceholder,
      fgActive: fgActive ?? this.fgActive,
      fgDisabled: fgDisabled ?? this.fgDisabled,
      fgDisabledOnBg: fgDisabledOnBg ?? this.fgDisabledOnBg,
      fgInverse: fgInverse ?? this.fgInverse,
      fgDarkBoth: fgDarkBoth ?? this.fgDarkBoth,
      fgWhiteBoth: fgWhiteBoth ?? this.fgWhiteBoth,
      fgAction: fgAction ?? this.fgAction,
      fgActionPressed: fgActionPressed ?? this.fgActionPressed,
      fgSuccess: fgSuccess ?? this.fgSuccess,
      fgError: fgError ?? this.fgError,
      fgInfo: fgInfo ?? this.fgInfo,
      fgWarning: fgWarning ?? this.fgWarning,
      fgGold: fgGold ?? this.fgGold,
      alphaSm: alphaSm ?? this.alphaSm,
      alphaMd: alphaMd ?? this.alphaMd,
      alphaLg: alphaLg ?? this.alphaLg,
      alphaLight: alphaLight ?? this.alphaLight,
      alphaNav: alphaNav ?? this.alphaNav,
      alphaNavBackground: alphaNavBackground ?? this.alphaNavBackground,
      alphaShade: alphaShade ?? this.alphaShade,
      alphaBoth: alphaBoth ?? this.alphaBoth,
      alphaBorder: alphaBorder ?? this.alphaBorder,
      alphaSuccess: alphaSuccess ?? this.alphaSuccess,
      alphaBrand: alphaBrand ?? this.alphaBrand,
      alphaError: alphaError ?? this.alphaError,
    );
  }

  @override
  SampathColors lerp(ThemeExtension<SampathColors>? other, double t) {
    if (other is! SampathColors) return this;
    return SampathColors(
      bgPrimary: Color.lerp(bgPrimary, other.bgPrimary, t)!,
      bgSecondary: Color.lerp(bgSecondary, other.bgSecondary, t)!,
      bgTertiary: Color.lerp(bgTertiary, other.bgTertiary, t)!,
      bgNeutral: Color.lerp(bgNeutral, other.bgNeutral, t)!,
      bgBrand: Color.lerp(bgBrand, other.bgBrand, t)!,
      bgActive: Color.lerp(bgActive, other.bgActive, t)!,
      bgActiveHover: Color.lerp(bgActiveHover, other.bgActiveHover, t)!,
      bgActionPrimary: Color.lerp(bgActionPrimary, other.bgActionPrimary, t)!,
      bgActionPrimaryPressed: Color.lerp(
        bgActionPrimaryPressed,
        other.bgActionPrimaryPressed,
        t,
      )!,
      bgActionSecondary: Color.lerp(
        bgActionSecondary,
        other.bgActionSecondary,
        t,
      )!,
      bgActionSecondaryPressed: Color.lerp(
        bgActionSecondaryPressed,
        other.bgActionSecondaryPressed,
        t,
      )!,
      bgActionInverse: Color.lerp(bgActionInverse, other.bgActionInverse, t)!,
      bgActionDestructive: Color.lerp(
        bgActionDestructive,
        other.bgActionDestructive,
        t,
      )!,
      bgDisabled: Color.lerp(bgDisabled, other.bgDisabled, t)!,
      bgDark: Color.lerp(bgDark, other.bgDark, t)!,
      bgSuccess: Color.lerp(bgSuccess, other.bgSuccess, t)!,
      bgSuccessSecondary: Color.lerp(
        bgSuccessSecondary,
        other.bgSuccessSecondary,
        t,
      )!,
      bgError: Color.lerp(bgError, other.bgError, t)!,
      bgErrorSecondary: Color.lerp(
        bgErrorSecondary,
        other.bgErrorSecondary,
        t,
      )!,
      bgWarning: Color.lerp(bgWarning, other.bgWarning, t)!,
      bgInfo: Color.lerp(bgInfo, other.bgInfo, t)!,
      bgInfoSecondary: Color.lerp(bgInfoSecondary, other.bgInfoSecondary, t)!,
      bgIcons: Color.lerp(bgIcons, other.bgIcons, t)!,
      bgAvatar: Color.lerp(bgAvatar, other.bgAvatar, t)!,
      bgPriority: Color.lerp(bgPriority, other.bgPriority, t)!,
      bgGold: Color.lerp(bgGold, other.bgGold, t)!,
      textPrimary: Color.lerp(textPrimary, other.textPrimary, t)!,
      textSecondary: Color.lerp(textSecondary, other.textSecondary, t)!,
      textTertiary: Color.lerp(textTertiary, other.textTertiary, t)!,
      textPlaceholder: Color.lerp(textPlaceholder, other.textPlaceholder, t)!,
      textDisabled: Color.lerp(textDisabled, other.textDisabled, t)!,
      textDisabledOnBg: Color.lerp(
        textDisabledOnBg,
        other.textDisabledOnBg,
        t,
      )!,
      textInverse: Color.lerp(textInverse, other.textInverse, t)!,
      textDarkBoth: Color.lerp(textDarkBoth, other.textDarkBoth, t)!,
      textInverseSubtle: Color.lerp(
        textInverseSubtle,
        other.textInverseSubtle,
        t,
      )!,
      textAction: Color.lerp(textAction, other.textAction, t)!,
      textActionPressed: Color.lerp(
        textActionPressed,
        other.textActionPressed,
        t,
      )!,
      textActive: Color.lerp(textActive, other.textActive, t)!,
      textSuccess: Color.lerp(textSuccess, other.textSuccess, t)!,
      textSuccessSecondary: Color.lerp(
        textSuccessSecondary,
        other.textSuccessSecondary,
        t,
      )!,
      textError: Color.lerp(textError, other.textError, t)!,
      textErrorSecondary: Color.lerp(
        textErrorSecondary,
        other.textErrorSecondary,
        t,
      )!,
      textInfo: Color.lerp(textInfo, other.textInfo, t)!,
      textInfoSecondary: Color.lerp(
        textInfoSecondary,
        other.textInfoSecondary,
        t,
      )!,
      textWarning: Color.lerp(textWarning, other.textWarning, t)!,
      textWarningSecondary: Color.lerp(
        textWarningSecondary,
        other.textWarningSecondary,
        t,
      )!,
      textGold: Color.lerp(textGold, other.textGold, t)!,
      borderDefault: Color.lerp(borderDefault, other.borderDefault, t)!,
      borderSubtle: Color.lerp(borderSubtle, other.borderSubtle, t)!,
      borderStrong: Color.lerp(borderStrong, other.borderStrong, t)!,
      borderActive: Color.lerp(borderActive, other.borderActive, t)!,
      borderFocused: Color.lerp(borderFocused, other.borderFocused, t)!,
      borderActionPrimary: Color.lerp(
        borderActionPrimary,
        other.borderActionPrimary,
        t,
      )!,
      borderDisabled: Color.lerp(borderDisabled, other.borderDisabled, t)!,
      borderInverse: Color.lerp(borderInverse, other.borderInverse, t)!,
      borderSuccess: Color.lerp(borderSuccess, other.borderSuccess, t)!,
      borderError: Color.lerp(borderError, other.borderError, t)!,
      borderInfo: Color.lerp(borderInfo, other.borderInfo, t)!,
      borderWarning: Color.lerp(borderWarning, other.borderWarning, t)!,
      borderGold: Color.lerp(borderGold, other.borderGold, t)!,
      fgPrimary: Color.lerp(fgPrimary, other.fgPrimary, t)!,
      fgSecondary: Color.lerp(fgSecondary, other.fgSecondary, t)!,
      fgBrand: Color.lerp(fgBrand, other.fgBrand, t)!,
      fgPlaceholder: Color.lerp(fgPlaceholder, other.fgPlaceholder, t)!,
      fgActive: Color.lerp(fgActive, other.fgActive, t)!,
      fgDisabled: Color.lerp(fgDisabled, other.fgDisabled, t)!,
      fgDisabledOnBg: Color.lerp(fgDisabledOnBg, other.fgDisabledOnBg, t)!,
      fgInverse: Color.lerp(fgInverse, other.fgInverse, t)!,
      fgDarkBoth: Color.lerp(fgDarkBoth, other.fgDarkBoth, t)!,
      fgWhiteBoth: Color.lerp(fgWhiteBoth, other.fgWhiteBoth, t)!,
      fgAction: Color.lerp(fgAction, other.fgAction, t)!,
      fgActionPressed: Color.lerp(fgActionPressed, other.fgActionPressed, t)!,
      fgSuccess: Color.lerp(fgSuccess, other.fgSuccess, t)!,
      fgError: Color.lerp(fgError, other.fgError, t)!,
      fgInfo: Color.lerp(fgInfo, other.fgInfo, t)!,
      fgWarning: Color.lerp(fgWarning, other.fgWarning, t)!,
      fgGold: Color.lerp(fgGold, other.fgGold, t)!,
      alphaSm: Color.lerp(alphaSm, other.alphaSm, t)!,
      alphaMd: Color.lerp(alphaMd, other.alphaMd, t)!,
      alphaLg: Color.lerp(alphaLg, other.alphaLg, t)!,
      alphaLight: Color.lerp(alphaLight, other.alphaLight, t)!,
      alphaNav: Color.lerp(alphaNav, other.alphaNav, t)!,
      alphaNavBackground: Color.lerp(
        alphaNavBackground,
        other.alphaNavBackground,
        t,
      )!,
      alphaShade: Color.lerp(alphaShade, other.alphaShade, t)!,
      alphaBoth: Color.lerp(alphaBoth, other.alphaBoth, t)!,
      alphaBorder: Color.lerp(alphaBorder, other.alphaBorder, t)!,
      alphaSuccess: Color.lerp(alphaSuccess, other.alphaSuccess, t)!,
      alphaBrand: Color.lerp(alphaBrand, other.alphaBrand, t)!,
      alphaError: Color.lerp(alphaError, other.alphaError, t)!,
    );
  }

  /// Every token by its Figma name, in Figma order (for catalogues).
  Map<String, Color> get byFigmaName => {
    'bg-primary': bgPrimary,
    'bg-secondary': bgSecondary,
    'bg-tertiary': bgTertiary,
    'bg-neutral': bgNeutral,
    'bg-brand': bgBrand,
    'bg-active': bgActive,
    'bg-active-hover': bgActiveHover,
    'bg-action-primary': bgActionPrimary,
    'bg-action-primary_pressed': bgActionPrimaryPressed,
    'bg-action-secondary': bgActionSecondary,
    'bg-action-secondary_pressed': bgActionSecondaryPressed,
    'bg-action-inverse': bgActionInverse,
    'bg-action-destructive': bgActionDestructive,
    'bg-disabled': bgDisabled,
    'bg-dark': bgDark,
    'bg-success': bgSuccess,
    'bg-success_secondary': bgSuccessSecondary,
    'bg-error': bgError,
    'bg-error_secondary': bgErrorSecondary,
    'bg-warning': bgWarning,
    'bg-info': bgInfo,
    'bg-info_secondary': bgInfoSecondary,
    'bg-icons': bgIcons,
    'bg-avatar': bgAvatar,
    'bg-priority': bgPriority,
    'bg-gold': bgGold,
    'text-primary': textPrimary,
    'text-secondary': textSecondary,
    'text-tertiary': textTertiary,
    'text-placeholder': textPlaceholder,
    'text-disabled': textDisabled,
    'text-disabled-on_bg': textDisabledOnBg,
    'text-inverse': textInverse,
    'text-dark_both': textDarkBoth,
    'text-inverse_subtle': textInverseSubtle,
    'text-action': textAction,
    'text-action_pressed': textActionPressed,
    'text-active': textActive,
    'text-success': textSuccess,
    'text-success_secondary': textSuccessSecondary,
    'text-error': textError,
    'text-error_secondary': textErrorSecondary,
    'text-info': textInfo,
    'text-info_secondary': textInfoSecondary,
    'text-warning': textWarning,
    'text-warning_secondary': textWarningSecondary,
    'text-gold': textGold,
    'border-default': borderDefault,
    'border-subtle': borderSubtle,
    'border-strong': borderStrong,
    'border-active': borderActive,
    'border-focused': borderFocused,
    'border-action-primary': borderActionPrimary,
    'border-disabled': borderDisabled,
    'border-inverse': borderInverse,
    'border-success': borderSuccess,
    'border-error': borderError,
    'border-info': borderInfo,
    'border-warning': borderWarning,
    'border-gold': borderGold,
    'fg-primary': fgPrimary,
    'fg-secondary': fgSecondary,
    'fg-brand': fgBrand,
    'fg-placeholder': fgPlaceholder,
    'fg-active': fgActive,
    'fg-disabled': fgDisabled,
    'fg-disabled-on_bg': fgDisabledOnBg,
    'fg-inverse': fgInverse,
    'fg-dark_both': fgDarkBoth,
    'fg-white_both': fgWhiteBoth,
    'fg-action': fgAction,
    'fg-action_pressed': fgActionPressed,
    'fg-success': fgSuccess,
    'fg-error': fgError,
    'fg-info': fgInfo,
    'fg-warning': fgWarning,
    'fg-gold': fgGold,
    'Alpha-sm': alphaSm,
    'Alpha-md': alphaMd,
    'Alpha-lg': alphaLg,
    'Alpha-light': alphaLight,
    'Alpha-nav': alphaNav,
    'Alpha-nav_background': alphaNavBackground,
    'Alpha-shade': alphaShade,
    'Alpha-both': alphaBoth,
    'Alpha-border': alphaBorder,
    'Alpha-success': alphaSuccess,
    'Alpha-brand': alphaBrand,
    'Alpha-error': alphaError,
  };
}

/// `context.colors.bgPrimary` etc.
extension SampathColorsContext on BuildContext {
  SampathColors get colors {
    final colors = Theme.of(this).extension<SampathColors>();
    assert(
      colors != null,
      'SampathColors is not registered. Add SampathColors.light or '
      '.dark to ThemeData.extensions.',
    );
    return colors ?? SampathColors.light;
  }
}
