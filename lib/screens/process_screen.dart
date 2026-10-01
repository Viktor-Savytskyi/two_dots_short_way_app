import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/screens/task_field_screen.dart';
import 'package:two_dots_short_way_app/services/api_service.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';

class ProcessScreen extends StatefulWidget {
  const ProcessScreen({
    super.key,
    required this._tasks,
    required this.url
  });

  final  List<PathTask> _tasks;
   final Uri url;

  @override
  State<ProcessScreen> createState() => _ProcessScreenState();
}

class _ProcessScreenState extends State<ProcessScreen> {

  final _apiService = ApiService();
  bool _isLoading = false;

  @override
  void initState() {
    super.initState();
    // _taskFeature = ApiService().fetchTasks(widget.apiUri);
}

void _onContinuePressed()  {

}

void _onItemPressed({required PathTask task})  {
  Navigator.of(context).push(
      MaterialPageRoute(
          builder: (context) => TaskFieldScreen(task: task,)
      )
  );
}

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
      title: 'Process screen',
      body:  Column(
        children: [
          Text('${widget.url}'),
          SizedBox(height: 40),
          Expanded(child: ListView.separated(
            itemCount: widget._tasks.length,
            separatorBuilder: (context, index) => const SizedBox(height: 10),
            itemBuilder: (context, index)  {
             final task = widget._tasks[index];
             return ListTile(
               tileColor: Colors.amber,
               title: Text(task.id),
               trailing: const Icon(Icons.chevron_right),
               onTap: () => _onItemPressed(task: task),
             );
            }
            )
          ),
          SizedBox(height: 40),
          SizedBox(
              width: .infinity,
              height: 48,
              child: FilledButton(onPressed:_isLoading ? null :  _onContinuePressed,
                style: FilledButton.styleFrom(
                  backgroundColor: Colors.blue,
                  foregroundColor: Colors.black,
                  side: BorderSide(color: Colors.blue.shade900, width: 1),
                  shape:  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                ),
                child: const Text('Start counting process'),
              )
          )
        ],
      ) ,
    );
  }
}