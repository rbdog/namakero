import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flutter/material.dart';
import 'package:namakero/namakemono_position.dart';

class Namakemono extends SpriteComponent {
  PlayPosition playPosition = PlayPosition.leftPole;
  final double fallSpeed = 150;

  Namakemono() : super(size: Vector2.all(128));

  Future<void> onLoad() async {
    sprite = await Sprite.load('namakemono.png');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position.x = (gameSize.x / 2) - 200;
    position.y = gameSize.y / 2;
  }

  @override
  void update(double dt) {
    if (position.y < 700) {
      position.y += fallSpeed * dt;
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
}
