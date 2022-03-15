import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:namakero/layers/world_layer.dart';

class Ground extends SpriteComponent with HasHitboxes, Collidable {
  Ground() : super(size: Vector2(500, 80));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('ground.png');
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
    position.x = gameSize.x / 2;
    position.y = gameSize.y - 40;
  }

  @override
  void update(double dt) {}
}
