part of 'router.dart';

enum AuthRoutes {
  login(name: 'login', path: '/login');

  const AuthRoutes({required this.name, required this.path});

  final String name;
  final String path;
}

enum HomeRoutes {
  home(name: 'home', path: '/');

  const HomeRoutes({required this.name, required this.path});

  final String name;
  final String path;
}

enum MyFavoriteRoutes {
  favorite(name: 'custom', path: '/custom');

  const MyFavoriteRoutes({required this.name, required this.path});

  final String name;
  final String path;
}

enum SettingsRoutes {
  settings(name: 'settings', path: '/settings');

  const SettingsRoutes({required this.name, required this.path});

  final String name;
  final String path;
}
