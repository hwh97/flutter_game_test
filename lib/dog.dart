import 'dart:ui';

import 'package:flame/flare_animation.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:flutter_game_test/game.dart';
import 'package:flutter_game_test/base_node.dart';

class Dog extends BaseNode {
  FlareAnimation flareAnimation;
  bool loaded = false;
  Offset offset;

  Dog(FlutterGame game, String key) : super(game, key);

  @override
  void initialize() async {
    // load flr
    flareAnimation = await FlareAnimation.load("assets/images/loading.flr");
    flareAnimation.updateAnimation("Animations");
    loaded = true;
  }

  @override
  void render(Canvas canvas) {
    if (loaded || screenSize == null) {
      canvas.restore();
      if (offset == null) {
        offset = Offset(centerX - 100, screenSize.height - 220);
      }
      // test width height
      flareAnimation.width = 200;
      flareAnimation.height = 220;
      flareAnimation.render(canvas, x: offset.dx, y: offset.dy);
    }
  }

  @override
  void update(double t) {
    if (loaded) {
      flareAnimation.update(t);
      if (playingAnimation) {
        time += t;
        if (time > (durationTime / 1000) * 2) {
          // end of animation
          playingAnimation = false;
          time = 0.0;
        } else {
          double dogX = centerX - 100;
          double dogY = screenSize.height - 220;
          if (time > (durationTime / 1000)) {
            double tempTime = time %(durationTime / 1000);
            // back animation
            offset = Offset(20 + tempTime * (dogX - 20) / (durationTime / 1000), 30 + tempTime * (dogY - 30) / (durationTime / 1000));
          } else {
            // forward animation
            // set offset move to Offset(20, 130)
            offset = Offset(dogX - time * (dogX - 20) / (durationTime / 1000), dogY - time * (dogY - 30) / (durationTime / 1000));
          }
        }
      }
    }
  }

  @override
  void onTap(TapDownDetails details) {
    if (isHit(details: details,
        startX: centerX - 90,
        endX: centerX + 90,
        startY: 160,
        endY: 380)) {
      if (onTapDown != null) {
        onTapDown();
      }
    }
  }

  final int durationTime = 500; // forward and backward time
  bool playingAnimation = false;
  double time = 0.0;

  void playJump() {
    // set status
    playingAnimation = true;
  }
}