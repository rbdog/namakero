import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

SpriteAnimationData _loadData() {
  debugPrint('load data が呼ばれました');
  final animationData = SpriteAnimationData.sequenced(
    amount: 3, // 1枚の画像の中に 全部でいくつの画像があるか, あえて少なくすることで、いらない部分は使わなかったりできる
    amountPerRow: 3, // 横に向かってどのくらい使うか 折り返すまでの数 これ以上右側は捨てられると思えばわかりやすい
    textureSize: Vector2.all(32), // 画像のキャラサイズ
    stepTime: 0.5,
    loop: true,
  );

  return animationData;
}

class SlotSymbol extends SpriteAnimationComponent {
  final String id;
  SlotSymbol(this.id)
      : super.fromFrameData(Flame.images.fromCache('seven.png'), _loadData());

  //
  // 読み込み
  //
  @override
  Future<void> onLoad() async {
    super.onLoad();
    final hitbox = HitboxRectangle(relation: Vector2(0.5, 0.5));
    // addHitbox(hitbox);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  //
  // レンダリングの前に一度呼ばれる ここでサイズ調整する
  //
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  @override
  void update(double dt) {
    super.update(dt);
  }
}
