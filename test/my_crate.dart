import 'package:flame/assets.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// アニメーションなしの画像を表示する場合
class MyCrate extends SpriteComponent {
  MyCrate() : super.fromImage(Flame.images.fromCache('crate.png'));

  //
  // 読み込み
  //
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  //
  // レンダリングの前に一度呼ばれる
  //
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }
}
