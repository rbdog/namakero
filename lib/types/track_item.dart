import 'package:namakero/types/item_code.dart';
import 'package:namakero/types/play_position.dart';

class TrackItem {
  final double appearSec;
  final ItemCode itemCode;
  final PlayPosition playPosition;
  TrackItem({
    required this.appearSec,
    required this.itemCode,
    required this.playPosition,
  });
}
