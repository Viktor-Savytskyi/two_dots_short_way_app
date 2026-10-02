import 'package:flutter_test/flutter_test.dart';
import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';

void main() {
  test('equatable', () {
    expect(GridPoint(x: 1, y: 1) == GridPoint(x: 1, y: 1), isTrue);
  });

  test('Not equatable', () {
    expect(
        GridPoint(x: 0, y: 1) == GridPoint(x: 1, y: 1)
        || GridPoint(x: 1, y: 0) == GridPoint(x: 1, y: 1)
        || GridPoint(x: 1, y: 0) == GridPoint(x: 0, y: 1)
        || GridPoint(x: 0, y: 1) == GridPoint(x: 1, y: 0),
        isFalse
    );
  });

  test('neighbors count', ()  {
    GridPoint point = GridPoint(x: 1, y: 1);
    List<GridPoint> neighbors = point.neighbors();
    expect(neighbors.length == 8, isTrue);
  });


  test('is available point', () {
    final field = [".X.", ".X.", "..."];
    final startPoint = GridPoint(x: 0,  y: 0);
    final endPoint = GridPoint(x: 2,  y: 2);
    final unavailablePoint = GridPoint(x: 1,  y: 0);
    final pathTask = PathTask(id: '1', field: field, start: startPoint, end: endPoint);

    expect(pathTask.isAvailable(endPoint), isTrue);
    expect(pathTask.isAvailable(startPoint), isTrue);
    expect(pathTask.isAvailable(unavailablePoint), isFalse);

  });
}