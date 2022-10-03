import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

/// {@template dismissible_cty_item}
/// An item used in favorite cities list.
/// {@endtemplate}
class DismissibleCityItem extends StatefulWidget {
  /// {@macro dismissible_cty_item}
  const DismissibleCityItem({
    required super.key,
    required this.name,
    required this.temperature,
    required this.onPressed,
    required this.onRemoved,
    this.dismissSpacing = 8.0,
    this.minHeight = 48.0,
  });

  final String name;
  final String temperature;
  final VoidCallback onPressed;
  final VoidCallback onRemoved;

  /// Spacing between an item and "dismiss background".
  ///
  /// Instead of revealing background while dismissing we show "dismiss background"
  /// next to the item. Therefore we need some space between them.
  final double dismissSpacing;

  /// Minimum item height.
  final double minHeight;

  @override
  State<DismissibleCityItem> createState() => _DismissibleCityItemState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(StringProperty('name', name));
    properties.add(StringProperty('temperature', temperature));
    properties.add(DoubleProperty('dismissSpacing', dismissSpacing));
    properties.add(DoubleProperty('minHeight', minHeight));
  }
}

class _DismissibleCityItemState extends State<DismissibleCityItem> {
  late final ValueNotifier<double> _dismissWidth;

  @override
  void initState() {
    super.initState();
    _dismissWidth = ValueNotifier<double>(0);
  }

  @override
  void dispose() {
    _dismissWidth.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        final item = InkWell(
          onTap: widget.onPressed,
          borderRadius: BorderRadius.circular(8),
          child: ConstrainedBox(
            constraints: BoxConstraints(
              minHeight: widget.minHeight,
            ),
            child: Padding(
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  Expanded(
                    child: Text(
                      widget.name,
                      style: Theme.of(context).textTheme.titleLarge!,
                    ),
                  ),
                  const SizedBox(width: 16),
                  Text(
                    widget.temperature,
                    style: Theme.of(context).textTheme.titleLarge!,
                  ),
                ],
              ),
            ),
          ),
        );

        final dismissBackground = Align(
          alignment: Alignment.centerRight,
          child: ValueListenableBuilder<double>(
            valueListenable: _dismissWidth,
            builder: (_, width, __) => Container(
              width: width,
              height: double.infinity,
              decoration: BoxDecoration(
                color: Theme.of(context).colorScheme.error,
                borderRadius: BorderRadius.circular(8),
              ),
              padding: const EdgeInsets.symmetric(horizontal: 8),
              child: AnimatedSwitcher(
                duration: AnimationDuration.standard,
                switchInCurve: Curves.easeOutBack,
                transitionBuilder: (child, animation) {
                  return ScaleTransition(
                    scale: animation,
                    child: FadeTransition(
                      opacity: animation,
                      child: child,
                    ),
                  );
                },
                // Ideally, instead of _minHeight, we should use the height
                // of this item. Then a clear icon appears when dismissBackground
                // is square.
                child: width < widget.minHeight
                    ? null
                    : const Icon(Icons.clear_rounded),
              ),
            ),
          ),
        );

        return ClipRRect(
          child: Dismissible(
            key: widget.key!,
            background: dismissBackground,
            onUpdate: (details) => _onUpdate(details, constraints.maxWidth),
            direction: DismissDirection.endToStart,
            onDismissed: _onDismissed,
            child: item,
          ),
        );
      },
    );
  }

  void _onUpdate(DismissUpdateDetails details, double width) {
    _dismissWidth.value = max(
      0,
      width * details.progress - widget.dismissSpacing,
    );
  }

  void _onDismissed(DismissDirection _) {
    widget.onRemoved();
  }
}
