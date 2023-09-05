// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

class Pokemon extends Equatable {
  final int? id;
  final int uid;
  final String name;
  final String url;
  final String imageUrl;

  Pokemon({
    required this.name,
    required this.url,
    this.id,
  })  : uid = int.parse(
          url.split('/').firstWhere((value) => int.tryParse(value) != null),
        ),
        imageUrl =
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${url.split('/').firstWhere((value) => int.tryParse(value) != null)}.png';

  @override
  List<Object?> get props => [id, uid, name, url, imageUrl];

  Pokemon copyWith({
    int? id,
    String? name,
    String? url,
  }) {
    return Pokemon(
      id: id ?? this.id,
      name: name ?? this.name,
      url: url ?? this.url,
    );
  }

  PokemonModel toModel() {
    return PokemonModel(
      name: name,
      url: url,
    );
  }

  PokemonDbModel toDbModel() => PokemonDbModel(
        uid: int.parse(
          url.split('/').firstWhere((value) => int.tryParse(value) != null),
        ),
        name: name.toLowerCase(),
        url: url,
        imageUrl:
            'https://raw.githubusercontent.com/PokeAPI/sprites/master/sprites/pokemon/${url.split('/').firstWhere((value) => int.tryParse(value) != null)}.png',
      );

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'id': id,
      'name': name,
      'url': url,
      'image': imageUrl,
    };
  }

  factory Pokemon.fromMap(Map<String, dynamic> map) {
    return Pokemon(
      id: map['id'] as int?,
      name: map['name'] as String,
      url: map['url'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Pokemon.fromJson(String source) =>
      Pokemon.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
