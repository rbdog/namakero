import 'package:bug_slot/sprite_components/catch_frame.dart';
import 'package:bug_slot/sprite_components/slot_symbol.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;
import 'dart:math' as math;

double randomChargeTime() {
// 8-25の乱数を発生させます
  int min = 8;
  int max = 25;
  var random = math.Random();
  var r = min + random.nextInt(max - min);
  // 少数に直します 0.8-2.5
  var doubleR = r.toDouble() / 10.0;
  return doubleR;
}

class Reel extends PositionComponent {
  final double SYMBOL_SPEED = 200;
  final List<SlotSymbol> symbols = [];
  late CatchFrame catchFrame;

  // マイフレーム　カウントが減っていって ０になったら新しいシンボルを発射する
  double remaindChargeTime = randomChargeTime();

  @override
  Future<void> onLoad() async {
    super.onLoad();

    catchFrame = CatchFrame();
    add(catchFrame);
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);

    resizeCatchFrame();
    canvas.drawRect(
      Rect.fromLTWH(0, size.y - size.x, size.x, size.x),
      Paint()..color = Color.fromARGB(255, 255, 255, 255),
    );
  }

  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  resizeCatchFrame() {
    catchFrame.anchor = Anchor.bottomCenter;
    catchFrame.size = Vector2(size.x, size.x);
    catchFrame.position.x = size.x / 2;
    catchFrame.position.y = size.y;
  }

  @override
  void update(double dt) {
    super.update(dt);
    remaindChargeTime -= dt;
    if (remaindChargeTime <= 0) {
      launchNewSymbol('99');
      remaindChargeTime = randomChargeTime();
    }

    // このリール上の全てのシンボルに対して
    for (var symbol in symbols) {
      symbol.position.y = symbol.position.y + (dt * SYMBOL_SPEED);
      if (size.y < symbol.position.y) {
        // シンボルがリールを超えた時
        print('シンボルをキャッチできませんでした ID: ${symbol.id}');
        removeSymbol(symbol);
      }
    }
  }

  tryCatchSymbol() {
    // このリール上の全てのシンボルに対して
    for (var symbol in symbols) {
      // シンボルがキャッチフレームの中にいるかどうかを取得 絶対座標を渡すこと
      final canCatch = catchFrame.containsPoint(symbol.absolutePosition);
      if (canCatch) {
        // 中にいたときはキャッチ関数をコールする
        onCatchSymbol(symbol);
      } else {
        print('範囲外でした ${catchFrame.position} シンボル位置 ${symbol.position}');
      }
    }
  }

  // 新しいシンボルを追加する
  launchNewSymbol(String id) {
    final symbol = SlotSymbol(id);
    symbol.anchor = Anchor.center; // このコンポーネントは、自分の中心を基準に移動する
    symbol.size = Vector2(50, 50);
    symbol.position.x = size.x / 2;
    symbol.position.y = 0;
    symbols.add(symbol);
    add(symbol);
  }

  // シンボルを捕まえた時
  onCatchSymbol(SlotSymbol symbol) {
    print('シンボルを捕まえました ID: ${symbol.id}');
    removeSymbol(symbol);
    catchFrame.setSymbol(symbol);
  }

  // シンボルを削除する
  removeSymbol(SlotSymbol symbol) {
    symbols.remove(symbol);
    remove(symbol);
  }
}
