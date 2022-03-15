import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:namakero/layers/world_layer.dart';
import 'package:namakero/layers/ui_layer.dart';

main() {
  //URL取得
  String url = Uri.base.toString();
  //クエリパラメータ取得
  String? id = Uri.base.queryParameters["id"];
  debugPrint('URL: ${url} id: ${id}');
  final scaffold = MainWindow();
  final app = MaterialApp(home: scaffold);
  runApp(app);
}

class MainWindow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;

    if (size.height < 600) {
      final alertText = Text('画面サイズが小さすぎるためこのゲームを遊ぶことができません');
      final center = Center(child: alertText);
      final scaffold = Scaffold(body: center);
      return scaffold;
    }
    // game をスコープ外に保存
    final game = WorldLayer();
    // Layer 別Widgetにする
    final gameWidget = GameWidget(game: game);
    final center = Center(child: gameWidget);
    final uiLayer = UiLayer();
    final stack = Stack(
      children: [
        center,
        uiLayer,
      ],
    );
    final scaffold = Scaffold(body: stack);
    return scaffold;
  }
}
