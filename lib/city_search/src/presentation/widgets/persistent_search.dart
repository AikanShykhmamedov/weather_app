import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/localization/localization.dart';

/// {@template PersistentSearch}
/// A TextField that stays at the top of CustomScrollView.
/// {@endtemplate}
class PersistentSearch extends StatefulWidget {
  /// {@macro PersistentSearch}
  const PersistentSearch({
    super.key,
    required this.onTextChanged,
    this.autofocus = true,
    this.textFieldHeight = 52.0,
    this.textFieldPadding = const EdgeInsets.all(12),
  });

  /// Triggers when text is changed.
  final void Function(String) onTextChanged;

  /// Whether to focus when entering the screen.
  ///
  /// Opens the keyboard automatically if `true`.
  final bool autofocus;

  /// Height of textField.
  final double textFieldHeight;

  /// TextField padding.
  final EdgeInsets textFieldPadding;

  @override
  State<PersistentSearch> createState() => _PersistentSearchState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('autofocus', autofocus));
    properties.add(DoubleProperty('textFieldHeight', textFieldHeight));
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'textFieldPadding', textFieldPadding));
  }
}

class _PersistentSearchState extends State<PersistentSearch> {
  late final TextEditingController _controller;
  late final ValueNotifier<bool> _showClear;

  var _inputText = '';

  @override
  void initState() {
    super.initState();

    _controller = TextEditingController(text: _inputText);
    _showClear = ValueNotifier<bool>(false);

    _controller.addListener(() {
      if (_inputText != _controller.text) {
        _inputText = _controller.text;
        _showClear.value = _inputText.isNotEmpty;
        widget.onTextChanged(_inputText);
      }
    });
  }

  @override
  void dispose() {
    _showClear.dispose();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final clearButton = ValueListenableBuilder<bool>(
      valueListenable: _showClear,
      builder: (_, show, __) => show
          ? IconButton(
              onPressed: _controller.clear,
              icon: const Icon(Icons.cancel_rounded),
            )
          : const SizedBox.shrink(),
    );

    final textField = TextField(
      controller: _controller,
      autofocus: widget.autofocus,
      keyboardType: TextInputType.text,
      textInputAction: TextInputAction.done,
      textAlignVertical: TextAlignVertical.center,
      decoration: InputDecoration(
        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
        border: InputBorder.none,
        hintText: S.of(context).city_search_hint,
        suffixIcon: clearButton,
      ),
    );

    final theme = Theme.of(context);

    return SliverPersistentHeader(
      pinned: true,
      delegate: _PersistentSearchDelegate(
        height: widget.textFieldHeight + widget.textFieldPadding.vertical,
        textFieldHeight: widget.textFieldHeight,
        textFieldPadding: widget.textFieldPadding,
        textField: textField,
        appBarBackground: theme.appBarTheme.backgroundColor!,
        textFieldBackground: theme.colorScheme.onBackground,
        surfaceTint: theme.colorScheme.surfaceTint,
        scrolledUnderElevation: theme.appBarTheme.scrolledUnderElevation!,
      ),
    );
  }
}

class _PersistentSearchDelegate extends SliverPersistentHeaderDelegate {
  const _PersistentSearchDelegate({
    required this.height,
    required this.textFieldHeight,
    required this.textFieldPadding,
    required this.textField,
    required this.appBarBackground,
    required this.textFieldBackground,
    required this.surfaceTint,
    required this.scrolledUnderElevation,
  });

  final double height;
  final double textFieldHeight;
  final EdgeInsets textFieldPadding;
  final Widget textField;
  final Color appBarBackground;
  final Color textFieldBackground;
  final Color surfaceTint;
  final double scrolledUnderElevation;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(
    BuildContext context,
    double shrinkOffset,
    bool overlapsContent,
  ) {
    final elevation = overlapsContent ? scrolledUnderElevation : 0.0;
    final backgroundColor = ElevationOverlay.applySurfaceTint(
      appBarBackground,
      surfaceTint,
      elevation,
    );
    final textFieldBackgroundColor = ElevationOverlay.applySurfaceTint(
      textFieldBackground,
      surfaceTint,
      elevation,
    );

    return ColoredBox(
      color: backgroundColor,
      child: Padding(
        padding: textFieldPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: textFieldHeight,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: textFieldBackgroundColor,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: textField,
            ),
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PersistentSearchDelegate oldDelegate) {
    return oldDelegate.height != height ||
        oldDelegate.textFieldHeight != textFieldHeight ||
        oldDelegate.textFieldPadding != textFieldPadding ||
        oldDelegate.textField != textField ||
        oldDelegate.appBarBackground != appBarBackground ||
        oldDelegate.textFieldBackground != textFieldBackground ||
        oldDelegate.surfaceTint != surfaceTint ||
        oldDelegate.scrolledUnderElevation != scrolledUnderElevation;
  }
}
