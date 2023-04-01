import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

class WeatherPageIndicator extends StatefulWidget {
  const WeatherPageIndicator({
    super.key,
    required this.controller,
    required this.favoriteCitiesCount,
  });

  final PageController controller;
  final int favoriteCitiesCount;

  @override
  State<WeatherPageIndicator> createState() => _WeatherPageIndicatorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('favoriteCitiesCount', favoriteCitiesCount));
  }
}

class _WeatherPageIndicatorState extends State<WeatherPageIndicator> {
  late int _current;

  @override
  void initState() {
    super.initState();
    _current = widget.controller.initialPage;
    widget.controller.addListener(_pageControllerListener);
  }

  @override
  void dispose() {
    widget.controller.removeListener(_pageControllerListener);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(
        (1 + widget.favoriteCitiesCount) * 2 - 1,
        (index) {
          if (index.isOdd) {
            return const SizedBox(width: 6);
          }

          index ~/= 2;

          final color = index == _current
              ? Theme.of(context).colorScheme.primary
              : Theme.of(context).colorScheme.primaryContainer;

          return index == 0
              ? _AnimatedLocationIcon(
                  color: color,
                )
              : AnimatedContainer(
                  duration: AnimationDuration.standard,
                  width: 8,
                  height: 8,
                  decoration: BoxDecoration(
                    color: color,
                    shape: BoxShape.circle,
                  ),
                );
        },
      ),
    );
  }

  void _pageControllerListener() {
    final page = widget.controller.page!.round();

    if (_current != page) {
      setState(() => _current = page);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(IntProperty('current', _current));
  }
}

class _AnimatedLocationIcon extends ImplicitlyAnimatedWidget {
  const _AnimatedLocationIcon({
    required this.color,
  }) : super(duration: AnimationDuration.standard);

  final Color color;

  @override
  ImplicitlyAnimatedWidgetState<_AnimatedLocationIcon> createState() =>
      _AnimatedLocationIconState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(ColorProperty('color', color));
  }
}

class _AnimatedLocationIconState
    extends ImplicitlyAnimatedWidgetState<_AnimatedLocationIcon> {
  ColorTween? _colorTween;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _colorTween = visitor(
      _colorTween,
      widget.color,
      (dynamic value) => ColorTween(begin: value as Color),
    ) as ColorTween?;
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: animation,
      builder: (context, _) {
        return Icon(
          Icons.fmd_good,
          color: _colorTween?.evaluate(animation),
          size: 12,
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<ColorTween>('colorTween', _colorTween));
  }
}
