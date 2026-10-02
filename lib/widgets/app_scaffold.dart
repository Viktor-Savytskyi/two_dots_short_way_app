import 'package:flutter/material.dart';
import 'package:two_dots_short_way_app/widgets/loading_overlay.dart';

class AppScaffold extends StatelessWidget {
  const AppScaffold({
    super.key,
    required this.title,
    required this.body,
    this.padding = const EdgeInsets.all(20),
    this.isLoading = false,
  });

  final String title;
  final Widget body;
  final EdgeInsets padding;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Stack(
      fit: StackFit.expand,
      children: [
        Scaffold(
          appBar: AppBar(title: Text(title)),
          body: SafeArea(
            child: Padding(
              padding: padding,
              child: body,
            ),
          ),
        ),
        if (isLoading) const LoadingOverlay(),
      ],
    );
  }
}