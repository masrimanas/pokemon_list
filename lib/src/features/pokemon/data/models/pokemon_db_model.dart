// ignore_for_file: public_member_api_docs, sort_constructors_first, lines_longer_than_80_chars
import 'package:objectbox/objectbox.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';

@Entity()
class PokemonDbModel {
  int id = 0;
  @Index()
  int uid;
  String name;
  String url;
  String imageUrl;

  PokemonDbModel({
    required this.uid,
    required this.name,
    required this.url,
    required this.imageUrl,
  });

  PokemonModel toModel() => PokemonModel(
        id: id,
        name: name,
        url: url,
      );

  Pokemon toEntity() => Pokemon(
        id: id,
        name: name,
        url: url,
      );

  @override
  String toString() {
    return 'PokemonDbModel(id: $id, uid: $uid, name: $name, url: $url, imageUrl: $imageUrl)';
  }
}
