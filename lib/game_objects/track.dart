import 'package:flame/components.dart';
import 'package:flame/effects.dart';
import 'package:flame/geometry.dart';
import 'package:flutter/material.dart';
import 'package:namakero/game_objects/item_book.dart';
import 'package:namakero/layers/world_layer.dart';
import 'package:namakero/types/item_code.dart';
import 'package:namakero/types/play_position.dart';
import 'package:namakero/types/track_item.dart';
import 'package:collection/collection.dart';

// 1 トラック
// 目に見えないオブジェクト
// 曲の中で アイテムを放出する
class Track extends Component {
  // まだ放出していないアイテムたち
  List<TrackItem> trackItems;

  void Function(TrackItem) onNewItem;
  // 経過時間
  double pastSec = 0;

  Track(this.trackItems, this.onNewItem);

  @override
  Future<void> onLoad() async {}

  @override
  void update(double dt) {
    if (isPlaying()) {
      // プレイ中のみ
      pastSec += dt;
      final nextItem = trackItems.firstOrNull;
      if (nextItem != null) {
        if (nextItem.appearSec < pastSec) {
          onNewItem(nextItem);
          trackItems.removeAt(0);
        }
      } else {
        debugPrint('全てドロップ完了しました');
        removeFromParent();
      }
    }
  }
}
