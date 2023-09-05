import 'dart:async';

import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  const PokemonRepositoryImpl({
    required PokemonLocalDataSource localDataSource,
    required PokemonRemoteDataSource remoteDataSource,
  })  : _remoteDataSource = remoteDataSource,
        _localDataSource = localDataSource;

  final PokemonLocalDataSource _localDataSource;
  final PokemonRemoteDataSource _remoteDataSource;

  @override
  Future<Result<List<Pokemon>, Exception>> getRemotePokemonList({
    required int offset,
    required int limit,
  }) async {
    try {
      final result = await _remoteDataSource.getPokemonList(
        offset: offset,
        limit: limit,
      );
      return switch (result.isNotEmpty) {
        true => Success(result.map((e) => e.toEntity()).toList()),
        false => Failure(Exception('Unknown error occured!')),
      };
    } on Exception catch (e) {
      return Failure(e);
    }
  }

  @override
  void deleteLocalPokemon(int id) {
    _localDataSource.deletePokemon(id);
  }

  @override
  Stream<List<Pokemon>> getLocalPokemonByName(String keyword) {
    return _localDataSource
        .getPokemonByName(keyword)
        .mapList((e) => e.toEntity());
  }

  @override
  Stream<List<Pokemon>> watchLocalPokemonList() {
    return _localDataSource.watchPokemonList().mapList((e) => e.toEntity());
  }

  @override
  void saveLocalPokemon(Pokemon newPokemon) {
    _localDataSource.savePokemon(newPokemon.toModel());
  }
}
