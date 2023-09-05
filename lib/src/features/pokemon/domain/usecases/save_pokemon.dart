import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class SavePokemon {
  const SavePokemon({required PokemonRepository repository})
      : _repository = repository;

  final PokemonRepository _repository;

  void call(Pokemon newPokemon) {
    _repository.saveLocalPokemon(newPokemon);
  }
}
