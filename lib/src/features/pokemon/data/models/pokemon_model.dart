import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

part 'pokemon_model.freezed.dart';
part 'pokemon_model.g.dart';

@freezed
class PokemonModel with _$PokemonModel {
  factory PokemonModel({
    int? id,
    String? name,
    String? url,
  }) = _PokemonModel;

  const PokemonModel._();

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  factory PokemonModel.fromEntity(Pokemon pokemon) => PokemonModel(
        id: pokemon.id,
        name: pokemon.name,
        url: pokemon.url,
      );

  Pokemon toEntity() => Pokemon(
        id: id ?? 10000,
        name: name ?? '',
        url: url ?? '',
      );
}
