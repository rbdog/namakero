import 'package:bug_slot/sprite_components/reel.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

import 'package:flutter/services.dart';

class BugSlotGame extends FlameGame with TapDetector, KeyboardEvents {
  late Reel reel1;
  late Reel reel2;
  late Reel reel3;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 必要な画像を先にキャッシュへ読み込んでおく
    await Flame.images.loadAll([
      'catch-frame.png',
      'seven.png',
    ]);

    reel1 = Reel();
    reel1.anchor = Anchor.center;
    add(reel1);

    reel2 = Reel();
    reel2.anchor = Anchor.center;
    add(reel2);

    reel3 = Reel();
    reel3.anchor = Anchor.center;
    add(reel3);

    // resizeReels(canvasSize);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    resizeReels(canvasSize);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    print('onResize Game');
    super.onGameResize(canvasSize);
    // resizeReels(canvasSize);
  }

  resizeReels(Vector2 canvasSize) {
    reel1.size = Vector2(100, 300);
    reel1.position.x = canvasSize.x / 2 - 100;
    reel1.position.y = canvasSize.y / 2;
    reel2.size = Vector2(100, 300);
    reel2.position.x = canvasSize.x / 2;
    reel2.position.y = canvasSize.y / 2;
    reel3.size = Vector2(100, 300);
    reel3.position.x = canvasSize.x / 2 + 100;
    reel3.position.y = canvasSize.y / 2;
  }

  @override
  void onTapUp(TapUpInfo info) {
    print('画面をタップしました');
    // スペースキー を押したとき と同じことをする
    onTapSpaceKey();
  }

  // スペースキー を押したとき
  onTapSpaceKey() {
    reel1.tryCatchSymbol();
    reel2.tryCatchSymbol();
    reel3.tryCatchSymbol();
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
