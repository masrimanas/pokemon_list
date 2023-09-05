import 'package:pokemon_list/objectbox.g.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class PokemonLocalDataSource {
  PokemonLocalDataSource({required Store db}) : _box = db.box<PokemonDbModel>();

  final Box<PokemonDbModel> _box;

  Stream<List<PokemonDbModel>> getPokemonByName(String keyword) {
    final query = _box
        .query(PokemonDbModel_.name.contains(keyword))
        .order(PokemonDbModel_.name);
    if (keyword.isEmpty) {
      return query.watch(triggerImmediately: true).map((event) => event.find());
    }
    return query.watch(triggerImmediately: true).map((event) => event.find());
  }

  Stream<List<PokemonDbModel>> watchPokemonList({bool isClosed = false}) {
    final query = _box.query().order(PokemonDbModel_.name);

    return query.watch(triggerImmediately: true).map((event) => event.find());
  }

  void savePokemon(PokemonModel newPokemon) {
    final query = _box
        .query(PokemonDbModel_.uid.equals(newPokemon.toEntity().uid))
        .build();

    final result = query.find();
    query.close();
    if (result.isNotEmpty) {
      return;
    }

    _box.put(newPokemon.toEntity().toDbModel());
  }

  void deletePokemon(int id) {
    _box.remove(id);
  }
}
