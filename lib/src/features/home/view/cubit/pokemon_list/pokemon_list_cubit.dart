import 'package:bloc/bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';

part 'pokemon_list_cubit.freezed.dart';
part 'pokemon_list_state.dart';

class PokemonListCubit extends Cubit<PokemonListState> {
  PokemonListCubit({
    required GetRemotePokemonList getPokemonList,
  })  : _getPokemonList = getPokemonList,
        super(const PokemonListState.initial());

  final GetRemotePokemonList _getPokemonList;

  Future<void> fetchPokemonList({int offset = 20, int limit = 20}) async {
    emit(const PokemonListState.loading());
    final result = await _getPokemonList.call(
      params: (offset: offset, limit: 20),
    );
    switch (result) {
      case Success(value: final data):
        emit(PokemonListState.success(data));
      case Failure(exception: final e):
        emit(PokemonListState.error(e.toString()));
    }
  }
}
