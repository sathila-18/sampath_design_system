// Generates the Dart token files in packages/sampath_ds/lib/tokens/ from
// tokens/design.tokens.json (TokensBruecke export, DTCG 2025.10, hex colors).
//
// Run from the repo root:
//   dart tool/generate_tokens.dart
//
// Handles the export quirks listed in DESIGN.md §3.8:
//   - Font weights exported as dimensions ({value: 800, unit: px}) → FontWeight.
//   - Line heights exported in px → Flutter height ratio (lineHeight / fontSize).
//   - Alpha colors exported as {components: "{ref}", alpha: n} → resolved + alpha.
//   - Aliases ({Collection.Group.Token}) resolved per mode (Light / Dark).
//
// The script fails loudly on anything it doesn't understand (unknown $type,
// unresolved alias, unexpected unit, duplicate Dart name) rather than guessing.

import 'dart:convert';
import 'dart:io';

const _inputPath = 'tokens/design.tokens.json';
const _outputDir = 'packages/sampath_ds/lib/tokens';
const _modes = ['Light', 'Dark'];

const _header = '''
// GENERATED CODE — DO NOT EDIT BY HAND.
// Source: tokens/design.tokens.json · Generator: tool/generate_tokens.dart
// To change a value, re-export the tokens from Figma and rerun the generator.
''';

late final Map<String, dynamic> _root;

void main() {
  final file = File(_inputPath);
  if (!file.existsSync()) {
    _fail('$_inputPath not found. Run this script from the repo root.');
  }
  _root = jsonDecode(file.readAsStringSync()) as Map<String, dynamic>;

  final outputs = <String, String>{
    'sampath_palette.dart': _palette(),
    'sampath_colors.dart': _semanticColors(),
    'sampath_spacing.dart': _spacing(),
    'sampath_radius.dart': _radius(),
    'sampath_layout.dart': _layout(),
    'sampath_typography.dart': _typography(),
  };

  Directory(_outputDir).createSync(recursive: true);
  for (final entry in outputs.entries) {
    File('$_outputDir/${entry.key}').writeAsStringSync(entry.value);
    stdout.writeln('wrote $_outputDir/${entry.key}');
  }

  final format = Process.runSync('dart', [
    'format',
    ...outputs.keys.map((name) => '$_outputDir/$name'),
  ]);
  if (format.exitCode != 0) _fail('dart format failed:\n${format.stderr}');
}

// ---------------------------------------------------------------------------
// Token tree access and alias resolution
// ---------------------------------------------------------------------------

bool _isToken(Object? node) => node is Map && node.containsKey(r'$value');

Map<String, dynamic> _group(List<String> path) {
  Object? node = _root;
  for (final key in path) {
    if (node is! Map || !node.containsKey(key)) {
      _fail('Group not found: ${path.join(' › ')}');
    }
    node = node[key];
  }
  return node as Map<String, dynamic>;
}

/// Tokens directly inside [group], in file order (skips `$` metadata keys).
Iterable<MapEntry<String, Map<String, dynamic>>> _tokensIn(
  Map<String, dynamic> group,
) sync* {
  for (final entry in group.entries) {
    if (entry.key.startsWith(r'$')) continue;
    if (!_isToken(entry.value)) {
      _fail('Expected a token at "${entry.key}", found a group.');
    }
    yield MapEntry(entry.key, entry.value as Map<String, dynamic>);
  }
}

/// Finds the token an alias like `{Alias Colors.Colors.Primary1.Primary1-50}`
/// points to. Names may contain spaces, so path segments are matched greedily
/// against the keys that actually exist (a key could contain a `.` too).
Map<String, dynamic> _lookup(String ref) {
  final parts = ref.substring(1, ref.length - 1).split('.');
  Object? node = _root;
  var i = 0;
  while (i < parts.length) {
    if (node is! Map) _fail('Alias $ref walks past a token.');
    final map = node;
    var matched = false;
    for (var j = parts.length; j > i; j--) {
      final key = parts.sublist(i, j).join('.');
      if (map.containsKey(key)) {
        node = map[key];
        i = j;
        matched = true;
        break;
      }
    }
    if (!matched) _fail('Unresolved alias: $ref');
  }
  if (!_isToken(node)) _fail('Alias $ref points at a group, not a token.');
  return node as Map<String, dynamic>;
}

bool _isAlias(Object? value) =>
    value is String && value.startsWith('{') && value.endsWith('}');

