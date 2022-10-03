import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:weather_app/app/app_constants.dart';

/// {@template persistent_app_bar}
/// AppBar with an animation of title.
/// {@endtemplate}
class PersistentAppBar extends StatelessWidget {
  /// {@macro persistent_app_bar}
  const PersistentAppBar({
    super.key,
    required this.leading,
    required this.largeTitle,
    this.largeTitlePadding = const EdgeInsets.symmetric(horizontal: 16),
    this.verticalSpacing = 24.0,
    this.toolbarHeight = 56.0,
  });

  /// {@macro persistent_app_bar_delegate.leading}
  final Widget leading;

  /// {@macro persistent_app_bar_delegate.large_title}
  final Text largeTitle;

  /// {@macro persistent_app_bar_delegate.large_title_padding}
  final EdgeInsets largeTitlePadding;

  /// Spacing between `toolbar` and `largeTitle` in expanded mode.
  final double verticalSpacing;

  /// {@macro persistent_app_bar_delegate.toolbar_height}
  final double toolbarHeight;

  @override
  Widget build(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    final width = MediaQuery.of(context).size.width;

    final largeTitleHeight = _textHeight(
      text: largeTitle,
      maxWidth: width - largeTitlePadding.horizontal,
    );

    final minExtent = topPadding + toolbarHeight;
    final maxExtent = minExtent + verticalSpacing + largeTitleHeight;

    return SliverPersistentHeader(
      pinned: true,
      delegate: _PersistentAppBarDelegate(
        leading: leading,
        largeTitle: largeTitle,
        largeTitlePadding: largeTitlePadding,
        centerTitle: Theme.of(context).platform == TargetPlatform.iOS,
        toolbarHeight: toolbarHeight,
        minExtent: minExtent,
        maxExtent: maxExtent,
      ),
    );
  }

  double _textHeight({required Text text, required double maxWidth}) {
    final textPainter = TextPainter(
      text: TextSpan(text: text.data, style: text.style),
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: maxWidth);

    return textPainter.size.height;
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties.add(DiagnosticsProperty<EdgeInsetsGeometry>(
        'largeTitlePadding', largeTitlePadding));
    properties.add(DoubleProperty('verticalSpacing', verticalSpacing));
    properties.add(DoubleProperty('toolbarHeight', toolbarHeight));
  }
}

class _PersistentAppBarDelegate extends SliverPersistentHeaderDelegate {
  const _PersistentAppBarDelegate({
    required this.leading,
    required this.largeTitle,
    required this.largeTitlePadding,
    required this.centerTitle,
    required this.toolbarHeight,
    required this.minExtent,
    required this.maxExtent,
  }) : _dExtent = maxExtent - minExtent;

  /// {@template persistent_app_bar_delegate.leading}
  /// A widget on the left in `toolbar`.
  /// {@endtemplate}
  final Widget leading;

  /// {@template persistent_app_bar_delegate.large_title}
  /// Title at the bottom.
  ///
  /// It is covered by `toolbar` when this [PersistentAppBar] collapsed. A small
  /// title appears instead in `toolbar` at the center on iOS or at the left
  /// otherwise.
  /// {@endtemplate}
  final Text largeTitle;

  /// {@template persistent_app_bar_delegate.large_title_padding}
  /// Horizontal padding of `largeTitle`.
  /// {@endtemplate}
  final EdgeInsets largeTitlePadding;

  /// Whether to center `smallTitle` in `toolbar` in collapsed mode.
  final bool centerTitle;

  /// {@template persistent_app_bar_delegate.toolbar_height}
  /// The height of toolbar.
  /// {@endtemplate}
  final double toolbarHeight;

  @override
  final double minExtent;

  @override
  final double maxExtent;

  final double _dExtent;

  @override
  Widget build(BuildContext context, double shrinkOffset, bool _) {
    final foreground = SizedBox(
      width: double.infinity,
      height: toolbarHeight,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
      ),
    );

    final showSmallTitle = shrinkOffset >= _dExtent;

