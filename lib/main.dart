import 'package:flame/util.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/services.dart';
import 'package:flutter_game_test/game.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  setUpGame();
}

void setUpGame() async {
  var flameUtil = Util();
  await flameUtil.fullScreen();
  await flameUtil.setOrientation(DeviceOrientation.landscapeLeft);
  var game = FlutterGame();
  runApp(game.widget);
  TapGestureRecognizer tapGestureRecognizer = new TapGestureRecognizer();
  tapGestureRecognizer.onTapDown = game.onTapDown;
  flameUtil.addGestureRecognizer(tapGestureRecognizer);
}
