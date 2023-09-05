import 'package:bloc/bloc.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class AddToFavoritesCubit extends Cubit<ActionStatus> {
  AddToFavoritesCubit({
    required SavePokemon savePokemon,
  })  : _savePokemon = savePokemon,
        super(ActionStatus.initial);

  final SavePokemon _savePokemon;

  void addPokemonToFavorites(Pokemon newPokemon) {
    emit(ActionStatus.success);
    _savePokemon.call(newPokemon);
    emit(ActionStatus.initial);
  }
}
