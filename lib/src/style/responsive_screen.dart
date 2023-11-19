import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

class ResponsiveScreen extends StatelessWidget {
  const ResponsiveScreen({
    super.key,
    required this.squarishMainArea,
    required this.rectangularMenuArea,
    this.topMessageArea = const SizedBox.shrink(),
    this.mainAreaProminence = 0.8,
  });

  final Widget squarishMainArea;
  final Widget rectangularMenuArea;
  final Widget topMessageArea;
  final double mainAreaProminence;

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(builder: (context, constraints) {
      // This widget wants to fill the whole screen.
      final size = constraints.biggest;
      final padding = EdgeInsets.all(size.shortestSide / 30);
      if (size.height >= size.width) {
        // "Portrait" / "mobile" mode.
        return Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            SafeArea(
              bottom: false,
              child: Padding(
                padding: padding,
                child: topMessageArea,
              ),
            ),
            Expanded(
              flex: (mainAreaProminence * 100).round(),
              child: SafeArea(
                top: false,
                bottom: false,
                minimum: padding,
                child: squarishMainArea,
              ),
            ),
            SafeArea(
              top: false,
              maintainBottomViewPadding: true,
              child: Padding(
                padding: padding,
                child: rectangularMenuArea,
              ),
            )
          ],
        );
      } else {
        // "Landscape" / "tablet" mode.
        final isLarge = size.width > 900;
        return Row(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: isLarge ? 7 : 5,
              child: SafeArea(
                right: false,
                maintainBottomViewPadding: true,
                minimum: padding,
                child: squarishMainArea,
              ),
            ),
            Expanded(
                flex: 3,
                child: Column(
                  children: [
                    SafeArea(
                      bottom: false,
                      left: false,
                      maintainBottomViewPadding: true,
                      child: Padding(
                        padding: padding,
                        child: topMessageArea,
                      ),
                    ),
                    Expanded(
                      child: SafeArea(
                        child: Align(
                          alignment: Alignment.bottomCenter,
                          child: Padding(
                            padding: padding,
                            child: rectangularMenuArea,
                          ),
                        ),
                      ),
                    ),
                  ],
                ))
          ],
        );
      }
    });
  }
}
