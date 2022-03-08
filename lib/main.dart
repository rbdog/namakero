import 'package:flame/components.dart';
import 'package:flame/game.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'package:namakero/namakero_game.dart';

main() {
  final game = NamakeroGame();
  final gameWidget = GameWidget(game: game);
  final center = Center(child: gameWidget);
  const appBarText = Text('ナマケロ!');
  final appBar = AppBar(title: appBarText);
  final scaffold = Scaffold(
    appBar: appBar,
    body: center,
  );
  final app = MaterialApp(home: scaffold);
  runApp(app);
}
