import 'package:equatable/equatable.dart';

class GridPoint extends Equatable {
  const GridPoint({
    required this.x,
    required this.y
  });

  final int x;
  final int y;

  @override
  List<Object> get props => [x, y];

  factory GridPoint.fromJson(Map<String, dynamic> json) {
    return GridPoint(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );
  }

  List<GridPoint>neighbors() {
    return [
      _move(dx: -1, dy:  - 1),  // ↖
      _move(dx: 0, dy:  - 1),  // ↑
      _move(dx: 1, dy:  - 1),  // ↗
      _move(dx: -1, dy:  0), // ←
      _move(dx: 1, dy:  0),  // →
      _move(dx: -1, dy:  1), // ↙
      _move(dx: 0, dy:  1),  // ↓
      _move(dx: 1, dy:  1),  // ↘
    ];
  }

  GridPoint _move({required int dx, required int dy }) {
    return GridPoint(x:  x + dx, y: y + dy);
  }
}