/// The raw value of [token] for [mode], falling back to `$value` when the
/// token has no per-mode values (single-mode collections).
Object? _rawValue(Map<String, dynamic> token, String? mode) {
  final modes = (token[r'$extensions'] as Map?)?['mode'] as Map?;
  if (mode != null && modes != null && modes.containsKey(mode)) {
    return modes[mode];
  }
  return token[r'$value'];
}

/// Follows aliases until a concrete value is reached, staying in [mode] at
/// every hop so Light/Dark chains resolve independently.
Object? _resolve(Object? value, String? mode, {int depth = 0}) {
  if (depth > 20) _fail('Alias chain too deep (cycle?) at $value');
  if (_isAlias(value)) {
    return _resolve(
      _rawValue(_lookup(value as String), mode),
      mode,
      depth: depth + 1,
    );
  }
  return value;
}

/// The name of the token an alias points at, e.g. `Primary1-50`.
String _aliasName(Object? value) {
  if (!_isAlias(value)) return '';
  final ref = value as String;
  final token = ref.substring(1, ref.length - 1);
  // Last path segment that exists as a key. Token names here never contain
  // dots, so the final segment is the name.
  return token.split('.').last;
}

// ---------------------------------------------------------------------------
// Value conversion
// ---------------------------------------------------------------------------

/// Resolves a color token for [mode] to 0xAARRGGBB.
/// Accepts `#rrggbb`, `#rrggbbaa` and the alpha quirk
/// `{components: "{ref}", alpha: 0.16}`.
int _color(Map<String, dynamic> token, String? mode, String name) {
  if (token[r'$type'] != 'color') _fail('$name is not a color token.');
  return _colorValue(_resolve(_rawValue(token, mode), mode), mode, name);
}

int _colorValue(Object? value, String? mode, String name) {
  if (value is String) return _hex(value, name);
  if (value is Map && value.containsKey('components')) {
    final alpha = value['alpha'];
    if (alpha is! num || alpha < 0 || alpha > 1) {
      _fail('$name: alpha must be a number 0–1, got $alpha');
    }
    final base = _colorValue(
      _resolve(value['components'], mode),
      mode,
      name,
    );
    final a = (alpha * 255).round();
    return (a << 24) | (base & 0x00FFFFFF);
  }
  _fail('$name: unsupported color value $value');
}

int _hex(String value, String name) {
  final hex = value.startsWith('#') ? value.substring(1) : value;
  if (!RegExp(r'^[0-9a-fA-F]{6}([0-9a-fA-F]{2})?$').hasMatch(hex)) {
    _fail('$name: bad hex color "$value"');
  }
  final rgb = int.parse(hex.substring(0, 6), radix: 16);
  final a = hex.length == 8 ? int.parse(hex.substring(6), radix: 16) : 0xFF;
  return (a << 24) | rgb;
}

/// Resolves a dimension token to a plain number. Only `px` is accepted.
num _dimension(Map<String, dynamic> token, String name) {
  if (token[r'$type'] != 'dimension') _fail('$name is not a dimension token.');
  final value = _resolve(token[r'$value'], null);
  if (value is Map && value['unit'] == 'px' && value['value'] is num) {
    return value['value'] as num;
  }
  if (value is num) return value;
  _fail('$name: unsupported dimension $value');
}

String _hexLiteral(int argb) =>
    '0x${argb.toRadixString(16).padLeft(8, '0').toUpperCase()}';

/// Formats a number as a Dart double literal, trimming float noise from the
/// export (e.g. 83.199997 → 83.2).
String _double(num value) {
  final rounded = double.parse(value.toStringAsFixed(4));
  return rounded == rounded.roundToDouble()
      ? '${rounded.toInt()}.0'
      : rounded.toString();
}

// ---------------------------------------------------------------------------
// Naming (DESIGN.md §3.8)
// ---------------------------------------------------------------------------

/// `bg-action-primary_pressed` → `bgActionPrimaryPressed`.
/// `Spring wood` / `SpringWood-500` → `springWood500`.
/// A number following a name that already ends in a digit gets an underscore
/// so `Primary1-500` reads `primary1_500`, not `primary1500`.
String _camel(String name) {
  final parts = name.split(RegExp(r'[-_ ]+')).where((p) => p.isNotEmpty);
  final buffer = StringBuffer();
  for (final part in parts) {
    if (buffer.isEmpty) {
      buffer.write(part[0].toLowerCase() + part.substring(1));
    } else if (RegExp(r'^\d').hasMatch(part)) {
      final last = buffer.toString().codeUnitAt(buffer.length - 1);
      if (last >= 0x30 && last <= 0x39) buffer.write('_');
      buffer.write(part);
    } else {
      buffer.write(part[0].toUpperCase() + part.substring(1));
    }
  }
  return buffer.toString();
}

