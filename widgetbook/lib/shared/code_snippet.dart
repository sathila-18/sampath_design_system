import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sampath_ds/sampath_ds.dart';

/// A preview with a live code box under it, for "Default" use cases.
///
/// [code] is the exact Dart a developer would paste for the current knobs.
class PreviewWithCode extends StatelessWidget {
  const PreviewWithCode({super.key, required this.preview, required this.code});

  final Widget preview;
  final String code;

  @override
  Widget build(BuildContext context) => Center(
    child: SingleChildScrollView(
      padding: const EdgeInsets.all(SampathSpacing.xl),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          preview,
          const SizedBox(height: SampathSpacing.x3l),
          CodeSnippet(code),
        ],
      ),
    ),
  );
}

/// A box showing [code] in a monospace font, with a Copy button.
class CodeSnippet extends StatefulWidget {
  const CodeSnippet(this.code, {super.key});

  final String code;

  /// How long "Copied" shows after a copy.
  static const copiedDuration = Duration(seconds: 2);

  @override
  State<CodeSnippet> createState() => _CodeSnippetState();
}

class _CodeSnippetState extends State<CodeSnippet> {
  Timer? _timer;

  bool get _copied => _timer?.isActive ?? false;

  Future<void> _copy() async {
    await Clipboard.setData(ClipboardData(text: widget.code));
    if (!mounted) return;
    _timer?.cancel();
    setState(() {
      _timer = Timer(CodeSnippet.copiedDuration, () {
        if (mounted) setState(() {});
      });
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final colors = context.colors;
    return ConstrainedBox(
      constraints: const BoxConstraints(maxWidth: SampathSpacing.x14l),
      child: DecoratedBox(
        decoration: BoxDecoration(
          color: colors.bgSecondary,
          border: Border.all(color: colors.borderDefault),
          borderRadius: BorderRadius.circular(SampathRadius.m),
        ),
        child: Padding(
          padding: const EdgeInsets.all(SampathSpacing.l),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: SelectableText(
                  widget.code,
                  style: SampathTextStyles.bodySmall.copyWith(
                    color: colors.textPrimary,
                    // Widgetbook only: system monospace, no bundled font.
                    fontFamily: 'Menlo',
                    fontFamilyFallback: const [
                      'SF Mono',
                      'Consolas',
                      'Roboto Mono',
                      'Courier New',
                      'monospace',
                    ],
                  ),
                ),
              ),
              const SizedBox(width: SampathSpacing.m),
              TextButton(
                onPressed: _copy,
                style: TextButton.styleFrom(
                  foregroundColor: colors.textAction,
                  textStyle: SampathTextStyles.buttonSmall,
                ),
                child: Text(_copied ? 'Copied' : 'Copy'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

/// `SampathIcons.<name>` for a registry entry.
///
/// Registry fields are the Figma name in lowerCamelCase
/// (`arrow-down-left` → `arrowDownLeft`).
String iconRef(SampathIconData icon) {
  final parts = icon.figmaName.split('-');
  final name =
      parts.first +
      parts.skip(1).map((p) => p[0].toUpperCase() + p.substring(1)).join();
  return 'SampathIcons.$name';
}

/// A constructor call as dart format writes it: on one line when it fits
/// in 80 characters, otherwise one argument per line with a trailing comma.
/// Pass only the named arguments that differ from their defaults.
String dartCall(
  String callee,
  List<String> positional, [
  Map<String, String> named = const {},
]) {
  final args = [
    ...positional,
    for (final e in named.entries) '${e.key}: ${e.value}',
  ];
  final oneLine = '$callee(${args.join(', ')})';
  if (oneLine.length <= 80) return oneLine;
  return '$callee(\n${args.map((a) => '  $a,\n').join()})';
}
