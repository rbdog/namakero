import 'package:bug_slot/sprite_components/bug_slot_game.dart';
import 'package:flame/components.dart';
import 'package:flame/flame.dart';
import 'package:flame/game.dart';
import 'package:flame/geometry.dart';
import 'package:flame/input.dart';
import 'package:flame/widgets.dart';
import 'package:flutter/material.dart';
import 'dart:ui' as ui;

main() {
  final game = BugSlotGame();
  final gameWidget = GameWidget(game: game);
  final center = Center(child: gameWidget);
  final scaffold = Scaffold(body: center, backgroundColor: Colors.black);
  final app = MaterialApp(title: 'Bug Slot', home: scaffold);
  runApp(app);
}