/// `Space-XL` → `xl`, `Space-2XL` → `x2l`, `Radius-Full` → `full`.
String _scaleName(String name, String prefix) {
  if (!name.startsWith(prefix)) _fail('Expected "$prefix" prefix on $name');
  final suffix = name.substring(prefix.length);
  final numbered = RegExp(r'^(\d+)XL$').firstMatch(suffix);
  if (numbered != null) return 'x${numbered.group(1)}l';
  return suffix.toLowerCase();
}

void _checkUnique(Iterable<String> names, String where) {
  final seen = <String>{};
  for (final name in names) {
    if (!seen.add(name)) _fail('Duplicate Dart name "$name" in $where');
  }
}

String _doc(String? text) {
  final trimmed = text?.trim() ?? '';
  return trimmed.isEmpty ? '' : '/// $trimmed\n';
}

// ---------------------------------------------------------------------------
// Files
// ---------------------------------------------------------------------------

String _palette() {
  final out = StringBuffer(_header)
    ..writeln()
    ..writeln("import 'dart:ui';")
    ..writeln()
    ..writeln('/// Primitive and alias colors from Figma.')
    ..writeln('///')
    ..writeln('/// **Reference only. Components must not use these** — use')
    ..writeln('/// `context.colors` (semantic tokens) instead. See DESIGN.md §2.')
    ..writeln('abstract final class SampathPalette {');

  final names = <String>[];

  out.writeln('  // Primitives');
  for (final scale in _group(['Primitives', 'Colors']).entries) {
    out.writeln('\n  // ${scale.key}');
    for (final token in _tokensIn(scale.value as Map<String, dynamic>)) {
      final name = _camel(token.key);
      names.add(name);
      final argb = _color(token.value, null, token.key);
      out.writeln(
        '  static const Color $name = Color(${_hexLiteral(argb)}); '
        '// ${token.key}',
      );
    }
  }

  out.writeln('\n  // Alias colors (point at primitives)');
  for (final role in _group(['Alias Colors', 'Colors']).entries) {
    out.writeln('\n  // ${role.key}');
    for (final token in _tokensIn(role.value as Map<String, dynamic>)) {
      final name = _camel(token.key);
      final target = _aliasName(token.value[r'$value']);
      // `Key/White` → `Brand Key/White`: same name, same value. Already emitted.
      if (target.isNotEmpty && _camel(target) == name && names.contains(name)) {
        out.writeln('  // ${token.key} → same as primitive [$name]');
        continue;
      }
      names.add(name);
      final value = target.isEmpty
          ? 'Color(${_hexLiteral(_color(token.value, null, token.key))})'
          : _camel(target);
      out.writeln('  static const Color $name = $value; // ${token.key}');
    }
  }

  _checkUnique(names, 'SampathPalette');
  out.writeln('}');
  return out.toString();
}

