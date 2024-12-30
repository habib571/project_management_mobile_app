import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class AnimatedIndicator extends StatelessWidget {
  const AnimatedIndicator(
      {super.key,
      required this.activeIndex,
      required this.count,
      required this.dotColor});
  final int activeIndex;
  final int count;
  final Color dotColor;
  @override
  Widget build(BuildContext context) {
    return AnimatedSmoothIndicator(
      axisDirection: Axis.horizontal,
      activeIndex: activeIndex,
      count: count,
      effect: WormEffect(activeDotColor: dotColor),
    );
  }
}
