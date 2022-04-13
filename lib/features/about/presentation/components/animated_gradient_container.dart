import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_spotify_africa_assessment/colors.dart';
import 'package:flutter_spotify_africa_assessment/features/about/presentation/images/images.dart';

class AnimatedGradientContainer extends AnimatedWidget {
  const AnimatedGradientContainer(
      {Key? key, required Animation<double> animation})
      : super(key: key, listenable: animation);

  /// Get point on unit square based on angle t
  Point<double> _getPointOnUnitSquare(double t) {
    if (t > (7 * pi) / 4 || t <= pi / 4) {
      // right
      return Point(1, tan(t));
    } else if (t > pi / 4 && t <= (3 * pi) / 4) {
      // top
      return Point(tan(pi / 2 - t), 1);
    } else if (t > (3 * pi) / 4 && t <= (5 * pi) / 4) {
      // left
      return Point(-1, tan(pi - t));
    } else {
      // bottom
      return Point(-tan((3 * pi) / 2 - t), -1);
    }
  }

  @override
  Widget build(BuildContext context) {
    final animation = listenable as Animation<double>;
    final p = _getPointOnUnitSquare(animation.value);
    return Container(
      padding: const EdgeInsets.only(
        top: kToolbarHeight,
      ),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment(p.x, p.y),
          end: Alignment(-p.x, -p.y),
          colors: const [
            AppColors.blue,
            AppColors.cyan,
            AppColors.green,
          ],
          stops: [0.0, 0.5 + (sin(3 * animation.value) * 0.35), 1.0],
        ),
      ),
      alignment: Alignment.center,
      child: Image.asset(
        AboutImages.logoWhite,
        width: MediaQuery.of(context).size.width * 0.5,
      ),
    );
  }
}
