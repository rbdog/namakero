import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:namakero/game_objects/item_book.dart';
import 'package:namakero/layers/world_layer.dart';
import 'package:namakero/types/phase.dart';
import 'package:namakero/types/play_position.dart';

class Neet extends SpriteComponent with HasHitboxes, Collidable {
  PlayPosition playPosition = PlayPosition.leftPole;
  final double fallSpeed = 150;

  Neet() : super(size: Vector2.all(128));

  Future<void> onLoad() async {
    sprite = await Sprite.load('neet.png');
    anchor = Anchor.center;
    final shape = HitboxPolygon([
      Vector2(0, 1),
      Vector2(1, 0),
      Vector2(0, -1),
      Vector2(-1, 0),
    ]);
    addHitbox(shape);
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position.x = (gameSize.x / 2) - 200;
    position.y = gameSize.y / 2;
  }

  @override
  void update(double dt) {
    if (isPlaying()) {
      if (position.y < 700) {
        position.y += fallSpeed * dt;
      }
    }
  }

  void jump() {
    late double newX;
    if (playPosition == PlayPosition.leftPole) {
      // 左側にいるとき
      playPosition = PlayPosition.rightPole;
      newX = position.x + 400;
    } else if (playPosition == PlayPosition.rightPole) {
      // 右側にいるとき
      playPosition = PlayPosition.leftPole;
      newX = position.x - 400;
    }
    final effectController =
        EffectController(duration: 0.3, curve: Curves.easeOut);
    final effect = MoveEffect.to(
      Vector2(newX, position.y),
      effectController,
    );

    // 上へ
    final vEffect1 = MoveAlongPathEffect(
      Path()..quadraticBezierTo(0, 0, 0, -200),
      EffectController(
        duration: 0.1,
        curve: Curves.easeOut,
      ),
    );
    // 下へ
    final vEffect2 = MoveAlongPathEffect(
      Path()..quadraticBezierTo(0, 0, 0, 50),
      EffectController(
        duration: 0.20,
        curve: Curves.easeIn,
        startDelay: 0.1,
      ),
    );

    add(effect);
    add(vEffect1);
    add(vEffect2);
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is ItemBook) {
      debugPrint('本に当たりました');
      other.removeHitbox(other.hitboxes.first);
      phase = Phase.result;
    } else {
      debugPrint('本ではない物体に当たりました');
    }
  }
}
