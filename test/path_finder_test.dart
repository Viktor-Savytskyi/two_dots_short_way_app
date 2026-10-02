import 'package:flutter_test/flutter_test.dart';
import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';
import 'package:two_dots_short_way_app/services/path_finder.dart';

void main() {
  test('Find path 1', () {
    final task = PathTask(
        id: '1',
        field: [".X.", ".X.", "..."],
        start: GridPoint(x: 1, y: 2),
        end: GridPoint(x: 2, y: 0)
    );
    List<GridPoint>? path = PathFinder().findPath(task: task);
    expect(path, [GridPoint(x: 1, y: 2), GridPoint(x: 2, y: 1), GridPoint(x: 2, y: 0)]);
  }
  );

  test('Find path 2', () {
    final task = PathTask(
        id: '2',
        field: ["....", "....", "....", "...."],
        start: GridPoint(x: 0, y: 0),
        end: GridPoint(x: 3, y: 3)
    );
    List<GridPoint>? path = PathFinder().findPath(task: task);
    expect(path, [GridPoint(x: 0, y: 0), GridPoint(x: 1, y: 1), GridPoint(x: 2, y: 2), GridPoint(x: 3, y: 3)]);
  }
  );

  test('Blocked path', () {
    final task = PathTask(
        id: '1',
        field: [".X.", ".XX", "..."],
        start: GridPoint(x: 1, y: 2),
        end: GridPoint(x: 2, y: 0)
    );
    List<GridPoint>? path = PathFinder().findPath(task: task);
    expect(path, isNull);
  }
  );
}