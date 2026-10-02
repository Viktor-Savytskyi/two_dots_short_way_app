import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/models/network/path_task_model.dart';
import 'package:two_dots_short_way_app/services/api_service.dart';
import 'package:two_dots_short_way_app/utils/url_validator.dart';
import 'package:two_dots_short_way_app/widgets/app_scaffold.dart';
import '../utils/show_alert.dart';
import 'process_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

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
            builder: (context) => ProcessScreen(url: url, tasks: tasks,)
        )
    );
  }

  Future<void> _onContinuePressed() async {
    final input = _urlController.text.trim();

    if (!isValidUrl(input)) {
      showAlert(title: 'Invalid URL', message: 'Please enter valid url. example https://example.com', context: context);
      return;
    }

    setState(() => _isLoading = true);

    try {
      final apiUri = Uri.parse(input);
      final tasks = await _apiService.fetchTasks(apiUri);
      if (!mounted) return;
      _openDetails(tasks: tasks, url: apiUri);
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

  @override
  Widget build(BuildContext context) {
    return AppScaffold(
        title: 'Home screen',
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