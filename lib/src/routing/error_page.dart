import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/src/routing/router.dart';
import 'package:pokemon_list/src/utils/extensions/extensions.dart';

class ErrorPage extends StatelessWidget {
  const ErrorPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Error Page'),
        leading: IconButton(
          onPressed: () => context.goNamed(HomeRoutes.home.name),
          icon: const Icon(Icons.home),
        ),
      ),
      body: Center(
        child: Text(
          'Page not found',
          style: context.textTheme.headlineMedium,
        ),
      ),
    );
  }
}
