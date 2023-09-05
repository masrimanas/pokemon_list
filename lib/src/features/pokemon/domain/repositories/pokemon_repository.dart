import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';

abstract interface class PokemonRepository {
  Future<Result<List<Pokemon>, Exception>> getRemotePokemonList({
    required int offset,
    required int limit,
  });
  Stream<List<Pokemon>> getLocalPokemonByName(String keyword);
  Stream<List<Pokemon>> watchLocalPokemonList();
  void saveLocalPokemon(Pokemon newPokemon);
  void deleteLocalPokemon(int id);
}
