import 'package:bug_slot/sprite_components/slot_symbol.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// アニメーションなしの画像を表示する場合
class CatchFrame extends SpriteComponent {
  SlotSymbol? symbol;
  CatchFrame() : super.fromImage(Flame.images.fromCache('catch-frame.png'));

  //
  // 読み込み
  //
  @override
  Future<void> onLoad() async {
    super.onLoad();
  }

  @override
  void render(Canvas canvas) {
    super.render(canvas);
  }

  //
  // レンダリングの前に一度呼ばれる
  //
  @override
  void onGameResize(Vector2 gameSize) {
    super.onGameResize(gameSize);
  }

  setSymbol(SlotSymbol? symbol) {
    if (this.symbol != null) {
      remove(this.symbol!);
    }
    this.symbol = symbol;
    if (symbol != null) {
      add(symbol);
      symbol.position.x = size.x / 2;
      symbol.position.y = size.y / 2;
    }
  }
}
