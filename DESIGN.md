# Sampath Bank — Design System

> **Status:** Draft v0.2 · Last synced with Figma: 12 Oct 2026
> **Platform:** Flutter (mobile app)
> **Owner:** Design (Sathila)

This file is the **single source of truth** for the Sampath Bank mobile design system. It describes **what** the system is: tokens, styles, icons and components. How Claude Code should work in this repo is in [`CLAUDE.md`](./CLAUDE.md).

If this file and Figma disagree, **Figma wins**. Flag the difference so this file can be updated.

---

## Contents

1. [Sources of truth](#1-sources-of-truth)
2. [Core rules](#2-core-rules)
3. [Foundations: tokens](#3-foundations-tokens)
4. [Foundations: styles (not variables)](#4-foundations-styles-not-variables)
5. [Motion](#5-motion)
6. [Icons](#6-icons)
7. [Component architecture](#7-component-architecture)
8. [Component inventory and build status](#8-component-inventory-and-build-status)
9. [Component specs](#9-component-specs)
10. [Known issues and open decisions](#10-known-issues-and-open-decisions)
11. [Changelog](#11-changelog)

---

## 1. Sources of truth

| What | Where | Figma file key |
|---|---|---|
| Foundations (variables, text/color/effect/grid styles) | [Foundation – Sampath Bank](https://www.figma.com/design/Z4B0Qjw4IfoGY5UHmgpbnp/Foundation---Sampath-Bank) | `Z4B0Qjw4IfoGY5UHmgpbnp` |
| Components | [Mobile component library – Sampath Bank](https://www.figma.com/design/Osc9AnJnbWQLesqVlhNsii/Mobile-component-library---Sampath-Bank) | `Osc9AnJnbWQLesqVlhNsii` |
| Brand icons | [Sampath iconography](https://www.figma.com/design/ztpSPR24LsEQl2L4OxUX3T/Sampath-iconography), page **"brand icon"** only (node `151:10`) | `ztpSPR24LsEQl2L4OxUX3T` |
| Utility icons | [Iconoir](https://iconoir.com), Flutter package `iconoir_flutter` | — |
| Token values (exported) | `tokens/design.tokens.json` | — |

**Token export:** Figma variables are exported with the **TokensBruecke** plugin (DTCG 2025.10 format, colors as hex). To update, re-export, replace `tokens/design.tokens.json`, and regenerate the Dart token files. Never edit the generated files by hand.

**Out of scope:** In the component file, ignore every page below **🔒 Do not use** (Notes, Dialogs, Image ratios, Tabs). In the iconography file, ignore the **Icon library** page.

---

## 2. Core rules

1. **Tokens only.** Components never contain raw hex values, pixel numbers or font sizes. Every color, space, radius and text style comes from a token. The only exceptions are artwork colors inside brand icons, illustrations and logos.
2. **Use semantic colors in components.** Components use the `Color collection` tokens (`bg-*`, `text-*`, `border-*`, `fg-*`, `Alpha-*`). Primitive and alias colors exist only so semantic tokens can point to them.
3. **Light and dark.** Every semantic color has a Light and a Dark value. Components must look correct in both. Never branch on theme inside a component; read the token.
4. **Mobile spacing rules.** The app is mobile only. Use the component tokens in [§3.7](#37-component-tokens-mobile-layout) for these:

   | Rule | Value | Token |
   |---|---|---|
   | Screen margin (left and right) | 16 | `screen-margin` |
   | Header → first component, throughout the app | 16 | `header-to-content` |
   | Between main sections of a page | 24 | `section-gap` |
   | Between main sections, edge case (**not used yet**, reserved for the future) | 32 | `section-gap_large` |
   | Icon → text | 8 | `icon-text` |
   | Padding inside frames (cards, inputs, lists, containers), all sides | 16 | `card-padding`, `input-padding`, `list-padding` |

   - **Normal spacing steps:** 8, 12, 16, 24, 32 (`Space-M`, `Space-L`, `Space-XL`, `Space-3XL`, `Space-4XL`).
   - **Edge cases only:** 2, 4, 6 (`Space-XXS`, `Space-XS`, `Space-S`).
   - Larger values (40 and up) aren't used inside the app.
   - **Report differences.** If a frame in Figma has padding other than 16, or a gap that isn't one of the steps above, report it to design instead of copying it silently. Use `section-gap_large` only when the Figma design shows it.
5. **Slots take design-system components.** A slot (for example the body of a Bottom sheet) accepts any widget in code, so it must only be filled with design-system components (list items, input fields…), never one-off layouts. **The container owns the outer padding and scrolling**, and slot content must not add its own outer padding, so spacing stays correct when content is swapped. See [§7.3](#73-figma-properties--flutter-parameters).
6. **Match Figma names.** Code names come from Figma names, converted to Dart style (see [§3.8](#38-figma--flutter-naming)). Don't invent new names.
7. **Accessibility.** Minimum touch target is 44 × 44 even if the visual is smaller. Every icon-only control needs a semantic label. Respect the OS "Reduce motion" setting (see [§5](#5-motion)).

---

## 3. Foundations: tokens

Source: `tokens/design.tokens.json`, with 471 variables in 6 collections.

| Collection | Count | Modes | Purpose |
|---|---|---|---|
| `Primitives` | 156 | — | Raw color scales, type scale, sizes |
| `Alias Typography` | 92 | Mobile | Text style building blocks (family, weight, size, line height) |
| `Alias Colors` | 92 | — | Role names for primitive scales |
| `Color collection` | 89 | **Light / Dark** | **Semantic colors that components use** |
| `Alias Spacing & Radius` | 30 | — | Spacing and radius scales |
| `Component collection` | 12 | — | Layout and component spacing rules |

### 3.1 Primitive colors

_Collection `Primitives` → `Colors`. Never use these directly in components; use the semantic tokens below._

| Scale | 50 | 100 | 200 | 300 | 400 | 500 | 600 | 700 | 800 | 900 |
|---|---|---|---|---|---|---|---|---|---|---|
| Orange (`Orange-*`) | `#fde7d6` | `#fcd5ba` | `#fac199` | `#f8a56a` | `#f6944d` | `#f47921` | `#de6e1e` | `#ad5617` | `#864312` | `#66330e` |
| Spring wood (`SpringWood-*`) | `#fefefd` | `#fdfbfa` | `#fbf9f8` | `#faf7f4` | `#f9f5f2` | `#f7f3ef` | `#e1ddd9` | `#afadaa` | `#888683` | `#686664` |
| Mirage (`Mirage-*`) | `#e8e8e9` | `#b6b9bc` | `#93979c` | `#62686e` | `#434a52` | `#141d27` | `#121a23` | `#0e151c` | `#0b1015` | `#080c10` |
| Woodsmoke (`Woodsmoke-*`) | `#e8e8e8` | `#b6b6b7` | `#939394` | `#626263` | `#1e1e21` | `#141416` | `#121214` | `#0e0e10` | `#0b0b0c` | `#080809` |
| Violet (`Violet-*`) | `#efeafc` | `#cdbff5` | `#b59ff1` | `#9374ea` | `#7e59e6` | `#5e2fe0` | `#562bcc` | `#43219f` | `#341a7b` | `#27145e` |
| Green (`Green-*`) | `#eaf6ef` | `#bee4cc` | `#9fd7b3` | `#73c590` | `#58b97b` | `#2ea85a` | `#2a9952` | `#217740` | `#195c32` | `#244a3e` |
| Red (`Red-*`) | `#f9e9e9` | `#edbaba` | `#e49998` | `#d86b69` | `#d14e4c` | `#c5221f` | `#b31f1c` | `#8c1816` | `#6c1311` | `#6b211b` |
| Yellow (`Yellow-*`) | `#fcf3ea` | `#f4dabf` | `#efc8a0` | `#e8af75` | `#e49f5a` | `#dd8731` | `#c97b2d` | `#9d6023` | `#7a4a1b` | `#5d3915` |
| Peach Yellow (`PeachYellow-*`) | `#fffcf6` | `#fef6e3` | `#fdf1d6` | `#fcebc3` | `#fce7b8` | `#fbe1a6` | `#e4cd97` | `#b2a076` | `#8a7c5b` | `#695f46` |

Brand Key: `White` = `#ffffff`, `Black` = `#000000`

### 3.2 Alias colors

_Collection `Alias Colors` → `Colors`. Role names that point 1:1 at a primitive scale (step for step)._

| Alias group | Token pattern | Points to |
|---|---|---|
| Primary1 | `Primary1-50 … -900` | Orange (`Orange-*`) |
| Primary2 | `Primary2-50 … -900` | Spring wood (`SpringWood-*`) |
| Text | `Text-50 … -900` | Mirage (`Mirage-*`) |
| Secondary | `Secondary-50 … -900` | Woodsmoke (`Woodsmoke-*`) |
| Tertiary | `Tertiary-50 … -900` | Violet (`Violet-*`) |
| Success | `Success-50 … -900` | Green (`Green-*`) |
| Warning | `Warning-50 … -900` | Yellow (`Yellow-*`) |
| Error | `Error-50 … -900` | Red (`Red-*`) |
| Warning secondary | `WarningSecondary-50 … -900` | Peach Yellow (`PeachYellow-*`) |
| Key | `White`, `Black` | Brand Key White, Black |

### 3.3 Semantic colors (Light / Dark)

_Collection `Color collection`, modes **Light** and **Dark**. **Components must only use these.** Hex values are resolved for reference; code must reference the token, not the hex._

#### Background

| Token | Light | Dark | Use |
|---|---|---|---|
| `bg-primary` | Primary2-500 `#f7f3ef` | Secondary-500 `#141416` | Use this for main background of the screens |
| `bg-secondary` | White `#ffffff` | Secondary-400 `#1e1e21` | Use this color for card frames, popups, modals, input field, bottom nav, action icons |
| `bg-tertiary` | Primary1-100 `#fcd5ba` | Primary1-700 `#ad5617` | Use this for info callout notification backgrounds |
| `bg-neutral` | Primary2-500 `#f7f3ef` | Secondary-900 `#080809` | Use this for badge neutral background |
| `bg-brand` | Primary1-500 `#f47921` | Primary1-500 `#f47921` | Use this for brand related backgrounds |
| `bg-active` | Primary1-50 `#fde7d6` | Primary1-900 `#66330e` | Use this color for active or selected state backgrounds |
| `bg-active-hover` | Primary1-100 `#fcd5ba` | Primary1-800 `#864312` | Use this color for hover state of active or selected backgrounds |
| `bg-action-primary` | Primary1-600 `#de6e1e` | Primary1-500 `#f47921` | Mainly use for primary button backgrounds |
| `bg-action-primary_pressed` | Primary1-700 `#ad5617` | Primary1-700 `#ad5617` | Mainly use for pressed or hover states of primary button backgrounds |
| `bg-action-secondary` | Primary2-600 `#e1ddd9` | Secondary-900 `#080809` | Use this for swipe button background |
| `bg-action-secondary_pressed` | Primary1-100 `#fcd5ba` | Primary1-800 `#864312` | Mainly use for pressed or hover states of secondary button backgrounds |
| `bg-action-inverse` | White `#ffffff` | White `#ffffff` | Use this white call to actions |
| `bg-action-destructive` | Error-500 `#c5221f` | Error-400 `#d14e4c` | Use this color for destructive buttons |
| `bg-disabled` | Primary2-600 `#e1ddd9` | Secondary-300 `#626263` | Use this for disabled backgrounds |
| `bg-dark` | Secondary-900 `#080809` | Tertiary-900 `#27145e` | Use this for toast/snackbar backgrounds |
| `bg-success` | Success-100 `#bee4cc` | Success-900 `#244a3e` | Use this for success backgrounds. (notification, badge) |
| `bg-success_secondary` | Success-50 `#eaf6ef` | Success-800 `#195c32` | Secondary version for success backgrounds. (notification, badge) |
| `bg-error` | Error-100 `#edbaba` | Error-900 `#6b211b` | Use this for error backgrounds. (notification, badge) |
| `bg-error_secondary` | Error-50 `#f9e9e9` | Error-800 `#6c1311` | Secondary version for error backgrounds. (notification, badge) |
| `bg-warning` | Warning-100 `#f4dabf` | Warning-900 `#5d3915` | Use this for warning backgrounds. (notification, badge) |
| `bg-info` | Tertiary-100 `#cdbff5` | Tertiary-900 `#27145e` | Use this for info backgrounds. (notification, badge) |
| `bg-info_secondary` | Tertiary-50 `#efeafc` | Tertiary-800 `#341a7b` | Secondary color for info backgrounds. (notification, badge) |
| `bg-icons` | Primary1-50 `#fde7d6` | Primary1-900 `#66330e` | Use this for icon or avatar backgrounds |
| `bg-avatar` | Secondary-50 `#e8e8e8` | Secondary-900 `#080809` | Use this for avatar backgrounds with logos |
| `bg-priority` | WarningSecondary-500 `#fbe1a6` | WarningSecondary-900 `#695f46` | Use this for priority banners |
| `bg-gold` | WarningSecondary-400 `#fce7b8` | WarningSecondary-800 `#8a7c5b` | Use this for loyalty backgrounds |

#### Text

| Token | Light | Dark | Use |
|---|---|---|---|
| `text-primary` | Text-500 `#141d27` | Primary2-100 `#fdfbfa` | Use this for Titles and headings |
| `text-secondary` | Text-300 `#62686e` | Primary2-600 `#e1ddd9` | Use this for description texts |
| `text-tertiary` | Text-400 `#434a52` | Primary2-700 `#afadaa` | Use this for captions, overlines, hints |
| `text-placeholder` | Text-300 `#62686e` | Text-100 `#b6b9bc` | Use this for input field placeholder text |
| `text-disabled` | Text-100 `#b6b9bc` | Text-300 `#62686e` | Use this for disabled text |
| `text-disabled-on_bg` | Text-200 `#93979c` | Text-100 `#b6b9bc` | Use this for disabled text on backgrounds. (buttons, badge, chips) |
| `text-inverse` | White `#ffffff` | White `#ffffff` | Use this text color on brand backgrounds |
| `text-dark_both` | Text-500 `#141d27` | Text-500 `#141d27` | Use this text color on brand backgrounds when needed in both dark and light modes |
| `text-inverse_subtle` | Text-100 `#b6b9bc` | Text-100 `#b6b9bc` | Secondary text color for on brand backgrounds |
| `text-action` | Primary1-600 `#de6e1e` | Primary1-500 `#f47921` | Use this for text links, secondary buttons |
| `text-action_pressed` | Primary1-700 `#ad5617` | Primary1-400 `#f6944d` | Pressed state color for text-link |
| `text-active` | Primary1-500 `#f47921` | Primary1-500 `#f47921` | Use this for input field labels in typing or complete states |
| `text-success` | Success-500 `#2ea85a` | Success-400 `#58b97b` | Use this for success texts |
| `text-success_secondary` | Success-800 `#195c32` | Success-100 `#bee4cc` | Secondary darker version of a success color (notifications, banners) |
| `text-error` | Error-500 `#c5221f` | Error-400 `#d14e4c` | Use this for error texts |
| `text-error_secondary` | Error-800 `#6c1311` | Error-100 `#edbaba` | Secondary darker version of a error text (notifications, banners) |
| `text-info` | Tertiary-500 `#5e2fe0` | Tertiary-400 `#7e59e6` | Use this for information texts |
| `text-info_secondary` | Tertiary-800 `#341a7b` | Tertiary-100 `#cdbff5` | Secondary darker version of a informartion text (notifications, banners) |
| `text-warning` | Warning-500 `#dd8731` | Warning-400 `#e49f5a` | Use this for warning texts |
| `text-warning_secondary` | Warning-800 `#7a4a1b` | Warning-100 `#f4dabf` | Secondary darker version of a warning text (notifications, banners) |
| `text-gold` | WarningSecondary-800 `#8a7c5b` | WarningSecondary-200 `#fdf1d6` | Use this for loyalty texts |

#### Border

| Token | Light | Dark | Use |
|---|---|---|---|
| `border-default` | Primary2-600 `#e1ddd9` | Primary2-900 `#686664` | default border color. Can use this for dividers as well |
| `border-subtle` | Secondary-50 `#e8e8e8` | Text-400 `#434a52` | Subtle version of border color |
| `border-strong` | Primary2-800 `#888683` | Primary2-600 `#e1ddd9` | Strong version of border color (radio buttons) |
| `border-active` | Primary1-500 `#f47921` | Primary1-500 `#f47921` | Use for active or selected states. Can use for typing state of input fields. |
| `border-focused` | Primary1-500 `#f47921` | Primary1-500 `#f47921` | Use this for focus ring, or focused states |
| `border-action-primary` | Primary1-500 `#f47921` | Primary1-500 `#f47921` | Use this for outline (secondary) buttons |
| `border-disabled` | Secondary-200 `#939394` | Secondary-300 `#626263` | Use for disabled borders |
| `border-inverse` | White `#ffffff` | White `#ffffff` | Borders on brand color |
| `border-success` | Success-500 `#2ea85a` | Success-500 `#2ea85a` | Border for success color |
| `border-error` | Error-500 `#c5221f` | Error-500 `#c5221f` | Border for error color |
| `border-info` | Tertiary-500 `#5e2fe0` | Tertiary-500 `#5e2fe0` | Border for information color |
| `border-warning` | Warning-500 `#dd8731` | Warning-500 `#dd8731` | Border for warning color |
| `border-gold` | WarningSecondary-600 `#e4cd97` | WarningSecondary-500 `#fbe1a6` | Border for loyalty color |

#### Foreground

| Token | Light | Dark | Use |
|---|---|---|---|
| `fg-primary` | Text-500 `#141d27` | Primary2-100 `#fdfbfa` | Primary icon color |
| `fg-secondary` | Text-300 `#62686e` | Primary2-600 `#e1ddd9` | Secondary icon color. (input fields, Close, chevron) |
| `fg-brand` | Primary1-500 `#f47921` | Primary1-400 `#f6944d` | Brand related icons |
| `fg-placeholder` | Secondary-200 `#939394` | Secondary-100 `#b6b6b7` | Icon color for input field icons |
| `fg-active` | Primary1-600 `#de6e1e` | Primary1-400 `#f6944d` | Icons on active state |
| `fg-disabled` | Text-100 `#b6b9bc` | Text-300 `#62686e` | disabled icon |
| `fg-disabled-on_bg` | Text-200 `#93979c` | Text-100 `#b6b9bc` | Disabled icon color on background |
| `fg-inverse` | White `#ffffff` | White `#ffffff` | Icons on brand color |
| `fg-dark_both` | Text-300 `#62686e` | Text-300 `#62686e` | Darker icons for both light and dark modes |
| `fg-white_both` | White `#ffffff` | White `#ffffff` | Light icons on brand backgrounds for both dark and light modes |
| `fg-action` | Primary1-600 `#de6e1e` | Primary1-400 `#f6944d` | Color for action icons |
| `fg-action_pressed` | Primary1-700 `#ad5617` | Primary1-300 `#f8a56a` | Pressed or hover state color for action icons |
| `fg-success` | Success-500 `#2ea85a` | Success-400 `#58b97b` | Color for success icons |
| `fg-error` | Error-500 `#c5221f` | Error-400 `#d14e4c` | Color for error icons |
| `fg-info` | Tertiary-500 `#5e2fe0` | Tertiary-400 `#7e59e6` | Color for information icon |
| `fg-warning` | Warning-500 `#dd8731` | Warning-400 `#e49f5a` | Color for warning icons |
| `fg-gold` | WarningSecondary-800 `#8a7c5b` | WarningSecondary-400 `#fce7b8` | Color for loyalty icons |

#### Alpha

| Token | Light | Dark | Use |
|---|---|---|---|
| `Alpha-sm` | Secondary-500 @ 16% `#14141629` | Secondary-500 @ 16% `#14141629` | mainly used in the small CTAs inside branded cards |
| `Alpha-md` | Secondary-500 @ 40% `#14141666` | Secondary-500 @ 40% `#14141666` | — |
| `Alpha-lg` | Secondary-500 @ 75% `#141416bf` | Secondary-500 @ 75% `#141416bf` | Used in scan QR code interface overlay |
| `Alpha-light` | White @ 12% `#ffffff1f` | White @ 12% `#ffffff1f` | Use this to show more depth to elements on brand background |
| `Alpha-nav` | White @ 75% `#ffffffbf` | White @ 6% `#ffffff0f` | Use this in bottom navigation backgrounds, and loading overlay |
| `Alpha-nav_background` | White @ 40% `#ffffff66` | Secondary-500 @ 40% `#14141666` | — |
| `Alpha-shade` | Primary2-500 @ 0% `#f7f3ef00` | Secondary-500 @ 0% `#14141600` | — |
| `Alpha-both` | Secondary-500 @ 42% `#1414166b` | Secondary-500 @ 42% `#1414166b` | Used in overlay backgrounds |
| `Alpha-border` | Secondary-500 @ 8% `#14141614` | Secondary-500 @ 2% `#14141605` | used for borders of back icon circle |
| `Alpha-success` | Success-500 @ 16% `#2ea85a29` | Success-500 @ 16% `#2ea85a29` | — |
| `Alpha-brand` | Primary1-500 @ 16% `#f4792129` | Primary1-500 @ 16% `#f4792129` | — |
| `Alpha-error` | Error-500 @ 16% `#c5221f29` | Error-500 @ 16% `#c5221f29` | — |

### 3.4 Typography

Font family: **Hanken Grotesk** (`Primitives/Typography/Font style/Primary-font`). Letter spacing 0 for all styles.

**Script fallback (code only, not in Figma):** Hanken Grotesk covers Latin only. Every text style sets `fontFamilyFallback` to **Noto Sans Sinhala**, then **Noto Sans Tamil** (Google Fonts, OFL, weights 400–800 bundled), so Sinhala and Tamil text renders in the same weight as the style. The fallback is set in `tool/generate_tokens.dart`, not in the token export. Line heights are the same as for Latin; see the Typography page in Widgetbook to check them per script.

| Text style (Figma) | Variable group | Weight | Size | Line height | Note |
|---|---|---|---|---|---|
| `Display/Large-H1` | `Display Large-H1` | 800 | 36 | 46.8 |  |
| `Display/Medium-H2` | `Display Medium-H2` | 800 | 32 | 41.6 |  |
| `Display/Small-H3` | `Display Small-H3` | 800 | 28 | 39.2 |  |
| `Headline/Large-H4` | `Headline Large-H4` | 800 | 24 | 33.6 |  |
| `Headline/Medium-H5` | `Headline Medium-H5` | 700 | 20 | 28 |  |
| `Headline/Small-H6` | `Headline Small-H6` | 700 | 16 | 24 |  |
| `Body/Large` | `Body L` | 400 | 16 | 24 |  |
| `Body/Medium` | `Body M` | 400 | 14 | 21 |  |
| `Body/Small` | `Body S` | 400 | 12 | 18 |  |
| `Title/XLarge` | `Title XL` | 600 | 32 | 41.6 | To show balance |
| `Title/Large` | `Title L` | 600 | 18 | 25.2 | To show balance |
| `Title/Medium` | `Title M` | 600 | 16 | 24 |  |
| `Title/Small` | `Title S` | 600 | 14 | 21 |  |
| `Label/Large` | `Label L` | 600 | 16 | 24 |  |
| `Label/Medium` | `Label M` | 600 | 14 | 21 |  |
| `Label/Small` | `Label S` | 600 | 12 | 18 |  |
| `Caption/Large` | `Caption L` | 500 | 12 | 18 |  |
| `Caption/Medium` | `Caption M` | 500 | 11 | 16.5 |  |
| `Caption/Small` | `Caption S` | 600 | 10 | 15 |  |
| `Button/XLarge` | `Button XL` | 700 | 18 | 24 |  |
| `Button/Large` | `Button L` | 700 | 16 | 24 |  |
| `Button/Medium` | `Button M` | 700 | 14 | 24 |  |
| `Button/Small` | `Button S` | 700 | 12 | 24 |  |

### 3.5 Spacing

_Collection `Alias Spacing & Radius` → `Spacing`. In practice the app uses up to `Space-4XL` (32)._

| Token | Value |
|---|---|
| `Space-none` | 0 |
| `Space-XXS` | 2 |
| `Space-XS` | 4 |
| `Space-S` | 6 |
| `Space-M` | 8 |
| `Space-L` | 12 |
| `Space-XL` | 16 |
| `Space-2XL` | 20 |
| `Space-3XL` | 24 |
| `Space-4XL` | 32 |
| `Space-5XL` | 40 |
| `Space-6XL` | 48 |
| `Space-7XL` | 56 |
| `Space-8XL` | 64 |
| `Space-9XL` | 80 |
| `Space-10XL` | 96 |
| `Space-11XL` | 120 |
| `Space-12XL` | 343 |
| `Space-13XL` | 375 |
| `Space-14XL` | 1024 |
| `Space-15XL` | 1280 |
| `Space-16XL` | 1440 |
| `Space-17XL` | 1920 |

### 3.6 Radius

| Token | Value |
|---|---|
| `Radius-none` | 0 |
| `Radius-XS` | 4 |
| `Radius-S` | 8 |
| `Radius-M` | 12 |
| `Radius-L` | 16 |
| `Radius-XL` | 24 |
| `Radius-Full` | 999999 (fully rounded / pill) |

### 3.7 Component tokens (mobile layout)

_Collection `Component collection` → `Mobile`._

| Token | Points to | Value | Use |
|---|---|---|---|
| `Layout/screen-margin` | `Space-XL` | 16 | 16px is the margin for all the screens throughout the app |
| `Layout/section-gap` | `Space-3XL` | 24 | This is the gap between main sections inside a page |
| `Layout/section-gap_large` | `Space-4XL` | 32 | Secondary option for the gap between main sections (**not used yet**) |
| `Layout/header-to-content` | `Space-XL` | 16 | This should be the gap between header to 1st component through out the app |
| `Component/card-padding` | `Space-XL` | 16 | Inside every card component, 16px should be the padding on all sides |
| `Component/card-gap_small` | `Space-M` | 8 | — |
| `Component/card-gap_medium` | `Space-XL` | 16 | — |
| `Component/card-gap_large` | `Space-3XL` | 24 | — |
| `Component/input-padding` | `Space-XL` | 16 | This should be the padding inside input fields on all sides |
| `Component/list-padding` | `Space-XL` | 16 | This should be the padding inside lists component |
| `Component/icon-text` | `Space-M` | 8 | This should be the gap between icon and text |
| `Component/button-gap` | `Space-L` | 12 | This should be the gap between buttons |

### 3.8 Figma → Flutter naming

All generated code lives in `packages/sampath_ds/lib/tokens/` and is **generated from `tokens/design.tokens.json`**. Don't edit those files by hand.

| Figma token | Dart access | Rule |
|---|---|---|
| `bg-action-primary_pressed` | `context.colors.bgActionPrimaryPressed` | Semantic colors live in a `ThemeExtension` (`SampathColors`) with a light and a dark instance. `-` and `_` become camelCase. |
| `Alpha-nav_background` | `context.colors.alphaNavBackground` | Same as above |
| `Space-XL`, `Space-2XL` | `SampathSpacing.xl`, `SampathSpacing.x2l` | A number can't start a Dart name, so `2XL` becomes `x2l` |
| `Radius-M`, `Radius-Full` | `SampathRadius.m`, `SampathRadius.full` | `full` = 999999, i.e. a pill / circle |
| `Mobile/Layout/screen-margin` | `SampathLayout.screenMargin` | Component collection |
| `Mobile/Component/card-padding` | `SampathLayout.cardPadding` | Component collection |
| Text style `Body/Large` | `SampathTextStyles.bodyLarge` | Use the **text style** name (see the table in §3.4) |
| `Primitives`, `Alias Colors` | `SampathPalette.orange500` etc. | Generated for reference only. **Components must not use them.** |

**Export quirks the token script must handle:**
- **Font weights** are exported as `{ "value": 800, "unit": "px" }`. Ignore the unit; they are plain weights (`FontWeight.w800`).
- **Line heights** are exported in px. Flutter needs a ratio: `height = lineHeight / fontSize` (for example 24 / 16 = 1.5).
- **Alpha colors** are exported as `{ "components": "{Alias Colors…}", "alpha": 0.16 }`. This isn't standard DTCG, so the script must resolve the referenced color and apply the alpha.
- **Aliases** (`{Collection.Group.Token}`) must be resolved per mode (Light/Dark).

---

## 4. Foundations: styles (not variables)

These are saved as Figma **styles**, not variables, so they are **not** in the token JSON. Their values are recorded here. Claude Code puts them in `packages/sampath_ds/lib/tokens/styles.dart` by hand, and they must be updated here and in code whenever the Figma style changes.

### 4.1 Text styles

There are 23 styles, all linked to `Alias Typography` variables. Names and values are in [§3.4](#34-typography).

### 4.2 Gradients (color styles)

| Style | Type | Start (0%) | End (100%) | Status |
|---|---|---|---|---|
| `Luxury purple` | Linear | `#5e2fe0` (= Violet-500) | `#7e59e6` (= Violet-400) | ✅ |
| `Vermilion` | Linear | `#f26722` | `#dc5e1f` | ⚠️ Not on the brand orange scale; to be updated by design (see §10) |
| `Assistant` | Linear | `#fde7d6` (= Orange-50) | `#ffffff` (= White) | ✅ |

- The gradient stops are fixed hex values in Figma, not linked to variables. In code, build each stop from the matching token where one exists (Violet-500, Violet-400, Orange-50, White).
- **Direction:** take the gradient handles (angle) from the Figma style when building. Don't guess.
  - Done (12 Oct 2026): the styles use a skewed `gradientTransform`, so no single angle reproduces them on every aspect ratio. `styles.dart` applies Figma's matrix directly (`SampathFigmaGradientTransform`). `Luxury purple` and `Vermilion` share `[[0.9817, 0.3619, -0.3436], [-2.4627, 1.237, 1.362]]`; `Assistant` is `[[1.2801, 0.3041, 0], [-1.7932, 1.511, 0.5]]`. If a gradient's handles change in Figma, update these numbers.
- Gradients don't change between Light and Dark.

### 4.3 Shadows and effects (effect styles)

| Style | Layers (x, y, blur, spread, color) | Use |
|---|---|---|
| `Shadow/Resting_cards` | Drop: 0, 1, 3, 0, `#000000` 5% (`#0000000d`) | Cards at rest |
| `Shadow/Panel_sheets` | Drop: 0, 2, 10, 0, `#000000` 4% (`#0000000a`) | Panels and bottom sheets |
| `Shadow/Floating_nav-search` | Drop: 0, 2, 8, 0, `#140f0a` 8% (`#140f0a14`) **+** Drop: 0, 8, 30, 0, `#140f0a` 16% (`#140f0a29`) **+** background blur 20 | Floating bottom nav, search |
| `Shadow/Back` | Drop: 0, 2, 10, 0, `#0b1b2b` 6% (`#0b1b2b0f`) **+** Inner: 0, 1, 0, 0, `#ffffff` 40% (`#ffffff66`) | Back button circle |
| `Shadow/Sticky` | Drop: 0, **−2**, 16, 0, `#221f1f` 8% (`#221f1f14`) | Sticky bottom elements (the shadow falls upward) |

- In Flutter, a figure from Figma's **blur** maps to `BoxShadow.blurRadius` directly.
- **Background blur** (Floating_nav-search) needs a `BackdropFilter` with `ImageFilter.blur(sigmaX: 10, sigmaY: 10)`. Figma's blur 20 ≈ sigma 10.
- **Inner shadows** have no built-in `BoxShadow` version in Flutter. Use a small custom painter or a 1 px top highlight border to match `Shadow/Back`.

### 4.4 Layout grids (grid styles)

| Style | Columns | Gutter | Margin | Alignment |
|---|---|---|---|---|
| `Mobile` | 4 | 12 (`Space-L`) | 16 (`screen-margin`) | Stretch |
| `Desktop-lg` | 12 | 24 (`Space-3XL`) | 120 (`Space-11XL`) | Stretch |

The app is mobile only. `Desktop-lg` is recorded for reference and isn't used in the Flutter package.

---

## 5. Motion

> **Status: deferred. Don't build yet.** Don't create motion tokens or add animations to components until design confirms this section.
>
> **Planned direction:** use **Material 3 motion** ([how it works](https://m3.material.io/styles/motion/overview/how-it-works)), meaning its easing and duration pairs. Flutter ships these as the `Easing` (for example `Easing.emphasizedDecelerate`, `Easing.standard`) and `Durations` (for example `Durations.medium2`) classes, so the package can use them directly instead of custom values. When this is picked up:
> 1. Check the current M3 guidance first, since Material's motion guidance has been updated over time.
> 2. Map each use (enter, exit, button color, scroll, etc.) to an M3 easing + duration pair.
> 3. Compare with the prototype values below and with the Figma animations page, and agree any differences with design.
>
> The values below come from the AI-assistant chat prototype (`github.com/sathila-18/Sampath`, `MOTION_SPEC.md`). They're kept for reference only.

| Token | Value | Use |
|---|---|---|
| `easeInOut` | `Cubic(0.42, 0, 0.58, 1)` (= `Curves.easeInOut`) | Default curve for all motion |
| `enter` | 360 ms | Elements appearing: fade in plus rise 8 px |
| `riseOffset` | 8 px | Start offset for rise-in |
| `buttonColor` | 150 ms, `Cubic(0.25, 0.1, 0.25, 1)` (= `Curves.ease`) | Button background color change |
| `scroll` | 450 ms | Animated scroll to new content |

**Reduce motion:** every animation checks `MediaQuery.disableAnimationsOf(context)`. When it's on, elements appear instantly and loops stop.

Feature-specific motion, such as the mascot "Morning stretch" and the "Thinking…" shimmer, lives with that feature, not in this package.

---

## 6. Icons

### 6.1 Rules

| Type | Source | Style | Color |
|---|---|---|---|
| **Utility icons** (arrows, chevrons, close, search, lock, eye…) | **Iconoir**, Flutter package `iconoir_flutter` **pinned to `7.12.1`** | Line icons drawn on a 24 × 24 grid, 1.5 stroke | **Recolored per use** with an `fg-*` token. Changes in dark mode. |
| **Brand icons** (Sampath-specific pictograms) | Custom SVGs from the brand icon file, in `assets/icons/brand/` | Full-color filled tiles, 24 × 24 | **Never recolor or tint.** Same in light and dark. |
| **Partner logos** (PayPal…) | Custom SVGs in `assets/icons/partner/` | Third party's own artwork | **Never recolor, redraw or distort.** Follow the owner's brand rules. |

- Use **brand icons for brand-related meaning** and **Iconoir for utility actions**. Never swap one for the other.
- **Never draw, invent or approximate an icon.** If a brand icon is missing, stop and ask design.
- Iconoir icon names in Figma (`nav-arrow-down`, `xmark`, `check-circle-solid`…) map to `iconoir_flutter` classes in PascalCase (`NavArrowDown`, `Xmark`, `CheckCircleSolid`).

### 6.2 One wrapper for every icon

Screens and components **never** use `iconoir_flutter` or `SvgPicture` directly. They always use:

```dart
SampathIcon(SampathIcons.arrowRight, size: SampathIconSize.s24, color: SampathIconColor.secondary)
```

- `SampathIcons` is the single registry. Each entry maps a name to either an Iconoir widget or a brand or partner SVG asset.
- To replace a utility icon with a custom one later, change **one entry** in the registry. When no entry uses Iconoir any more, the package can be removed.
- `color` is ignored for brand icons and partner logos, which always render in their own colors.

### 6.3 Stroke width (accepted deviation)

In Figma, icons keep a fixed stroke: **1 px at 16 px** and **1.5 px at 20, 24, 36 and 48 px**. `iconoir_flutter` has no stroke setting and scales the stroke with the icon:

| Size | Figma | Code (`iconoir_flutter`) |
|---|---|---|
| 16 | 1 | 1 ✅ |
| 20 | 1.5 | 1.25 |
| 24 | 1.5 | 1.5 ✅ |
| 36 | 1.5 | 2.25 |
| 48 | 1.5 | 3 |

**Decision (9 Oct 2026): accepted.** We use the package as it is and accept this difference. Don't add workarounds.

### 6.4 Brand icon inventory

Figma file `ztpSPR24LsEQl2L4OxUX3T`, page **brand icon**. All are 24 × 24 components.

| Icon | Figma node | Code name | Asset | Note |
|---|---|---|---|---|
| `assistant` | `203:62` | `SampathIcons.assistant` | `assets/icons/brand/assistant.svg` | |
| `insights` | `203:64` | `SampathIcons.insights` | `assets/icons/brand/insights.svg` | |
| `transaction` | `203:63` | `SampathIcons.transaction` | `assets/icons/brand/transaction.svg` | |
| `transfer` | `203:61` | `SampathIcons.transfer` | `assets/icons/brand/transfer.svg` | |
| `NEW` | `204:100` | — | — | ⏳ **On hold.** It's text, not a pictogram (see §10) |
| `paypal` | `204:123` | `SampathIcons.paypal` | `assets/icons/partner/paypal.svg` | **Partner logo**, not a Sampath icon |

**Exported 12 Oct 2026** from the nodes above; the hidden guide frames are not in the files. To re-export: export SVGs from the Figma nodes above. Each icon contains a hidden guide frame (`Frame 3`, red keylines). Make sure it's **not** in the exported SVG, and check every file before committing.

---

## 7. Component architecture

### 7.1 Levels

Components are built **bottom-up**. A component may only be built after everything it depends on is done.

| Level | Meaning | Examples |
|---|---|---|
| **Atom (L0)** | Contains no other component | Icon, Divider, Badge – indicator, Switch |
| **Atom (L1)** | Contains only icons or an L0 atom | Base-button, Tag-base, Base-Checkbox, Square Icon |
| **Molecule** | Built from atoms | Pill-button, Badge-primary, Checkbox, Text Box |
| **Organism** | Built from molecules | Input fields, List, Header, Bottom sheet, Cards |
| **Asset** | Artwork, not a widget | Flags, payment icons, illustrations |

### 7.2 Base → mapped pattern (important)

Many components in Figma follow a **base → mapped** structure:

- A **base** component (for example `Base-button`, `Input field-base`) holds **every** option as boolean properties, text properties and slots.
- **Mapped** components (for example `Pill-button`, `Input field-standard`) are built from instances of the base, with some options fixed for a specific type, size or state.
- Changing the base updates every mapped component.

**Code must keep the same structure:**

1. Build the **base widget first**, with all options as parameters.
2. Build each **mapped widget** as a thin wrapper that only passes fixed values to the base. Mapped widgets must not copy the base's layout or styling.
3. A visual fix to a mapped component almost always belongs in the **base**.

| Base | Mapped components |
|---|---|
| `Base-button` | `Pill-button` → used by Button dock, Bottom sheet, Header, Notification, Snackbar, Empty state, OTP, Upload NIC, File uploads, sliding-button |
| `Input field-base` | `Input field-standard`, `Input field-password`, `Input field-select`, `Input field-Multi select`, `Search` → `Chat field` |
| `Input-OTP-base` | `OTP` |
| `Tag-base` | `Badge-primary` |
| `Chips-base` | `Chips`, `Chips-group` |
| `Base-Checkbox` | `Checkbox` |
| `Segmented_button-base` | `Segmented button` |
| `Base-Bottom-Nav_light` | `Search nav`, `Bottom nav - Light` |
| `Nav-button` | `Trailing icons` → `Header-base` → `Header-full` |
| `Quick action- base` | `Quick actions` |
| `List-base`, `List-base-filled` | `List-base/Notification-base`, Account details, credit or debit card |
| `Progress bar` | `Progress-progress bar` |
| `Spinner` | `Progress-Spinner` |
| `Indicator` | `Indicator set` |
| `Brand avatar` | `Avatar Group`, `Profile image`, `Brand logos` |
| `Accordion-frame-base`, `Accordion-bare-base` | (bases only; no mapped components yet) |

`Destructive-button` and `login-button` are **intentionally separate** from `Base-button`.

### 7.3 Figma properties → Flutter parameters

| Figma property | Flutter |
|---|---|
| **Variant** (Type, Size, Style…) | `enum` parameter, such as `SampathButtonType.primary` |
| **Variant for interaction state** (`State=Enabled/Pressed/Disabled`, `Focused`, `Typing`, `Complete`) | **Not a parameter.** It's runtime state: disabled when `onPressed == null`, pressed from the gesture, focus from `FocusNode`. Only data states (`Error`, `Selected`) become parameters. |
| **Boolean** (`Show Leading Icon`…) | `bool` parameter, or a nullable widget (for example `leadingIcon: null` hides it) |
| **Text** (`Button label`…) | `String` parameter |
| **Slot** (`Leading accessory`, `Body content`…) | `Widget?` parameter |
| **Instance swap** (icon) | `SampathIconData` parameter |

---

## 8. Component inventory and build status

**Build order:** top to bottom. Design says what to build next. Claude Code updates the **Status** column when a component is done.

Status: ⬜ Not started · 🟨 In progress · ✅ Done (built, Widgetbook story added, checked against Figma)

All node IDs are in the component file `Osc9AnJnbWQLesqVlhNsii`. Where a Figma name has a typo, the **code name** uses the corrected spelling, and the Figma name is kept here so it can still be found.

### 8.0 Setup: before any component

| # | Task | Output | Status |
|---|---|---|---|
| S1 | Flutter package scaffold | `packages/sampath_ds/` | ✅ |
| S2 | Token generator: `tokens/design.tokens.json` → Dart (handles the quirks in §3.8) | `lib/tokens/` (generated) | ✅ |
| S3 | Styles by hand from §4 (shadows, gradients). Motion (§5) is deferred. | `lib/tokens/styles.dart` | ✅ |
| S4 | Hanken Grotesk font files bundled (weights 400, 500, 600, 700, 800) | `assets/fonts/` | ✅ |
| S5 | Widgetbook app with a Light/Dark switch, plus a Foundations page (colors, type, spacing, radius, shadows) | `widgetbook/` | ✅ |

### 8.1 Atoms, level 0: contain no other components

| # | Figma component | Page | Node | Code name | Variants / properties | Status |
|---|---|---|---|---|---|---|
| 1 | `16px`, `20px`, `24px`, `36px`, `48px` | Icon sizes | `20:245`, `20:261`, `20:277`, `20:293`, `20:353` | `SampathIcon` | State: Primary/Secondary/Disabled/Success/Error/Info/Warning (**see §9.1**) | ✅ |
| 2 | `Divider` | Divider | `28:367` | `SampathDivider` | Type: Divider / Section Divider | ⬜ |
| 3 | `Divider dash` | Divider | `596:1256` | `SampathDividerDash` | — | ⬜ |
| 4 | `Badge - indicator` | Badge | `30:1500` | `SampathBadgeIndicator` | Size: Large/Small · Digits: None/Single/Double · Style: Red/Yellow/Green | ⬜ |
| 5 | `Online Indicator` | Avatar | `14:995` | `SampathOnlineIndicator` | Size: XSmall…XXXLarge (7) | ⬜ |
| 6 | `Indicator` | Indicator | `98:3532` | `SampathIndicator` | Type: Default/Selected | ⬜ |
| 7 | `Caption` | List | `77:10172` | `SampathCaption` | Size: Small/Medium/Large · Thickness: Heavy/Light | ⬜ |
| 8 | `Card` | Cards | `99:9108` | `SampathCard` | — (surface) | ⬜ |
| 9 | `Overlay` | Overlays | `111:2495` | `SampathOverlay` | Type: Mobile/Desktop/Loading | ⬜ |
| 10 | `Switch` | Toggle | `34:2545` | `SampathSwitch` | Type: Selected/Unselected · State (runtime) | ⬜ |
| 11 | `Base-Radio_box` | Radio button | `37:104` | `SampathRadio` | Type: Selected/Unselected · State (runtime) | ⬜ |
| 12 | `Progress bar` | Progress | `31:2113` | `SampathProgressBar` | Filled: 0–100% · Size: Large/Small · Steps: 4/5 | ⬜ |
| 13 | `Progress bar-portfolio` | Progress | `695:5418` | `SampathProgressBarPortfolio` | Filled: 0–100% | ⬜ |
| 14 | `dragger` | Progress | `645:3136` | `SampathDragger` | Filled: 5–100% | ⬜ |
| 15 | `Input-OTP-base` | Input field | `49:5843` | `SampathOtpCellBase` | State (runtime) · Show number · Error | ⬜ |

### 8.2 Atoms, level 1: contain only icons or L0 atoms

| # | Figma component | Page | Node | Code name | Depends on | Variants / properties | Status |
|---|---|---|---|---|---|---|---|
| 16 | `46px bg` | Icon sizes | `20:309` | `SampathIconBadge.medium` | `24px` | State (7) · octagon shape, 42 × 42 | ✅ |
| 17 | `68px bg` | Icon sizes | `20:369` | `SampathIconBadge.large` | `36px` | State (7) · octagon shape, 68 × 68 | ✅ |
| 18 | `Square Icon ` | Icon sizes | `71:4274` | `SampathSquareIcon` | `16/20/24/36px` | Size: XSmall/Small/Medium/Large · State: Brand/Success/Error/Warning/Info | ✅ |
| 19 | `Circle Icon` | Icon sizes | `624:4882` | `SampathCircleIcon` | `16px`, `24px` | Size: Small/Large | ✅ |
| 20 | `Base-Checkbox` | Checkbox | `42:185` | `SampathCheckboxBase` | `16px` | Type: Unselected/Selected/Indeterminate · State (runtime) | ⬜ |
| 21 | `Tag-base` | Badge | `30:1454` | `SampathTagBase` | `16px` | Size: Small/Large · Leading/Trailing icon · Label | ⬜ |
| 22 | `Label` | Text box | `28:968` | `SampathLabel` | Badge - indicator | Size: Medium/Small · Show badge · Label | ⬜ |
| 23 | `Helper text content` | Text box | `28:973` | `SampathHelperText` | `16px` | State: Default/Success/Error/Warning/Disabled · Show leading icon · Text | ⬜ |
| 24 | `Base-button` | Buttons | `45:405` | `SampathButtonBase` | `20px`, `24px` | Type: Primary/Secondary/Tertiary · Size: Large/Medium/Small/XSmall · State (runtime) · Leading/Trailing icon · Label · Text link | ⬜ |
| 25 | `Destructive-button` | Buttons | `523:2813` | `SampathDestructiveButton` | `20px`, `24px` | Type: Primary/Secondary · Size (4) · State (runtime) | ⬜ |
| 26 | `login-button` | Buttons | `349:5042` | `SampathLoginButton` | `20px`, `24px` | Size (4) · State (runtime) | ⬜ |
| 27 | `Chips-base` | Chips | `95:1811` | `SampathChipBase` | `16px` | Type: Unselected/Selected/Unselected-border · Size: XSmall/Small/Large · Leading slot · Trailing icon | ⬜ |
| 28 | `Segmented_button-base` | Segmented button | `117:4667` | `SampathSegmentBase` | `16px` | Type: Unselected/Selected · State (runtime) · Leading slot | ⬜ |
| 29 | `Brand avatar` | Avatar | `20:962` | `SampathBrandAvatar` | icon sizes | Type: Text/Image/Icon · Size: XSmall…XXXLarge (7) | ⬜ |
| 30 | `Avatar` | Avatar | `932:1387` | `SampathAvatar` | icon sizes | Type: Image/Icon/Text · Size (7) | ⬜ |
| 31 | `Nav-button` | Header | `91:816` | `SampathNavButton` | `24px`, Badge - indicator | State (runtime) · Show badge | ⬜ |
| 32 | `Spinner` | Progress | `33:2331` | `SampathSpinner` | `48px` | Progress: 25/50/75%, Complete, Error | ⬜ |

### 8.3 Molecules

| # | Figma component | Page | Node | Code name | Built on / depends on | Status |
|---|---|---|---|---|---|---|
| 33 | `Pill-button` | Buttons | `47:1580` | `SampathButton` | **Base-button** · Type (3) · Size (4) · Icon: None/Leading/Trailing/Only Icon | ⬜ |
| 34 | `Badge-primary` | Badge | `30:1465` | `SampathBadge` | **Tag-base** · State: Primary/Secondary/Success/Error/Info/Warning/Disabled/Brand/Neutral/Gold | ⬜ |
| 35 | `Checkbox` | Checkbox | `42:220` | `SampathCheckbox` | **Base-Checkbox**, Text Box | ⬜ |
| 36 | `Chips` | Chips | `95:1848` | `SampathChip` | **Chips-base** | ⬜ |
| 37 | `Chips-group` | Chips | `922:6646` | `SampathChipGroup` | **Chips-base** | ⬜ |
| 38 | `Segmented button` | Segmented button | `117:4688` | `SampathSegmentedButton` | **Segmented_button-base** | ⬜ |
| 39 | `Text Box` | Text box | `28:1001` | `SampathTextBox` | Label · Type: H1–H6 · Alignment: Left/Center/Right | ⬜ |
| 40 | `Indicator set` | Indicator | `98:3541` | `SampathPageIndicator` | **Indicator** | ⬜ |
| 41 | `Progress-progress bar` | Progress | `31:2122` | `SampathProgress` | **Progress bar**, Text Box | ⬜ |
| 42 | `Progress-Spinner` | Progress | `33:2348` | `SampathProgressSpinner` | **Spinner**, Text Box | ⬜ |
| 43 | `Avatar Group` | Avatar | `14:1155` | `SampathAvatarGroup` | **Brand avatar** | ⬜ |
| 44 | `Profile image` | Avatar | `432:1610` | `SampathProfileImage` | **Brand avatar**, icons | ⬜ |
| 45 | `Quick action- base` | Buttons | `366:7429` | `SampathQuickActionBase` | Circle Icon, Label | ⬜ |
| 46 | `Contry selecter` | Input field | `49:5731` | `SampathCountrySelector` | Flag sizes, `24px` | ⬜ |
| 47 | `Base-Bottom-Nav_light` | Bottom nav | `396:3427` | `SampathBottomNavItem` | `20px`, Badge - indicator | ⬜ |
| 48 | `Trailing icons` | Header | `91:843` | `SampathHeaderActions` | **Nav-button** | ⬜ |
| 49 | `Plain Tooltip` | Tooltips | `476:752` | `SampathTooltip` | Text Box · Type: Single line/Rich · Look: Black/Basic | ⬜ |
| 50 | `dotted line` | Buttons | `784:4588` | `SampathDottedLine` | `24px` | ⬜ |

### 8.4 Organisms

| # | Figma component | Page | Node | Code name | Built on / depends on | Status |
|---|---|---|---|---|---|---|
| 51 | `Input field-base` | Input field | `49:5734` | `SampathInputBase` | **Base.** Label, Helper text, Country selector, Divider, icons · many slots | ⬜ |
| 52 | `Input field-standard` | Input field | `52:2629` | `SampathTextField` | **Input field-base** · Type: Default/Mobile number/Payment · Error | ⬜ |
| 53 | `Input field-password` | Input field | `60:7165` | `SampathPasswordField` | **Input field-base** · Show password · Error | ⬜ |
| 54 | `Input field-select` | Input field | `537:2736` | `SampathSelectField` | **Input field-base** | ⬜ |
| 55 | `Input field-Multi select` | Input field | `922:6170` | `SampathMultiSelectField` | **Input field-base**, Chips-group | ⬜ |
| 56 | `OTP` | Input field | `63:10165` | `SampathOtpField` | **Input-OTP-base**, Helper text, Pill-button, Text Box | ⬜ |
| 57 | `Search` | Search | `440:5164` | `SampathSearchField` | **Input field-base** · Sticky | ⬜ |
| 58 | `Chat field` | Search | `620:4504` | `SampathChatField` | **Search**, Pill-button · Size: Large/Small | ⬜ |
| 59 | `Upload NIC` | Input field | `125:2688` | `SampathUploadNic` | Square Icon, Text Box, Pill-button | ⬜ |
| 60 | `File uploads` | Input field | `775:4280` | `SampathFileUpload` | Square Icon, Text Box, Pill-button | ⬜ |
| 61 | `List-base` | List | `77:10185` | `SampathListItem` | **Base.** Square Icon, Label, Text Box, Divider · slots | ⬜ |
| 62 | `List-base-filled` | List | `76:11426` | `SampathListItemFilled` | **Base.** Square Icon, Label, Text Box · slots | ⬜ |
| 63 | `List-base/Notification-base` | List | `522:1434` | `SampathNotificationItem` | List base, Caption, Badge - indicator, Pill-button | ⬜ |
| 64 | `Accordion-frame-base` | Accordion | `555:1767` | `SampathAccordionFramed` | **Base.** Text Box, Badge-primary, Label · slots | ⬜ |
| 65 | `Accordion-bare-base` | Accordion | `555:1968` | `SampathAccordion` | **Base.** Text Box, Badge-primary, Label, Divider · slots | ⬜ |
| 66 | `Notification` | Notification banners | `77:10612` | `SampathNotificationBanner` | Pill-button, icons · Type: Info/Success/Error/Warning/Neutral/Priority | ⬜ |
| 67 | `Snackbar` | Snackbar | `268:992` | `SampathSnackbar` | Text Box, Pill-button · State: Neutral/Success/Warning/Error · single/two lines | ⬜ |
| 68 | `Snackbar-special` | Snackbar | `624:4881` | `SampathSnackbarSpecial` | Circle Icon, Label, Text Box, Pill-button · Leading slot | ⬜ |
| 69 | `Quick actions` | Buttons | `423:2600` | `SampathQuickActions` | **Quick action- base** · Type: Home/More | ⬜ |
| 70 | `sliding-button` | Buttons | `683:4826` | `SampathSlideButton` | Pill-button · State: Enabled/Slided/Disabled | ⬜ |
| 71 | `Button dock` | Button dock | `75:5858` | `SampathButtonDock` | Text Box, Pill-button · Type: Bottom sheet/Bottom/Keyboard · Accessory slot | ⬜ |
| 72 | `Button dock/Button dock-pdf` | Button dock | `598:2812` | `SampathButtonDockPdf` | login-button | ⬜ |
| 73 | `Bottom sheet` | Bottom sheet | `75:6406` | `SampathBottomSheet` | Square Icon, Text Box, Pill-button, Button dock · slots | ⬜ |
| 74 | `Empty state` | Empty state | `71:4588` | `SampathEmptyState` | Text Box, Pill-button, Square Icon · Size: Small/Medium/Large · Icon slot | ⬜ |
| 75 | `Header-base` | Header | `91:847` | `SampathHeaderBase` | **Base.** Pill-button, Trailing icons, Brand avatar · Type: Text/Logo/Home | ⬜ |
| 76 | `Header-full` | Header | `95:2979` | `SampathHeader` | **Header-base**, Chips-base, Notification · 7 types | ⬜ |
| 77 | `Search nav` | Bottom nav | `404:4186` | `SampathBottomNavSearch` | **Base-Bottom-Nav_light** | ⬜ |
| 78 | `Bottom nav - Light` | Bottom nav | `396:3456` | `SampathBottomNav` | **Base-Bottom-Nav_light**, Search nav, Search | ⬜ |
| 79 | `Balance card` | Cards | `362:6829` | `SampathBalanceCard` | Text Box, Caption, Badge - indicator, Label | ⬜ |
| 80 | `Account details` | Cards | `737:4026` | `SampathAccountDetailsCard` | List-base, Badge-primary, Progress bar, login-button… | ⬜ |
| 81 | `Account view` | Cards | `737:4027` | `SampathAccountViewCard` | Square Icon, Text Box, Label, Divider, Caption | ⬜ |
| 82 | `card-gold` | Cards | `703:10129` | `SampathGoldCard` | 46px bg, Progress bar, Helper text… | ⬜ |
| 83 | `credit or debit card` | Cards | `751:3607` | `SampathPaymentCardDetails` | List-base, Payment icons, Badge-primary… · List group slot | ⬜ |
| 84 | `Card scan` | Icon types | `119:4957` | `SampathCardScan` | 68px bg, `36px` | ⬜ |
| 85 | `Face scan` | Icon types | `115:2927` | `SampathFaceScan` | Caption, `48px` | ⬜ |
| 86 | `QR frame` | Icon types | `872:1115` | `SampathQrFrame` | Badge-primary, Pill-button, 68px bg | ⬜ |

### 8.5 Assets (exported, not built as widgets)

| Figma component | Page | Node | Export to |
|---|---|---|---|
| `Flag icons` (circle + rectangle) | Icon types | `49:6026` | `assets/flags/` |
| `Flag sizes` | Icon types | `49:13408` | (size rules for flags) |
| `Payment Icons` | Icon types | `58:14556` | `assets/payment/` |
| `Brand logos` (LECO, SLTMobitel, Dialog, CEB, Water board, GovPay) | Icon types | `1189:1054` | `assets/logos/` |
| `Large illustrations`, `Medium illustrations`, `Small illustrations`, `XSmall Illustrations`, `Special`, `Small illustrations/Loading` | Icon types | `786:5880`, `789:5923`, `790:6159`, `866:768`, `842:966`, `727:1123` | `assets/illustrations/` |
| `debit cards` (card artwork) | Cards | `449:6071` | `assets/cards/` |
| ~~`Illustrations-don't use`~~, ~~`Small illustrations-don't use`~~ | Icon types | — | **Do not use** |
| `Status bars - iOS…` | Header | `91:838` | **Not built.** The OS draws the status bar. |

---

## 9. Component specs

Each component gets a full spec here **when it's built**. Exact measurements (padding, gaps, sizes) come from Figma at build time. Read the component node with the Figma tools rather than guessing.

### 9.1 Icon (Icon sizes): first to build

**Figma:** page **Icon sizes**. Component sets `16px` (`20:245`), `20px` (`20:261`), `24px` (`20:277`), `36px` (`20:293`), `48px` (`20:353`). The placeholder icon inside every set is Iconoir `lock`; in use it gets swapped for the needed icon.

**Sizes**

| Figma set | `SampathIconSize` | Box | Figma stroke | Typical use |
|---|---|---|---|---|
| `16px` | `s16` | 16 × 16 | 1 | Tags, chips, helper text, checkbox tick |
| `20px` | `s20` | 20 × 20 | 1.5 | Buttons (small), list, bottom nav |
| `24px` | `s24` | 24 × 24 | 1.5 | **Default.** Buttons, header, inputs |
| `36px` | `s36` | 36 × 36 | 1.5 | Large square icons, bottom sheet |
| `48px` | `s48` | 48 × 48 | 1.5 | Spinner, face scan |

Only these five sizes exist. **No other icon sizes are allowed.** Stroke in code follows §6.3.

**Color (the `State` variant)**

| Figma `State` | `SampathIconColor` | Token |
|---|---|---|
| Primary | `primary` | `fg-primary` |
| Secondary | `secondary` | `fg-secondary` |
| Disabled | `disabled` | `fg-disabled` |
| Success | `success` | `fg-success` |
| Error | `error` | `fg-error` |
| Info | `info` | `fg-info` |
| Warning | `warning` | `fg-warning` |

Components may also pass any other `fg-*` token when their Figma spec uses one (for example `fg-brand`, `fg-inverse`, `fg-action`).

**API**

```dart
SampathIcon(
  SampathIcons.lock,                 // SampathIconData from the registry (§6.2)
  size: SampathIconSize.s24,         // default s24
  color: SampathIconColor.primary,   // default primary; ignored for brand/partner icons
  semanticLabel: 'Locked',           // required when the icon carries meaning on its own
)
```

**Widgetbook:** one use case per size, with an Icon type knob (Utility / Brand & partner) that filters the Icon knob (A–Z), and a Color knob for utility icons only. Plus a grid of all sizes × colors (utility icons only) and the registry, in Light and Dark.

**Built (12 Oct 2026).** `lib/icons/`: `SampathIcon`, `SampathIconSize`, `SampathIconColor`, `SampathIconData`, `SampathIcons`.

- **Checked against Figma:** five sets, sizes 16/20/24/36/48, strokes 1 / 1.5, seven `State` variants bound to the `fg-*` tokens above. Matches this spec.
- **Sizes** are a closed enum. They're component sizes, not spacing, so they aren't taken from `SampathSpacing` (36 has no token).
- **Color:** `SampathIconColor` has the seven Figma states plus every other `fg-*` token, so component specs can use `fg-brand`, `fg-inverse`, `fg-action` etc. without raw colors. Ignored for brand and partner icons.
- **Semantics:** with `semanticLabel` the icon is an image with that label; without it, it's decorative and hidden from screen readers.
- **Dependencies:** `iconoir_flutter` 7.12.1 (pinned) and `flutter_svg` for brand and partner SVGs.

**Registry contents.** Only icons the component file uses (scan of all component pages, excluding 🔒 Do not use, 12 Oct 2026). Code names are the Figma names in camelCase.

| Kind | Icons |
|---|---|
| Utility (Iconoir), 48 | `arrow-down-left`, `arrow-up`, `arrow-up-right`, `bell`, `calendar`, `camera`, `card-no-access`, `chat-bubble`, `check`, `check-circle`, `check-circle-solid`, `clock`, `clock-rotate-right`, `coins`, `credit-card`, `data-transfer-both`, `download`, `edit-pencil`, `eye`, `eye-closed`, `fast-arrow-right`, `globe`, `graph-up`, `headset-help`, `home-simple`, `info-circle`, `lock`, `microphone`, `minus`, `more-horiz`, `nav-arrow-down`, `nav-arrow-left`, `nav-arrow-right`, `nav-arrow-up`, `plus`, `refresh-double`, `scan-qr-code`, `search`, `settings`, `share-android`, `star`, `trash`, `upload`, `user`, `wallet`, `warning-triangle`, `xmark`, `xmark-solid` |
| Renamed in Iconoir | `xmark-solid` is drawn with `XmarkCircleSolid` (current Iconoir name for the same icon). See §10 #17. |
| Brand, 4 | `assistant`, `insights`, `transaction`, `transfer` |
| Partner, 1 | `paypal` |

**Icon containers (L1, built right after):**

| Figma | Box | Shape | Icon inside | Background / icon color by state |
|---|---|---|---|---|
| `46px bg` | 42 × 42 | Rounded **octagon** (brand shape) | `24px`, centered | Primary: `bg-icons` / `fg-brand` · Secondary: `bg-icons` / `fg-secondary` · Disabled: `bg-disabled` / `fg-disabled-on_bg` · Positive, Error, Info, Warning: `fg-success`, `fg-error`, `fg-info`, `fg-warning` background / `fg-inverse` icon |
| `68px bg` | 68 × 68 | Rounded **octagon** | `36px`, centered | Same mapping as `46px bg` (its green state is called `Success`) |
| `Square Icon` | 64 / 50 / 42 / 24 | Rounded square, radius `Radius-L` (Large) · `Radius-M` (Medium, Small) · `Radius-S` (XSmall) | 36 / 24 / 20 / 16 px | Brand: `bg-icons` / `fg-brand` · Success: `bg-success` / `fg-success` · Error: `bg-error` / `fg-error` · Warning: `bg-warning` / `fg-warning` · Info: `bg-info` / `fg-info` |
| `Circle Icon` | 36 / 56 | Circle (`Radius-Full`), no shadow (§10 #19) | 16 / 24 px | `bg-secondary` / `fg-brand` |

The **octagon** must be the exact Figma path. Export the mask vector from `46px bg` and draw it as a custom `ShapeBorder` or clip path. Don't approximate it with a rounded rectangle.

**Containers built (12 Oct 2026).** `lib/components/icon_containers/`.

```dart
SampathIconBadge.medium(SampathIcons.wallet, state: SampathIconBadgeState.success) // 46px bg
SampathIconBadge.large(SampathIcons.assistant)                                      // 68px bg
SampathSquareIcon(SampathIcons.checkCircle,
    size: SampathSquareIconSize.medium, state: SampathSquareIconState.success)
SampathCircleIcon(SampathIcons.camera, size: SampathCircleIconSize.small)
```

- **Checked against Figma:** sizes, radius tokens, icon sizes, and background / icon color for every state match the table above. Icons are centered (§10 #20).
- **Octagon:** `SampathOctagonBorder`, the `46px bg` mask vector (`20:313`) normalised to a unit square. The `68px bg` mask is the same shape scaled; a test checks the code path against the Figma 68 px path point by point. The whole octagon is filled (§10 #21).
- **State names:** `SampathIconBadgeState` is `primary`, `secondary`, `disabled`, `success`, `error`, `info`, `warning`. `success` is `46px bg`'s `Positive` (§10 #8).
- **Icon:** any registry icon, including brand icons and partner logos (they keep their own colors). `semanticLabel` passes through to the icon.
- **Box sizes** (42, 68, 24/42/50/64, 36/56) are component sizes in the size enums, like `SampathIconSize`.
- **Widgetbook:** Components → Icon Badge, Square Icon, Circle Icon. Each has a Default page with Icon type, Icon, Size and State knobs (Circle has no State) and a grid of every variant, in Light and Dark.

---

## 10. Known issues and open decisions

| # | Item | Where | Status |
|---|---|---|---|
| 1 | Token `Primary-900` in the `Primary1` group should be `Primary1-900` (the other nine are renamed). Used by `bg-active` (Dark) and `bg-icons` (Dark). | Foundation › Alias Colors | ✅ Fixed (12 Oct 2026) |
| 2 | `Vermilion` gradient uses off-brand `#f26722 → #dc5e1f` | Foundation › color styles | ⏳ Design to update later |
| 3 | Gradient stops aren't linked to variables | Foundation › color styles | ⏳ Later |
| 4 | Text style names (`Body/Large`) differ from variable groups (`Body L`). Mapped in §3.4. | Foundation | ⏳ Later |
| 5 | Missing descriptions: `Alpha-md`, `Alpha-nav_background`, `Alpha-shade`, `Alpha-success`, `Alpha-brand`, `Alpha-error`, `card-gap_small/medium/large` | Foundation | ⏳ Later |
| 6 | Brand icon `NEW` is text, not a pictogram. Proposal: make it a Badge. | Brand icons | ❓ Decide |
| 7 | Icon stroke in code scales with size (§6.3) | Code | ✅ Accepted |
| 8 | `46px bg` is actually 42 × 42, and its green state is `Positive` while everything else uses `Success` | Icon sizes | 🔧 Fix in Figma |
| 9 | `Square Icon ` has a trailing space | Icon sizes | 🔧 Fix in Figma |
| 10 | Typos: `Contry selecter`, Spinner `Pregress`, `Fillted` (Progress bar-portfolio), `SIze`/`Mediu` (Flag sizes), `Enbled` (Face scan), `Acccounts` (XSmall illustrations) | Components | 🔧 Fix in Figma. Code already uses the correct spelling. |
| 11 | `Snackbar` has a variant property with no name (`=Single/Two lines`) | Snackbar | 🔧 Fix in Figma |
| 12 | Inconsistent naming: `Xsmall` vs `XSmall`; Badge-primary `brand` (lowercase); Input field-select `state` and Chat field `States` property names | Components | 🔧 Fix in Figma |
| 13 | `Empty state` uses `Small illustrations-don't use` | Empty state | 🔧 Fix in Figma |
| 14 | The octagon mask vector in `46px bg` and `68px bg` has a fill linked to a leftover `html.to.design` variable. Harmless (it's a mask), but it's an external dependency. | Icon sizes | 🧹 Optional cleanup |
| 15 | Motion: plan is to adopt Material 3 easing and duration pairs (see §5) | §5 | ⏳ Deferred. Revisit later. |
| 16 | Sinhala wraps tightly (1.5–1.8 px between lines) in Display/Large-H1, Display/Medium-H2, Title/XLarge and Button/XLarge, and small Sinhala (10–12 px) is hard to read. Accepted for now. Revisit if it shows up in real screens. | Typography (§3.4) | ⏳ |
| 17 | Iconoir `xmark-solid` (used in Input field, Notification banners, Search) doesn't exist in `iconoir_flutter` 7.12.1. The closest is `XmarkCircleSolid` (same filled circle with an X; Figma's version is drawn as fill + 1 px stroke, so the X ends differ slightly). **Resolved:** it's the same icon, renamed `xmark-circle-solid` in newer Iconoir. `SampathIcons.xmarkSolid` uses `XmarkCircleSolid`. | Icons | ✅ Resolved (12 Oct 2026) |
| 18 | Figma uses an older Iconoir library, so some icon names and drawings differ slightly from `iconoir_flutter` 7.12.1. Design may switch Figma to the current Iconoir library later. Code needs no change. (Note for design only.) | Icons | ⏳ |
| 19 | `Circle Icon` (both sizes) uses effect style `Shadow/Resting_cards`. Decision: no shadow; code has none. | Icon sizes | 🔧 Fix in Figma (remove the shadow) |
| 20 | `Square Icon` Large: the `36px` icon sits at y 13.6 instead of 14 (0.4 px above center). Code centers it. | Icon sizes | 🔧 Fix in Figma |
| 21 | `46px bg` and `68px bg`: the `Background` frame is shifted 0.29 px left of the mask, leaving a 0.29 px unfilled sliver on the right edge. Code fills the whole octagon. | Icon sizes | 🔧 Fix in Figma |

---

## 11. Changelog

| Date | Version | Change |
|---|---|---|
| 9 Oct 2026 | 0.1 | First draft: foundations, styles, icons, architecture, full component inventory, Icon sizes spec |
| 12 Oct 2026 | 0.2 | Tokens re-exported: `header-to-content` 24 → 16, `section-gap` 32 → 24, new `section-gap_large` (32, not used yet). Added mobile spacing rules and the slot rule to Core rules. Motion deferred, with Material 3 motion as the planned direction. |
| 12 Oct 2026 | 0.2 | Setup S1 (package scaffold), S2 (token generator `tool/generate_tokens.dart` → 6 files in `lib/tokens/`) and S4 (Hanken Grotesk 400–800 static TTFs from Google Fonts, OFL) done. |
| 12 Oct 2026 | 0.2 | Tokens re-exported: alias `Primary-900` renamed to `Primary1-900` (§10 #1 fixed). No value changes. |
| 12 Oct 2026 | 0.2 | S3: `styles.dart` (shadows incl. `Shadow/Back` inner shadow painter, background blur, gradients with Figma transforms; values re-read from Figma and match §4). S5: Widgetbook app with Light/Dark theme switch and a Foundations folder (Colors, Typography, Spacing, Radius, Layout, Shadows, Gradients). |
| 12 Oct 2026 | 0.2 | Noto Sans Sinhala and Noto Sans Tamil (400–800) bundled and set as `fontFamilyFallback` on every text style (§3.4). Typography page gets English / Sinhala / Tamil samples. |
| 12 Oct 2026 | 0.2 | §9.1 Icon built: `SampathIcon` (5 sizes, 7 states + other fg-*), `SampathIcons` registry (47 Iconoir icons used in Figma, 4 brand, 1 partner), brand/partner SVGs exported from Figma, Widgetbook Icon pages. `xmark-solid` pending (§10 #17). |
| 12 Oct 2026 | 0.2 | §10 #17 resolved: `xmark-solid` added to the registry as `XmarkCircleSolid` (48 Iconoir icons). New §10 #18: Figma uses an older Iconoir library (note for design). Widgetbook Icon pages get an Icon type knob. |
| 12 Oct 2026 | 0.2 | §8.2 #16–19 icon containers built: `SampathIconBadge` (`46px bg`, `68px bg`, exact Figma octagon), `SampathSquareIcon`, `SampathCircleIcon` (no shadow), with Widgetbook pages. New §10 #19–21 (Figma fixes). |
