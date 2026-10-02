import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:two_dots_short_way_app/screens/results_screen.dart';
import 'package:two_dots_short_way_app/services/api_service.dart';
import 'package:two_dots_short_way_app/services/path_finder.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';
import 'package:two_dots_short_way_app/models/internal/path_result.dart';
import 'package:two_dots_short_way_app/models/network/grid_point_model.dart';

import '../utils/show_alert.dart';


List<GridPoint>? _solveTask(PathTask task) {
  return const PathFinder().findPath(task: task);
}

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    super.key,
    required this.tasks,
    required this.url
  });

  final  List<PathTask> tasks;
  final Uri url;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {
  final _apiService = ApiService();
  final List<PathResult> _results = [];
  bool _isLoading = false;
  double _progress = 0;
  bool get _isFinished => _results.length == widget.tasks.length;

  @override
  void initState() {
    super.initState();
    _calculate();
  }

  Future<void> _calculate() async {
    final tasks = widget.tasks;
    var doneWork = 0;
    var totalWork = 0;

    for (final task in tasks) {
      totalWork += task.size * task.size;
    }

    for (final task in tasks) {
      final steps = await compute(_solveTask, task);
      if (!mounted) return;

      doneWork = doneWork + task.size * task.size;

      setState(() {
        _results.add(PathResult(task: task, steps: steps));
        _progress = doneWork / totalWork;
      });
    }
  }

  Future<void> _onContinuePressed()  async {
    setState(() => _isLoading = true);
    try {
      final checks = await _apiService.sendResults(widget.url, _results);
      if (!mounted) return;

      final correctById = <String, bool>{};
      for (final check in checks) {
        correctById[check.id] = check.correct;
      }

      _navigateToResultsScreen(correctById: correctById);
    } catch (error) {
      if (!mounted) return;
      showAlert(
          title: 'Error',
          message: 'Request failed $error',
          context: context
      );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _navigateToResultsScreen({required Map<String, bool> correctById}) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => ResultsScreen(
          results: _results,
          correctById: correctById,
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Process screen',
        isLoading:  _isLoading,
        body:
        Stack(
            fit: .expand,
            children: [
              Column(
                children: [
                  const Spacer(),
                  SizedBox(
                    height: 48,
                    child: Text(
                      _isFinished
                          ? 'All calculations has finished, you can send your results to server'
                          : 'Calculating shortest paths, please wait...',
                      textAlign: TextAlign.center,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    '${(_progress * 100).round()}%',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(height: 16),
                  SizedBox(
                    width: 100,
                    height: 100,
                    child: CircularProgressIndicator(value: _progress, strokeWidth: 6, color: Colors.blue.shade900,),
                  ),
                  const Spacer(),
                  Visibility(
                      visible: _isFinished,
                      maintainSize: true,
                      maintainAnimation: true,
                      maintainState: true,
                      child: SizedBox(
                        width: double.infinity,
                        height: 48,
                        child: FilledButton(
                          onPressed: _isLoading ? null : _onContinuePressed,
                          style: FilledButton.styleFrom(
                            backgroundColor: Colors.blue,
                            foregroundColor: Colors.black,
                            side: BorderSide(color: Colors.blue.shade600, width: 1),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(15),
                            ),
                          ),
                          child: const Text('Send results to server'),
                        ),
                      )
                  )
                ],
              ),
            ]
        )
    );
  }
}