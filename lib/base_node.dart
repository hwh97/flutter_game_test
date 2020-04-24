import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter_game_test/game.dart';


abstract class BaseNode {
  final FlutterGame game;
  final String key;

  Size screenSize;
  VoidCallback onTapDown;

  BaseNode(this.game, this.key) {
    initialize();
  }

  void initialize();

  @mustCallSuper
  void resize(Size size) {
    this.screenSize = size;
  }

  void render(Canvas canvas);

  void update(double t);

  void onTap(TapDownDetails details);

  double get centerX => screenSize.width / 2;

  double get centerY => screenSize.height / 2;

  bool isHit(
      {TapDownDetails details,
      double startX,
      double endX,
      double startY,
      double endY}) {
    return details.localPosition.dx >= startX &&
        details.localPosition.dx <= endX &&
        details.localPosition.dy >= startY &&
        details.localPosition.dy <= endY;
  }
}
