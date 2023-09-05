import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

part 'favorite_search_event.dart';

class FavoriteSearchBloc extends Bloc<FavoriteSearchEvent, List<Pokemon>> {
  FavoriteSearchBloc({required SearchPokemon searchPokemon})
      : _searchPokemon = searchPokemon,
        super(<Pokemon>[]) {
    on<FavoriteSearchCalled>(_onSearch);
  }

  final SearchPokemon _searchPokemon;

  FutureOr<void> _onSearch(
    FavoriteSearchCalled event,
    Emitter<List<Pokemon>> emit,
  ) async {
    await for (final pokemons in _searchPokemon(event.keyword)) {
      emit(pokemons);
    }
  }
}
