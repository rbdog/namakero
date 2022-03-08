import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flutter/material.dart';

class MyCrate extends SpriteComponent {
  final double speed = 30.0;

  MyCrate() : super(size: Vector2.all(256));

  Future<void> onLoad() async {
    sprite = await Sprite.load('namakemono.png');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position = gameSize / 2;
  }

  @override
  void update(double dt) {
    position.x += speed * dt;
  }
}

class MyGame extends FlameGame {
  @override
  Future<void> onLoad() async {
    await super.onLoad();
    add(MyCrate());
  }
}

main() {
  final myGame = MyGame();
  runApp(
    GameWidget(
      game: myGame,
    ),
  );
}
