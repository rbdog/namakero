import 'package:flame/components.dart';

class TreePole extends SpriteComponent {
  TreePole() : super(size: Vector2(30, 700));

  @override
  Future<void> onLoad() async {
    sprite = await Sprite.load('tree-pole.png');
    anchor = Anchor.center;
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }
}

class LeftPole extends TreePole {
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position.x = (gameSize.x / 2) - 200;
    position.y = gameSize.y / 2;
  }
}

class RightPole extends TreePole {
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);

    position.x = (gameSize.x / 2) + 200;
    position.y = gameSize.y / 2;
  }
}
