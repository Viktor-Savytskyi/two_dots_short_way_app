class GridPoint {
  const GridPoint({
    required this.x,
    required this.y
  });

  final int x;
  final int y;

  factory GridPoint.fromJson(Map<String, dynamic> json) {
    return GridPoint(
      x: (json['x'] as num).toInt(),
      y: (json['y'] as num).toInt(),
    );
  }
}

