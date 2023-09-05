import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/injection.dart';
import 'package:pokemon_list/src/features/home/home.dart';
import 'package:pokemon_list/src/features/my_favorite/my_favorite.dart';
import 'package:pokemon_list/src/features/settings/settings.dart';
import 'package:pokemon_list/src/routing/error_page.dart';
import 'package:pokemon_list/src/routing/router_scaffold.dart';

part 'route_names.dart';

final GlobalKey<NavigatorState> _rootNavigatorKey =
    GlobalKey<NavigatorState>(debugLabel: 'root');
final GlobalKey<NavigatorState> _mainRouterKey =
    GlobalKey<NavigatorState>(debugLabel: 'mainRouter');

final goRouter = GoRouter(
  navigatorKey: _rootNavigatorKey,
  debugLogDiagnostics: true,
  initialLocation: '/',
  routes: [..._mainRouter],
  errorBuilder: (context, state) => const ErrorPage(),
);

final _mainRouter = [
  StatefulShellRoute.indexedStack(
    builder: (context, state, navigationShell) {
      return RouterScaffold(
        navigationShell: navigationShell,
      );
    },
    branches: [
      StatefulShellBranch(navigatorKey: _mainRouterKey, routes: _homeRouter),
      StatefulShellBranch(routes: _myFavoriteRouter),
      StatefulShellBranch(routes: _settingsRouter),
    ],
  ),
];

final _homeRouter = [
  GoRoute(
    path: HomeRoutes.home.path,
    name: HomeRoutes.home.name,
    builder: (context, state) {
      return MultiBlocProvider(
        providers: [
          BlocProvider<PokemonListCubit>(
            create: (_) => sl()..fetchPokemonList(),
          ),
          BlocProvider<AddToFavoritesCubit>(
            create: (_) => sl(),
          ),
        ],
        child: const HomeScreen(),
      );
    },
  ),
];

final _myFavoriteRouter = [
  GoRoute(
    path: MyFavoriteRoutes.favorite.path,
    name: MyFavoriteRoutes.favorite.name,
    builder: (context, state) => MultiBlocProvider(
      providers: [
        BlocProvider<FavoriteBloc>(
          create: (context) => sl(),
        ),
        BlocProvider<FavoriteListCubit>(
          create: (_) => sl(),
        ),
        BlocProvider<FavoriteSearchBloc>(
          create: (_) => sl(),
        ),
      ],
      child: const MyFavoriteScreen(),
    ),
  ),
];

final _settingsRouter = [
  GoRoute(
    path: SettingsRoutes.settings.path,
    name: SettingsRoutes.settings.name,
    builder: (context, state) => const SettingsScreen(),
  ),
];
