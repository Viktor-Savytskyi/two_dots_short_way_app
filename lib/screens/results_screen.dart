import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/internal/path_result.dart';
import 'package:two_dots_short_way_app/screens/task_field_screen.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({
    super.key,
    required this.results,
    required this.correctById,
  });

  final List<PathResult> results;
  final Map<String, bool> correctById;

  void _onItemPressed({required BuildContext context, required PathResult result}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => TaskFieldScreen(result: result),
      ),
    );
  }

  Widget? _errorIcon(String taskId) {
    if (correctById[taskId] == false) {
      return const Icon(Icons.cancel, color: Colors.red);
    }
    return null;
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Result list screen',
      padding: .zero,
      body: ListView.separated(
        itemCount: results.length,
        separatorBuilder: (context, index) => const Divider(
          color: Colors.black,
          height: 1,
          thickness: 1,
        ),
        itemBuilder: (context, index) {
          final result = results[index];
          return ListTile(
              title: Text(
                result.getPath() ?? 'No path found',
                textAlign: .center,
              ),
              trailing: _errorIcon(result.task.id),
                  onTap: () => _onItemPressed(context: context, result: result),
          );
        },
      ),
    );
  }
}