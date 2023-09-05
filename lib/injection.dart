import 'package:get_it/get_it.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/src/features/home/home.dart';
import 'package:pokemon_list/src/features/my_favorite/my_favorite.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/features/settings/settings.dart';
import 'package:pokemon_list/src/routing/routing.dart';
import 'package:pokemon_list/src/utils/utils.dart';

final sl = GetIt.instance;

Future<void> initializeInstances() async {
  sl
    ..registerLazySingleton<GoRouter>(() => goRouter)
    ..registerLazySingleton<HttpClient>(HttpClient.new)
    ..registerSingletonAsync<LocalDb>(() async => LocalDb.createStore())
    //** Pokemon **//
    ..registerLazySingleton<PokemonRemoteDataSource>(
      () => PokemonRemoteDataSource(client: sl<HttpClient>()),
    )
    ..registerLazySingleton<PokemonLocalDataSource>(
      () => PokemonLocalDataSource(db: sl<LocalDb>().store),
    )
    ..registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(
        localDataSource: sl<PokemonLocalDataSource>(),
        remoteDataSource: sl<PokemonRemoteDataSource>(),
      ),
    )
    ..registerFactory<GetRemotePokemonList>(
      () => GetRemotePokemonList(
        repository: sl<PokemonRepository>(),
      ),
    )
    ..registerFactory<WatchLocalPokemonList>(
      () => WatchLocalPokemonList(repository: sl()),
    )
    ..registerFactory<SavePokemon>(
      () => SavePokemon(
        repository: sl<PokemonRepository>(),
      ),
    )
    ..registerFactory<SearchPokemon>(
      () => SearchPokemon(
        repository: sl<PokemonRepository>(),
      ),
    )
    ..registerFactory<DeletePokemon>(
      () => DeletePokemon(
        repository: sl<PokemonRepository>(),
      ),
    )

    //** Home **//
    ..registerFactory<PokemonListCubit>(
      () => PokemonListCubit(
        getPokemonList: sl<GetRemotePokemonList>(),
      ),
    )
    ..registerFactory(
      () => AddToFavoritesCubit(
        savePokemon: sl<SavePokemon>(),
      ),
    )
    //** My Favorite **//
    ..registerFactory<FavoriteListCubit>(
      () => FavoriteListCubit(
        watchLocalPokemonList: sl<WatchLocalPokemonList>(),
      ),
    )
    ..registerFactory<FavoriteSearchBloc>(
      () => FavoriteSearchBloc(
        searchPokemon: sl<SearchPokemon>(),
      ),
    )
    ..registerFactory<FavoriteBloc>(
      () => FavoriteBloc(deletePokemon: sl()),
    )
    //** Settings **//
    ..registerFactory<SettingsCubit>(SettingsCubit.new);
}
