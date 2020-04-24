import 'dart:async';
import 'dart:typed_data';
import 'dart:ui' as UI;
import 'dart:ui';

import 'package:flutter/services.dart';
import 'package:flutter/src/gestures/tap.dart';
import 'package:flutter_game_test/game.dart';
import 'package:flutter_game_test/base_node.dart';

class ScrollBg extends BaseNode {
  UI.Image bgImage;

  final int scrollTime = 10000;
  bool stop = false;
  double time = 0.0;
  double offsetX = 0.0;

  ScrollBg(FlutterGame game, String key) : super(game, key);

  @override
  void initialize() async {
    // prepare background image data
    bgImage = await loadUiImage("assets/bg.png");
  }

  @override
  void render(UI.Canvas canvas) {
    if (bgImage == null || screenSize == null) return;
    Paint bgPaint = Paint()
      ..color = Color(0xFF64B5F6)
      ..isAntiAlias = true;
    canvas.drawRect(Rect.fromLTWH(0, 0, screenSize.width, screenSize.height), bgPaint);
    // draw first background
    canvas.scale(screenSize.width / bgImage.width, screenSize.height / bgImage.height);
    canvas.drawImage(bgImage, Offset(offsetX / (screenSize.width / bgImage.width), 0), bgPaint);
    // draw second background
    canvas.drawImage(bgImage, Offset((offsetX - screenSize.width) / (screenSize.width / bgImage.width), 0), bgPaint);
    // restore canvas
    canvas.restore();
  }

  @override
  void update(double t) {
    time += t;
    offsetX = (time % (scrollTime / 1000)) / (scrollTime / 1000) * screenSize.width;
  }

  @override
  void onTap(TapDownDetails details) {
    if (onTapDown != null) {
      onTapDown();
    }
  }

  Future<UI.Image> loadUiImage(String imageAssetPath) async {
    final ByteData data = await rootBundle.load(imageAssetPath);
    final Completer<UI.Image> completer = Completer();
    UI.decodeImageFromList(Uint8List.view(data.buffer), (UI.Image img) {
      return completer.complete(img);
    });
    return completer.future;
  }
}