// GENERATED CODE — DO NOT EDIT BY HAND.
// Source: tokens/design.tokens.json · Generator: tool/generate_tokens.dart
// To change a value, re-export the tokens from Figma and rerun the generator.

/// Mobile layout and component spacing rules
/// (`Component collection` › Mobile). See DESIGN.md §3.7.
abstract final class SampathLayout {
  // Layout
  /// 16px is the margin for all the screens throughout the app
  static const double screenMargin = 16.0; // Space-XL
  /// This is the gap between main sections inside a page
  static const double sectionGap = 24.0; // Space-3XL
  /// Secondary option for the gap between main sections
  static const double sectionGapLarge = 32.0; // Space-4XL
  /// This should be the gap between header to 1st component through out the app
  static const double headerToContent = 16.0; // Space-XL

  // Component
  /// Inside every card component, 16px should be the padding on all sides
  static const double cardPadding = 16.0; // Space-XL
  static const double cardGapSmall = 8.0; // Space-M
  static const double cardGapMedium = 16.0; // Space-XL
  static const double cardGapLarge = 24.0; // Space-3XL
  /// This should be the padding inside input fields on all sides
  static const double inputPadding = 16.0; // Space-XL
  /// This should be the padding inside lists component
  static const double listPadding = 16.0; // Space-XL
  /// This should be the gap between icon and text
  static const double iconText = 8.0; // Space-M
  /// This should be the gap between buttons
  static const double buttonGap = 12.0; // Space-L

  /// Every token by its Figma name, in Figma order (for catalogues).
  static const Map<String, double> byFigmaName = {
    'Layout/screen-margin': screenMargin,
    'Layout/section-gap': sectionGap,
    'Layout/section-gap_large': sectionGapLarge,
    'Layout/header-to-content': headerToContent,
    'Component/card-padding': cardPadding,
    'Component/card-gap_small': cardGapSmall,
    'Component/card-gap_medium': cardGapMedium,
    'Component/card-gap_large': cardGapLarge,
    'Component/input-padding': inputPadding,
    'Component/list-padding': listPadding,
    'Component/icon-text': iconText,
    'Component/button-gap': buttonGap,
  };
}
