import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/services/api_service.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'package:two_dots_short_way_app/models/path_task_model.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    super.key,
    required this._taskFeature,
    required this.url
  });

  final  List<PathTask> _taskFeature;
   final Uri url;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState(url: url, taskFeature: _taskFeature);
}

class _ProcessScreenState extends State<ProcessScreen> {

  _ProcessScreenState({
    required this.url,
    required this._taskFeature
  });

  late final List<PathTask> _taskFeature;
  late final Uri url;

  void initState() {
    super.initState();
    // _taskFeature = ApiService().fetchTasks(widget.apiUri);
}
  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Process screen',
      body:  Text('$url'),
    );
  }
}