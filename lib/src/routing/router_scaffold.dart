import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart' show StatefulNavigationShell;
import 'package:pokemon_list/src/common/widgets/widgets.dart';

class RouterScaffold extends StatelessWidget {
  const RouterScaffold({
    required this.navigationShell,
    Key? key,
  }) : super(key: key ?? const ValueKey<String>('MainRouterScaffold'));

  final StatefulNavigationShell navigationShell;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBody: true,
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.transparent,
      body: navigationShell,
      bottomNavigationBar: CustomNavigationBar(
        navigationShell: navigationShell,
      ),
    );
  }
}
