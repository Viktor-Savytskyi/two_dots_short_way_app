import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/internal/path_result.dart';
import 'package:two_dots_short_way_app/screens/task_field_screen.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import '../models/network/path_task_model.dart';

class ResultsScreen extends StatelessWidget {
  const ResultsScreen({super.key, required this.tasks, required this.results});

  final  List<PathTask> tasks;
  final List<PathResult>? results;

  void _onItemPressed({required BuildContext context, required PathResult result}) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => TaskFieldScreen(result: result)
        )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Result list screen',
        padding: .zero,
        body:  Column(
            crossAxisAlignment: .center,
            children: [
              Expanded(child: ListView.separated(
                  itemCount: results?.length  ?? 0 ,
                  separatorBuilder: (context, index) => const Divider(
                      color:  Colors.black,
                    height: 1,
                    thickness: 1,
                  ),
                  itemBuilder: (context, index)  {
                    final result = results?[index]!;
                    return ListTile(
                      title: Text(result?.getPath() ?? "", textAlign: .center,),
                      onTap: () => _onItemPressed(context: context, result: result!),
                    );
                  }
              )
              ),
            ],
        )
    );
  }
}