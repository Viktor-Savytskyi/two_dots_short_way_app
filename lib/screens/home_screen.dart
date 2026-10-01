import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/path_task_model.dart';
import 'package:two_dots_short_way_app/services/api_service.dart';
import 'package:two_dots_short_way_app/utils/url_validator.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import 'process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key, required this.title});

  final String title;

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final _urlController = TextEditingController();
  final _apiService = ApiService();
  bool _isLoading = false;

  @override
  void dispose() {
    _urlController.dispose();
    super.dispose();
  }

  void _openDetails({ required List<PathTask> tasks, required Uri url }) {
    Navigator.of(context).push(
        MaterialPageRoute(
            builder: (context) => ProcessScreen(url: url, taskFeature: tasks,)
        )
    );
  }

  Future<void> _onContinuePressed() async {
    final input = _urlController.text.trim();

    if (!isValidUrl(input)) {
      _showAlert('Invalid URL');
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiUri = Uri.parse(input);
      final tasks = await _apiService.fetchTasks(apiUri);
      for (var item in tasks)  {
        print('===== Task id: ${item.id}');
        print('task field: ${item.field}');
        print('task start: x == ${item.start.x}, y == ${item.start.y}');
        print('task end: x == ${item.end.x}, y == ${item.end.y}');
        print('===== ');
      }

      _openDetails(tasks: tasks, url: apiUri);
    } catch (error) {
      if (!mounted) return;
      _showAlert('Request failed $error'
           );
    } finally {
      if (mounted) setState(() => _isLoading = false);
    }
  }

  void _showAlert(String message) {
    showDialog(context: context, builder: (context) => AlertDialog(
      title: Text(message),
      content: Text("Please enter vallid url. example https://example.com"),
      actions: [
        TextButton(onPressed: () => Navigator.of(context).pop(),
            child: const Text('OK'))
      ],
    )
    );
  }

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: widget.title,
        body: Stack(
          children: [
            Column(
              crossAxisAlignment: .start,
              children: [
                Text('Set valid API base URL in order to continue'),
                SizedBox(height: 20),
                Row(
                  children: [
                    const Icon(Icons.swap_horiz, size: 20, color: Colors.grey),
                    SizedBox(width: 25),
                    Expanded(child: TextField(
                      controller: _urlController,
                      keyboardType: .url,
                      autocorrect:  false,
                      decoration: const InputDecoration(
                          hintText: 'https://',
                          border: UnderlineInputBorder()
                      ),
                    ))
                  ],
                ),
                const Spacer(),
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
            ),
            if (_isLoading)
              const Center(child: CircularProgressIndicator()),
          ],
        )
    );
  }
}