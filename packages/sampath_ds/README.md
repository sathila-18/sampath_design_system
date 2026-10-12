# sampath_ds

Sampath Bank mobile design system as a Flutter package. The spec is
[`DESIGN.md`](../../DESIGN.md) at the repo root.

Token files in `lib/tokens/` are generated. Don't edit them. Re-export
`tokens/design.tokens.json` from Figma and run, from the repo root:

```sh
dart tool/generate_tokens.dart
```
