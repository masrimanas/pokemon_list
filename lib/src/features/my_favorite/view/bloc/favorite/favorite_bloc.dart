import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

part 'favorite_event.dart';
part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  FavoriteBloc({required DeletePokemon deletePokemon})
      : _deletePokemon = deletePokemon,
        super(const FavoriteInitial()) {
    on<FavoriteDeleteCalled>(_onDelete);
  }

  final DeletePokemon _deletePokemon;

  FutureOr<void> _onDelete(
    FavoriteDeleteCalled event,
    Emitter<FavoriteState> emit,
  ) {
    emit(const FavoriteSuccess());
    _deletePokemon(event.pokemon.id ?? 10000);
    emit(const FavoriteInitial());
  }
}
