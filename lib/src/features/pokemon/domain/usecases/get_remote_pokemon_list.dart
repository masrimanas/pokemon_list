import 'package:pokemon_list/src/common/classes/usecase.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class GetRemotePokemonList
    implements UseCase<Result<List<Pokemon>, Exception>, GetPokemonListParams> {
  const GetRemotePokemonList({required PokemonRepository repository})
      : _repository = repository;

  final PokemonRepository _repository;

  @override
  Future<Result<List<Pokemon>, Exception>> call({
    required GetPokemonListParams params,
  }) async {
    return _repository.getRemotePokemonList(
      offset: params.offset,
      limit: params.limit,
    );
  }
}
