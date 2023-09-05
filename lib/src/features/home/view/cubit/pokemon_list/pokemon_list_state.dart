// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'pokemon_list_cubit.dart';

@freezed
class PokemonListState with _$PokemonListState {
  const factory PokemonListState.initial() = _Initial;
  const factory PokemonListState.loading() = _Loading;
  const factory PokemonListState.success(List<Pokemon> data) = _Success;
  const factory PokemonListState.error(String errorMessage) = _Error;
}
