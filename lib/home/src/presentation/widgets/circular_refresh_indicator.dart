import 'dart:math';

import 'package:custom_refresh_indicator/custom_refresh_indicator.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

class CircularRefreshIndicator extends StatefulWidget {
  const CircularRefreshIndicator({
    super.key,
    required this.onRefresh,
    required this.child,
    this.indicatorSize = 24.0,
    this.indicatorVerticalPadding = 16,
  });

  final Future<void> Function() onRefresh;
  final Widget child;
  final double indicatorSize;
  final double indicatorVerticalPadding;

  @override
  State<CircularRefreshIndicator> createState() =>
      _CircularRefreshIndicatorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('indicatorSize', indicatorSize));
    properties.add(
        DoubleProperty('indicatorVerticalPadding', indicatorVerticalPadding));
  }
}

class _CircularRefreshIndicatorState extends State<CircularRefreshIndicator> {
  bool _isCompleted = false;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final indicatorContainerHeight =
        widget.indicatorVerticalPadding * 2 + widget.indicatorSize;

    return CustomRefreshIndicator(
      onRefresh: widget.onRefresh,
      loadingToIdleDuration: AnimationDuration.standard,
      onStateChanged: _onStateChanged,
      builder: (context, child, controller) {
        final translatedChild = AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            return Transform.translate(
              offset: Offset(
                0.0,
                (indicatorContainerHeight + topPadding) * controller.value,
              ),
              child: child,
            );
          },
        );

        final translatedIndicator = AnimatedBuilder(
          animation: controller,
          builder: (context, _) {
            final value = controller.value.clamp(0.0, 1.0);

            return Transform.translate(
              offset: Offset(
                0,
                -(indicatorContainerHeight + topPadding) * (1 - value),
              ),
              child: Container(
                height: indicatorContainerHeight,
                alignment: Alignment.center,
                margin: EdgeInsets.only(top: topPadding),
                child: RoundedCircularProgressIndicator(
                  value: controller.isLoading || _isCompleted ? null : value,
                  maxSegmentExtent: _isCompleted ? 1.0 : 0.75,
                  completed: _isCompleted,
                ),
              ),
            );
          },
        );

        return Stack(
          children: <Widget>[
            translatedChild,
            translatedIndicator,
          ],
        );
      },
      child: SingleChildScrollView(
        physics: const AlwaysScrollableScrollPhysics(
          parent: ClampingScrollPhysics(),
        ),
        child: widget.child,
      ),
    );
  }

  void _onStateChanged(IndicatorStateChange change) {
    if (change.newState == IndicatorState.idle) {
      setState(() => _isCompleted = false);
    } else if (change.didChange(
        from: IndicatorState.loading, to: IndicatorState.hiding)) {
      setState(() => _isCompleted = true);
    }
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<bool>('isCompleted', _isCompleted));
  }
}

class RoundedCircularProgressIndicator extends StatefulWidget {
  const RoundedCircularProgressIndicator({
    super.key,
    this.value,
    this.maxSegmentExtent = 0.75,
    this.completed = false,
    this.strokeWidth = 2.5,
  });

  final double? value;
  final double maxSegmentExtent;
  final bool completed;
  final double strokeWidth;

  @override
  State<RoundedCircularProgressIndicator> createState() =>
      _RoundedCircularProgressIndicatorState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', value));
    properties.add(DoubleProperty('maxSegmentExtent', maxSegmentExtent));
    properties.add(DiagnosticsProperty<bool>('completed', completed));
    properties.add(DoubleProperty('strokeWidth', strokeWidth));
  }
}

class _RoundedCircularProgressIndicatorState
    extends State<RoundedCircularProgressIndicator>
    with SingleTickerProviderStateMixin {
  late final AnimationController _rotateController;

  @override
  void initState() {
    super.initState();

    _rotateController = AnimationController(
      vsync: this,
      duration: AnimationDuration.long,
    );

    if (widget.value == null) {
      _rotateController.repeat();
    }
  }

  @override
  void didUpdateWidget(covariant RoundedCircularProgressIndicator oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.value == null && widget.value != null) {
      // Stop rotation animation and let it goes back to 0 degree.
      _rotateController.stop();
      _rotateController.forward();
    } else if (oldWidget.value != null && widget.value == null) {
      _rotateController.repeat();
    }
  }

  @override
  void dispose() {
    _rotateController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _rotateController,
      child: AnimatedCircular(
        value: widget.value,
        maxSegmentExtent: widget.maxSegmentExtent,
        strokeWidth: widget.strokeWidth,
        duration: AnimationDuration.fast,
      ),
      builder: (context, child) {
        return RotationTransition(
          turns: _rotateController,
          child: child,
        );
      },
    );
  }
}

class AnimatedCircular extends ImplicitlyAnimatedWidget {
  const AnimatedCircular({
    super.key,
    this.value,
    this.maxSegmentExtent = 0.75,
    this.strokeWidth = 2.5,
    super.curve = Curves.linear,
    required super.duration,
  }) : assert(maxSegmentExtent >= 0 && maxSegmentExtent <= 1.0);

  final double? value;
  final double maxSegmentExtent;
  final double strokeWidth;

  @override
  AnimatedWidgetBaseState<AnimatedCircular> createState() =>
      _AnimatedCircularState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DoubleProperty('value', value));
    properties.add(DoubleProperty('maxSegmentExtent', maxSegmentExtent));
    properties.add(DoubleProperty('strokeWidth', strokeWidth));
  }
}

class _AnimatedCircularState extends AnimatedWidgetBaseState<AnimatedCircular> {
  Tween<double>? _extent;

  @override
  void forEachTween(TweenVisitor<dynamic> visitor) {
    _extent = visitor(
      _extent,
      (widget.value?.clamp(0.0, 1.0) ?? 1.0) * widget.maxSegmentExtent,
      (value) => Tween<double>(begin: value as double),
    ) as Tween<double>?;
  }

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: const BoxConstraints(
        minWidth: 24,
        minHeight: 24,
      ),
      child: CustomPaint(
        painter: _CircularPainter(
          value: _extent!.evaluate(animation),
          color: Theme.of(context).colorScheme.primary,
          width: widget.strokeWidth,
        ),
      ),
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<Tween<double>>('extent', _extent));
  }
}

class _CircularPainter extends CustomPainter {
  const _CircularPainter({
    required this.value,
    required this.color,
    required this.width,
  });

  final double value;
  final Color color;
  final double width;

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..style = PaintingStyle.stroke
      ..strokeWidth = width
      ..strokeCap = StrokeCap.round;

    canvas.drawArc(
      Offset.zero & size,
      -pi / 2,
      2 * pi * value,
      false,
      paint,
    );
  }

  @override
  bool shouldRepaint(covariant _CircularPainter oldDelegate) {
    return oldDelegate.value != value ||
        oldDelegate.color != color ||
        oldDelegate.width != width;
  }
}
