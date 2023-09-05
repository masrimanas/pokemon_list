import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class DeletePokemon {
  const DeletePokemon({required PokemonRepository repository})
      : _repository = repository;

  final PokemonRepository _repository;

  void call(int id) {
    _repository.deleteLocalPokemon(id);
  }
}
