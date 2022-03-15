import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:namakero/config/track_items.dart';
import 'package:namakero/game_objects/ground.dart';
import 'package:namakero/game_objects/item_book.dart';
import 'dart:ui' as ui;
import 'package:namakero/game_objects/neet.dart';
import 'package:namakero/game_objects/track.dart';
import 'package:namakero/game_objects/tree_pole.dart';
import 'package:flutter/services.dart';
import 'package:namakero/types/item_code.dart';
import 'package:namakero/types/phase.dart';
import 'package:namakero/types/play_position.dart';
import 'package:namakero/types/track_item.dart';

Phase phase = Phase.tapToStart;

bool isPlaying() {
  return phase == Phase.playing;
}

class WorldLayer extends FlameGame
    with HasCollidables, TapDetector, KeyboardEvents {
  final paint = Paint()..color = Colors.white;

  late Neet nama;
  late LeftPole leftPole;
  late RightPole rightPole;
  late Track track;
  late Ground ground;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    // 必要な画像を先にキャッシュへ読み込んでおく
    await Flame.images.loadAll([
      'neet.png',
      'tree-pole.png',
    ]);

    nama = Neet();
    leftPole = LeftPole();
    rightPole = RightPole();
    track = Track(trackItems, (trackItem) {
      dropItem(trackItem);
    });
    ground = Ground();

    add(nama);
    add(leftPole);
    add(rightPole);
    add(track);
    add(ground);
  }

  PositionComponent itemOfTrackItem(TrackItem trackItem) {
    switch (trackItem.itemCode) {
      case ItemCode.book:
        return ItemBook();
      default:
        throw Exception('不正なアイテムコードです');
    }
  }

  void dropItem(TrackItem trackItem) {
    final item = itemOfTrackItem(trackItem);
    item.anchor = Anchor.center;
    switch (trackItem.playPosition) {
      case PlayPosition.leftPole:
        item.position.x = size.x / 2 - 200;
        item.position.y = size.y / 2 - 400;
        break;
      case PlayPosition.rightPole:
        item.position.x = size.x / 2 + 200;
        item.position.y = size.y / 2 - 400;
        break;
      default:
        throw Exception('不正なプレイポジションです');
    }
    add(item);
  }

  @override
  void onGameResize(Vector2 canvasSize) {
    super.onGameResize(canvasSize);
  }

  @override
  void render(Canvas canvas) {
    final rect = Rect.fromLTWH(0.0, 0.0, canvasSize.x, canvasSize.y);
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

    switch (phase) {
      case Phase.tapToStart:
        // ゲームを開始
        phase = Phase.playing;
        break;
      case Phase.playing:
        // ジャンプ
        nama.jump();
        break;
      case Phase.result:
        break;
      default:
        throw Exception('不正なフェーズです');
    }
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