String _semanticColors() {
  final tokens = <({String name, String figma, String doc, List<int> argb})>[];
  for (final group in _group(['Color collection']).entries) {
    if (group.key.startsWith(r'$')) continue;
    for (final token in _tokensIn(group.value as Map<String, dynamic>)) {
      tokens.add((
        name: _camel(token.key),
        figma: token.key,
        doc: token.value[r'$description'] as String? ?? '',
        argb: [for (final mode in _modes) _color(token.value, mode, token.key)],
      ));
    }
  }
  _checkUnique(tokens.map((t) => t.name), 'SampathColors');

  String instance(String label, int modeIndex) {
    final b = StringBuffer('  static const $label = SampathColors(\n');
    for (final t in tokens) {
      b.writeln('    ${t.name}: Color(${_hexLiteral(t.argb[modeIndex])}),');
    }
    return (b..writeln('  );')).toString();
  }

  final out = StringBuffer(_header)
    ..writeln()
    ..writeln("import 'package:flutter/material.dart';")
    ..writeln()
    ..writeln('/// Semantic colors (`Color collection`), Light and Dark.')
    ..writeln('///')
    ..writeln('/// Components read these through `context.colors`. Register')
    ..writeln('/// [SampathColors.light] / [SampathColors.dark] as a theme')
    ..writeln('/// extension on the app\'s `ThemeData`.')
    ..writeln('@immutable')
    ..writeln(
      'final class SampathColors extends ThemeExtension<SampathColors> {',
    )
    ..writeln('  const SampathColors({');
  for (final t in tokens) {
    out.writeln('    required this.${t.name},');
  }
  out.writeln('  });\n');

  for (final t in tokens) {
    out
      ..write(_doc(t.doc).replaceAll('///', '  ///'))
      ..writeln('  ///')
      ..writeln('  /// Figma: `${t.figma}`')
      ..writeln('  final Color ${t.name};\n');
  }

  out
    ..writeln(instance('light', 0))
    ..writeln()
    ..writeln(instance('dark', 1))
    ..writeln()
    ..writeln('  @override')
    ..writeln('  SampathColors copyWith({');
  for (final t in tokens) {
    out.writeln('    Color? ${t.name},');
  }
  out.writeln('  }) {\n    return SampathColors(');
  for (final t in tokens) {
    out.writeln('      ${t.name}: ${t.name} ?? this.${t.name},');
  }
  out
    ..writeln('    );\n  }\n')
    ..writeln('  @override')
    ..writeln(
      '  SampathColors lerp(ThemeExtension<SampathColors>? other, double t) {',
    )
    ..writeln('    if (other is! SampathColors) return this;')
    ..writeln('    return SampathColors(');
  for (final t in tokens) {
    out.writeln('      ${t.name}: Color.lerp(${t.name}, other.${t.name}, t)!,');
  }
  out
    ..writeln('    );\n  }')
    ..writeln('}\n')
    ..writeln('/// `context.colors.bgPrimary` etc.')
    ..writeln('extension SampathColorsContext on BuildContext {')
    ..writeln('  SampathColors get colors {')
    ..writeln(
      '    final colors = Theme.of(this).extension<SampathColors>();',
    )
    ..writeln('    assert(')
    ..writeln('      colors != null,')
    ..writeln(
      "      'SampathColors is not registered. Add SampathColors.light or '",
    )
    ..writeln("      '.dark to ThemeData.extensions.',")
    ..writeln('    );')
    ..writeln('    return colors ?? SampathColors.light;')
    ..writeln('  }')
    ..writeln('}');
  return out.toString();
}

String _scaleClass({
  required String className,
  required String doc,
  required List<String> path,
  required String prefix,
}) {
  final out = StringBuffer(_header)
    ..writeln()
    ..writeln(doc)
    ..writeln('abstract final class $className {');
  final names = <String>[];
  for (final token in _tokensIn(_group(path))) {
    final name = _scaleName(token.key, prefix);
    names.add(name);
    out.writeln(
      '  static const double $name = '
      '${_double(_dimension(token.value, token.key))}; // ${token.key}',
    );
  }
  _checkUnique(names, className);
  out.writeln('}');
  return out.toString();
}

String _spacing() => _scaleClass(
  className: 'SampathSpacing',
  doc: '/// Spacing scale (`Alias Spacing & Radius` › Spacing).\n'
      '///\n'
      '/// Normal steps: m, l, xl, x3l, x4l (8/12/16/24/32).\n'
      '/// Edge cases only: xxs, xs, s (2/4/6). See DESIGN.md §2.',
  path: ['Alias Spacing & Radius', 'Spacing'],
  prefix: 'Space-',
);

String _radius() => _scaleClass(
  className: 'SampathRadius',
  doc: '/// Corner radius scale (`Alias Spacing & Radius` › Radius).\n'
      '///\n'
      '/// [full] is a pill / circle.',
  path: ['Alias Spacing & Radius', 'Radius'],
  prefix: 'Radius-',
);

String _layout() {
  final out = StringBuffer(_header)
    ..writeln()
    ..writeln('/// Mobile layout and component spacing rules')
    ..writeln('/// (`Component collection` › Mobile). See DESIGN.md §3.7.')
    ..writeln('abstract final class SampathLayout {');
  final names = <String>[];
  final mobile = _group(['Component collection', 'Mobile']);
  for (final group in mobile.entries) {
    if (group.key.startsWith(r'$')) continue;
    out.writeln('\n  // ${group.key}');
    for (final token in _tokensIn(group.value as Map<String, dynamic>)) {
      final name = _camel(token.key);
      names.add(name);
      final target = _aliasName(token.value[r'$value']);
      out
        ..write(
          _doc(token.value[r'$description'] as String?)
              .replaceAll('///', '  ///'),
        )
        ..writeln(
          '  static const double $name = '
          '${_double(_dimension(token.value, token.key))};'
          '${target.isEmpty ? '' : ' // $target'}',
        );
    }
  }
  _checkUnique(names, 'SampathLayout');
  out.writeln('}');
  return out.toString();
}

