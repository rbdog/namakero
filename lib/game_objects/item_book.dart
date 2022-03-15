import 'package:flame/components.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:namakero/game_objects/ground.dart';
import 'package:namakero/game_objects/neet.dart';
import 'package:namakero/layers/world_layer.dart';

class ItemBook extends SpriteComponent with HasHitboxes, Collidable {
  final double fallSpeed = 200;

  ItemBook() : super(size: Vector2(100, 100));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('item-book.png');
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
  }

  @override
  void update(double dt) {
    if (isPlaying()) {
      position.y += fallSpeed * dt;
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, Collidable other) {
    if (other is Ground) {
      debugPrint('地面に当たりました');
      removeFromParent();
    }
  }

  @override
  void onCollisionEnd(Collidable other) {}
}
