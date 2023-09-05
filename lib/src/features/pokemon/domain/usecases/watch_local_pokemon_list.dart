import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class WatchLocalPokemonList {
  const WatchLocalPokemonList({required PokemonRepository repository})
      : _repository = repository;

  final PokemonRepository _repository;

  Stream<List<Pokemon>> call() {
    return _repository.watchLocalPokemonList();
  }
}