/// `Display Large-H1` → `Display/Large-H1`, `Body L` → `Body/Large`.
/// Returns the Figma text style name (DESIGN.md §3.4).
String _textStyleName(String group) {
  const sizes = {'XL': 'XLarge', 'L': 'Large', 'M': 'Medium', 'S': 'Small'};
  final space = group.indexOf(' ');
  if (space < 0) _fail('Unexpected typography group "$group"');
  final category = group.substring(0, space);
  final rest = group.substring(space + 1);
  return '$category/${sizes[rest] ?? rest}';
}

/// `Display/Large-H1` → `displayLargeH1`, `Title/XLarge` → `titleXLarge`.
String _textStyleDartName(String figmaName) {
  final parts = figmaName.split(RegExp(r'[/\- ]+'));
  return parts.first.toLowerCase() +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
}

String _typography() {
  final out = StringBuffer(_header)
    ..writeln()
    ..writeln("import 'package:flutter/painting.dart';")
    ..writeln()
    ..writeln('/// Text styles (`Alias Typography` › Mobile).')
    ..writeln('///')
    ..writeln('/// Names follow the Figma **text style** names (DESIGN.md §3.4).')
    ..writeln('/// Styles carry no color; components set it from')
    ..writeln('/// `context.colors`.')
    ..writeln('abstract final class SampathTextStyles {')
    ..writeln("  static const String _package = 'sampath_ds';\n");

  final names = <String>[];
  String? family;
  for (final group in _group(['Alias Typography']).entries) {
    if (group.key.startsWith(r'$')) continue;
    final tokens = Map.fromEntries(
      _tokensIn(group.value as Map<String, dynamic>),
    );
    T need<T>(String key) =>
        (tokens[key] ?? _fail('${group.key} is missing "$key"')) as T;

    final styleFamily = _resolve(
      need<Map<String, dynamic>>('Font family')[r'$value'],
      null,
    );
    if (styleFamily is! String) _fail('${group.key}: bad font family');
    family ??= styleFamily;
    if (styleFamily != family) {
      _fail('${group.key} uses "$styleFamily"; only "$family" is bundled.');
    }

    // Quirk: weights are exported as px dimensions. Ignore the unit.
    final weight = _dimension(need('Font weight'), '${group.key} weight');
    if (weight % 100 != 0 || weight < 100 || weight > 900) {
      _fail('${group.key}: weight $weight is not a FontWeight');
    }
    final size = _dimension(need('Font size'), '${group.key} size');
    // Quirk: line height is px. Flutter wants a multiple of font size.
    final lineHeight = double.parse(
      _dimension(need('Line height'), '${group.key} line height')
          .toStringAsFixed(2),
    );

    final figmaName = _textStyleName(group.key);
    final name = _textStyleDartName(figmaName);
    names.add(name);
    out
      ..writeln(
        '  /// `$figmaName` · ${weight.toInt()} · ${_trim(size)} / '
        '${_trim(lineHeight)}',
      )
      ..writeln('  static const TextStyle $name = TextStyle(')
      ..writeln("    fontFamily: '$family',")
      ..writeln('    package: _package,')
      ..writeln('    fontWeight: FontWeight.w${weight.toInt()},')
      ..writeln('    fontSize: ${_double(size)},')
      ..writeln('    height: ${_double(lineHeight / size)}, // ${_trim(lineHeight)} / ${_trim(size)}')
      ..writeln('    letterSpacing: 0.0,')
      ..writeln('    leadingDistribution: TextLeadingDistribution.even,')
      ..writeln('  );\n');
  }
  _checkUnique(names, 'SampathTextStyles');
  out.writeln('}');
  return out.toString();
}

String _trim(num value) =>
    value == value.roundToDouble() ? '${value.toInt()}' : '$value';

Never _fail(String message) {
  stderr.writeln('generate_tokens: $message');
  exit(1);
}
