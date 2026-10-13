# CLAUDE.md — Sampath Bank Design System

Instructions for Claude Code in this repo. Read them fully at the start of every session.

**What this repo is:** the Sampath Bank mobile design system, built as a Flutter package (`sampath_ds`) with a Widgetbook catalogue, taken from Figma. The owner is the designer (Sathila), who decides what gets built and when.

**[`DESIGN.md`](./DESIGN.md) is the spec.** It defines the tokens, styles, icons and components, and their build status. This file only says *how to work*.

---

## Before any task

1. **Read `DESIGN.md`**, at least §2 (Core rules), §7 (Component architecture) and the section for the component you're working on.
2. Check the component's row in **§8 (inventory)**: its Figma node, what it depends on, and its status.
3. If anything it depends on isn't ✅ Done, **stop and tell the designer**. Don't build dependencies on your own.

## How to build a component

**Build only what the designer asks for, one component at a time.** Don't build ahead.

1. **Read the component in Figma** with the Figma tools, using the node ID from `DESIGN.md` §8. Get the exact layout, padding, gaps, sizes, radius and which token each value uses. Take a screenshot to compare against. **Never guess a measurement.**
2. **If something can't be expressed with existing tokens**, stop and ask. Don't add new values.
3. **Base → mapped:** if the component has a base (§7.2), build or extend the base first. Mapped widgets are thin wrappers that pass fixed values to the base and never copy its layout.
4. **Map Figma properties as in §7.3.** Interaction states (Enabled/Pressed/Disabled/Focused/Typing) are runtime state, not parameters.
5. **Add a Widgetbook use case** for every variant, with knobs for its main properties. Show it in **Light and Dark**. Every Default use case shows a live code box (widgetbook/lib/shared/code_snippet.dart) with the code for the current knob values. To view Widgetbook, run tool/serve_widgetbook.sh and rebuild after every change (no hot reload).
6. **Compare with Figma:** check your Widgetbook result against the Figma screenshot, variant by variant. Fix any differences before saying it's done.
7. **Write a short component spec** in `DESIGN.md` §9 (API, variants, tokens used, any decisions).
8. **Update the Status** in `DESIGN.md` §8 to ✅, and add a line to §11 Changelog.
9. **Summarize for the designer:** what was built, anything that didn't match Figma, and any questions.

## Hard rules

- **No hardcoded values.** No hex colors, raw numbers for spacing, radius or font size, or inline `TextStyle`s in components. Use the generated tokens (`DESIGN.md` §3.8). The only exception is artwork inside brand icons, logos and illustrations.
- **Components use semantic colors only** (`context.colors.*`). Never `SampathPalette.*` and never `Colors.*` from Material.
- **Never edit generated token files.** Change `tokens/design.tokens.json` (re-exported from Figma) and rerun the generator.
- **Icons:**
  - Always go through `SampathIcon` and the `SampathIcons` registry (`DESIGN.md` §6.2). Never use `iconoir_flutter` or `SvgPicture` directly in a component.
  - Utility icons come from Iconoir, with `iconoir_flutter` pinned to `7.12.1`. Brand icons and partner logos are SVGs in `assets/icons/`.
  - **Never draw, invent or substitute an icon.** If a brand icon is missing, stop and ask.
  - Never recolor brand icons or partner logos.
  - Only the five sizes 16/20/24/36/48 are allowed.
- **Touch targets** are at least 44 × 44. Icon-only controls need a `semanticLabel`.
- **Respect Reduce motion** (`MediaQuery.disableAnimationsOf`).
- **Names:** code names follow `DESIGN.md` §8. Where a Figma name has a typo, use the corrected spelling in code and leave the Figma name as it is in `DESIGN.md`.
- **Figma is read-only.** Never create, edit, rename or delete anything in the Figma files. Only read and screenshot. If something in Figma needs changing, tell the designer.
- **Out of scope:** pages under "🔒 Do not use" in the component file, and the "Icon library" page in the iconography file.

## When to stop and ask

Stop and ask the designer, rather than deciding yourself, when:
- Figma and `DESIGN.md` disagree. Figma wins, but tell the designer so `DESIGN.md` gets updated.
- A value, color or icon isn't covered by a token or the icon registry.
- A component needs something the design doesn't show (a missing state, a dark-mode color, behavior).
- Something is listed in `DESIGN.md` §10 (Known issues) as ❓ Decide.

## Repo layout

```
tokens/design.tokens.json          ← Figma variables (TokensBruecke export). Source of truth for values.
tool/generate_tokens.dart          ← JSON → Dart token generator
packages/sampath_ds/
  lib/tokens/                      ← GENERATED (colors, spacing, radius, typography) + styles.dart (hand-written, from DESIGN.md §4)
  lib/icons/                       ← SampathIcon, SampathIcons registry
  lib/components/<component>/      ← one folder per component (base + mapped widgets)
  assets/icons/brand/              ← brand icon SVGs
  assets/icons/partner/            ← partner logo SVGs
  assets/fonts/                    ← Hanken Grotesk
widgetbook/                        ← Widgetbook app (one use case per component variant)
DESIGN.md                          ← the spec
CLAUDE.md                          ← this file
```

Create folders as you need them. Don't add folders or packages outside this layout without asking.

## Git

- `main` always builds and its Widgetbook runs.
- Use one short-lived branch per component (`feat/<component>`), and merge back when it's done and checked.
- Write commit messages in the present tense, naming the component (for example `Add SampathIcon and icon registry`).

## Figma files

| File | Key |
|---|---|
| Foundation | `Z4B0Qjw4IfoGY5UHmgpbnp` |
| Components | `Osc9AnJnbWQLesqVlhNsii` |
| Brand icons (page "brand icon", node `151:10`) | `ztpSPR24LsEQl2L4OxUX3T` |