    final smallTitle = _AnimatedSmallTitle(
      curve: Curves.easeInOutCubic,
      duration: AnimationDuration.fast,
      show: showSmallTitle,
      child: Text(
        largeTitle.data!,
        maxLines: 1,
        softWrap: false,
        overflow: TextOverflow.fade,
        style: Theme.of(context).textTheme.titleLarge!,
      ),
    );

    return SizedBox(
      width: double.infinity,
      height: maxExtent,
      child: ColoredBox(
        color: Theme.of(context).scaffoldBackgroundColor,
        child: SafeArea(
          bottom: false,
          child: Stack(
            children: [
              Align(
                alignment: Alignment.bottomLeft,
                child: Padding(
                  padding: largeTitlePadding,
                  child: largeTitle,
                ),
              ),
              foreground,
              Align(
                alignment: Alignment.topLeft,
                child: ConstrainedBox(
                  constraints: BoxConstraints.tightFor(
                    width: toolbarHeight,
                    height: toolbarHeight,
                  ),
                  child: leading,
                ),
              ),
              Positioned(
                left: 64,
                right: 64,
                height: toolbarHeight,
                child: Align(
                  alignment:
                      centerTitle ? Alignment.center : Alignment.centerLeft,
                  child: smallTitle,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  @override
  bool shouldRebuild(covariant _PersistentAppBarDelegate oldDelegate) {
    return oldDelegate.leading != leading ||
        oldDelegate.largeTitle != largeTitle ||
        oldDelegate.largeTitlePadding != largeTitlePadding ||
        oldDelegate.centerTitle != centerTitle ||
        oldDelegate.minExtent != minExtent ||
        oldDelegate.maxExtent != maxExtent ||
        oldDelegate.toolbarHeight != toolbarHeight;
  }
}

class _AnimatedSmallTitle extends StatefulWidget {
  const _AnimatedSmallTitle({
    required this.curve,
    required this.duration,
    required this.show,
    required this.child,
  });

  final Curve curve;
  final Duration duration;
  final bool show;
  final Widget child;

  @override
  State<_AnimatedSmallTitle> createState() => _AnimatedSmallTitleState();

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(IntProperty('duration', duration.inMilliseconds, unit: 'ms'));
    properties.add(DiagnosticsProperty<bool>('show', show));
  }
}

class _AnimatedSmallTitleState extends State<_AnimatedSmallTitle>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller;
  late Animation<double> _animation;

  late final Tween<double> _opacityTween;
  late final EdgeInsetsTween _paddingTween;
  late final Tween<double> _scaleTween;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: widget.duration);
    _animation = _controller.drive(CurveTween(curve: widget.curve));

    _opacityTween = Tween<double>(begin: 0.0, end: 1.0);
    _paddingTween = EdgeInsetsTween(
      begin: const EdgeInsets.only(top: 8),
      end: EdgeInsets.zero,
    );
    _scaleTween = Tween<double>(begin: 0.9, end: 1.0);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  void didUpdateWidget(covariant _AnimatedSmallTitle oldWidget) {
    super.didUpdateWidget(oldWidget);

    if (oldWidget.curve != widget.curve) {
      _animation = _controller.drive(CurveTween(curve: widget.curve));
    }

    if (oldWidget.show != widget.show) {
      widget.show ? _controller.forward() : _controller.reverse();
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _animation,
      builder: (context, _) {
        return Opacity(
          opacity: _opacityTween.evaluate(_animation),
          child: Padding(
            padding: _paddingTween.evaluate(_animation),
            child: Transform.scale(
              scale: _scaleTween.evaluate(_animation),
              child: widget.child,
            ),
          ),
        );
      },
    );
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
        .add(DiagnosticsProperty<Tween<double>>('opacityTween', _opacityTween));
    properties.add(
        DiagnosticsProperty<EdgeInsetsTween>('paddingTween', _paddingTween));
    properties
        .add(DiagnosticsProperty<Tween<double>>('scaleTween', _scaleTween));
  }
}
