import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'package:namakero/namakemono.dart';
import 'package:namakero/tree_pole.dart';

import 'package:flutter/services.dart';

class NamakeroGame extends FlameGame with TapDetector, KeyboardEvents {
  final paint = Paint()..color = Colors.white;

  late Namakemono nama;
  late LeftPole leftPole;
  late RightPole rightPole;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    this.debugColor = Colors.yellow;

    // 必要な画像を先にキャッシュへ読み込んでおく
    await Flame.images.loadAll([
      'namakemono.png',
      'tree-pole.png',
    ]);

    nama = Namakemono();
    leftPole = LeftPole();
    rightPole = RightPole();

    add(nama);
    add(leftPole);
    add(rightPole);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0.0, 0.0, this.canvasSize.x, canvasSize.y);
    canvas.drawRect(rect, paint);
    super.render(canvas);
  }

  @override
  void onTapUp(TapUpInfo info) {
    print('画面をタップしました');
    // スペースキー を押したとき と同じことをする
    onTapSpaceKey();
  }

  // スペースキー を押したとき
  onTapSpaceKey() {
    print('スペースキーを押しました');

    nama.jump();
  }

  @override
  KeyEventResult onKeyEvent(
    RawKeyEvent event,
    Set<LogicalKeyboardKey> keysPressed,
  ) {
    final isSpace = keysPressed.contains(LogicalKeyboardKey.space);
    if (isSpace) {
      onTapSpaceKey();
      return KeyEventResult.handled;
    }
    return KeyEventResult.ignored;
  }
}
