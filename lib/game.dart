import 'dart:ui' as UI;
import 'dart:async';
import 'dart:typed_data';

import 'package:flame/flare_animation.dart';
import 'package:flame/sprite.dart';
import 'package:flutter/services.dart';
import 'package:box2d_flame/box2d.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';
import 'package:flutter_game_test/dog.dart';
import 'package:flutter_game_test/scroll_bg.dart';

class FlutterGame extends Game {
  Size screenSize;
  // game child
  ScrollBg _scrollBg;
  Dog _dog;

  FlutterGame() {
    initialize();
  }

  void initialize() async {
    _scrollBg = ScrollBg(this, "bg");
    _dog = Dog(this, "dog");
    _addAction();
    resize(await Flame.util.initialDimensions());
  }

  void resize(Size size) {
    screenSize = size;
    _scrollBg.resize(size);
    _dog.resize(size);
    super.resize(size);
  }

  @override
  void render(Canvas canvas) {
    _scrollBg?.render(canvas);
    _dog?.render(canvas);
  }

  @override
  void update(double t) {
    _scrollBg?.update(t);
    _dog?.update(t);
  }

  bool jumping = false;

  void _addAction() {
    _scrollBg.onTapDown = () {
      if (!jumping)
        print("you tap stage");
    };

    _dog.onTapDown = () async {
      jumping = true;
      print("you tap dog wang wang wang");
      _dog.playJump();
      await Future.delayed(Duration(milliseconds: 4000));
      jumping = false;
    };
  }

  void onTapDown(TapDownDetails details)  {
    //TODO 响应优先级
    _dog.onTap(details);
    _scrollBg.onTap(details);
  }
}
