import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

// ウィジェットとして利用する場合
class MajoWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: _loadAnimation(),
      builder:
          (BuildContext context, AsyncSnapshot<SpriteAnimation> animation) {
        if (animation.hasData) {
          final widget = SpriteAnimationWidget(
            animation: animation.data!,
            playing: true,
            anchor: Anchor.center,
          );
          // 指定しないと大きさ0だから気をつけてね
          return SizedBox(
            width: 300,
            height: 500,
            child: widget,
          );
        } else {
          return Text("アニメーションを読み込み中です");
        }
      },
    );
  }
}

Future<SpriteAnimation> _loadAnimation() async {
  final animationData = SpriteAnimationData.sequenced(
    amount: 3, // 1枚の画像の中に 全部でいくつの画像があるか, あえて少なくすることで、いらない部分は使わなかったりできる
    amountPerRow: 3, // 横に向かってどのくらい使うか 折り返すまでの数 これ以上右側は捨てられると思えばわかりやすい
    textureSize: Vector2.all(32), // 画像のキャラサイズ
    stepTime: 0.5,
    loop: true,
  );

  final animation = await SpriteAnimation.load(
    'majo.png',
    animationData,
  );

  return animation;
}
