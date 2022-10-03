import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

class ScaleFadeAnimatedSwitcher extends StatelessWidget {
  const ScaleFadeAnimatedSwitcher({
    super.key,
    this.alignment = Alignment.center,
    this.startScale = 0.0,
    required this.child,
  }) : assert(startScale >= 0.0 && startScale <= 1.0);

  final Alignment alignment;
  final double startScale;
  final Widget child;

  @override
  Widget build(BuildContext context) {
    final scaleTween = Tween(begin: startScale, end: 1.0);

    return AnimatedSwitcher(
      duration: AnimationDuration.standard,
      transitionBuilder: (child, animation) => ScaleTransition(
        scale: scaleTween.animate(animation),
        alignment: alignment,
        child: FadeTransition(
          opacity: animation,
          child: child,
        ),
      ),
      layoutBuilder: (currentChild, previousChildren) => Stack(
        alignment: alignment,
        children: <Widget>[
          ...previousChildren,
          if (currentChild != null) currentChild,
        ],
      ),
      child: child,
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<AlignmentGeometry>('alignment', alignment));
    properties.add(PercentProperty('startScale', startScale));
  }
}
