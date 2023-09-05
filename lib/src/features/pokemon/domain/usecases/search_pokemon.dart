import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class SearchPokemon {
  const SearchPokemon({required PokemonRepository repository})
      : _repository = repository;

  final PokemonRepository _repository;

  Stream<List<Pokemon>> call(String keyword) {
    return _repository.getLocalPokemonByName(keyword);
  }
}
