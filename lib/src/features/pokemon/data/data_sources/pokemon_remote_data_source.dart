import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class PokemonRemoteDataSource {
  const PokemonRemoteDataSource({required HttpClient client})
      : _client = client;
  final HttpClient _client;

  Future<List<PokemonModel>> getPokemonList({
    required int offset,
    required int limit,
  }) async {
    final response = await _client.call<dynamic>(
      url: '/pokemon',
      requestType: RequestType.GET,
      queryParameters: <String, dynamic>{
        'offset': offset,
        'limit': limit,
      },
    );

    return switch (response) {
      ResponseSuccess(response: final value) =>
        // ignore: avoid_dynamic_calls
        (value['results'] as List<dynamic>)
            .map((e) => PokemonModel.fromJson(e as Map<String, dynamic>))
            .toList(),
      ResponseFailure(exception: final error) => throw error,
      _ => throw Exception('Unknown error occured!'),
    };
  }
}
