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
    this.textFieldPadding = const EdgeInsets.fromLTRB(12, 12, 12, 8),
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

    final child = ColoredBox(
      color: Theme.of(context).scaffoldBackgroundColor,
      child: Padding(
        padding: widget.textFieldPadding,
        child: ConstrainedBox(
          constraints: BoxConstraints.expand(
            height: widget.textFieldHeight,
          ),
          child: DecoratedBox(
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.onBackground,
              borderRadius: BorderRadius.circular(12),
            ),
            child: Center(
              child: TextField(
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
              ),
            ),
          ),
        ),
      ),
    );

    return SliverPersistentHeader(
      pinned: true,
      delegate: _PersistentSearchDelegate(
        height: widget.textFieldHeight + widget.textFieldPadding.vertical,
        child: child,
      ),
    );
  }
}

class _PersistentSearchDelegate extends SliverPersistentHeaderDelegate {
  const _PersistentSearchDelegate({
    required this.height,
    required this.child,
  });

  final double height;
  final Widget child;

  @override
  double get minExtent => height;

  @override
  double get maxExtent => height;

  @override
  Widget build(_, __, ___) => child;

  @override
  bool shouldRebuild(covariant _PersistentSearchDelegate oldDelegate) {
    return oldDelegate.height != height || oldDelegate.child != child;
  }
}
