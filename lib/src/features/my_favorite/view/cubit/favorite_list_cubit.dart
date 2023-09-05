import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class FavoriteListCubit extends Cubit<List<Pokemon>> {
  FavoriteListCubit({
    required WatchLocalPokemonList watchLocalPokemonList,
  }) : super(<Pokemon>[]) {
    _subscription = watchLocalPokemonList().listen(emit);
  }

  late StreamSubscription<List<Pokemon>> _subscription;

  @override
  Future<void> close() async {
    await _subscription.cancel();
    return super.close();
  }
}
