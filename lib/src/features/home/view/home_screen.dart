// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:pokemon_list/injection.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/common/widgets/widgets.dart';
import 'package:pokemon_list/src/features/home/home.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/l10n/l10n.dart';
import 'package:pokemon_list/src/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: Text(l10n.home),
      ),
      body: BlocBuilder<PokemonListCubit, PokemonListState>(
        builder: (context, state) {
          return state.maybeMap(
            loading: (_) => CustomLoadingWidget(
              child: _PokemonGrid(pokemonList: _dummyPokemonList),
            ),
            success: (state) => _PokemonGrid(pokemonList: state.data),
            error: (state) => CustomErrorWidget(message: state.errorMessage),
            orElse: () => CustomErrorWidget(message: l10n.errorUnkownText),
          );
        },
      ),
    );
  }
}

final _dummyPokemonList = List.generate(
  20,
  (index) => Pokemon(
    name: 'Pokemon $index',
    url: 'https://pokeapi.co/api/v2/pokemon/$index/',
  ),
);

class _PokemonGrid extends StatefulWidget {
  const _PokemonGrid({
    required this.pokemonList,
  });

  final List<Pokemon> pokemonList;

  @override
  State<_PokemonGrid> createState() => _PokemonGridState();
}

class _PokemonGridState extends State<_PokemonGrid> {
  late final _cubit = sl<PokemonListCubit>();
  List<Pokemon> data = <Pokemon>[];
  int itemLength = 0;

  final PagingController<int, Pokemon> _pagingController =
      PagingController(firstPageKey: 0);

  Future<void> _fetchPage(int pageKey) async {
    await _cubit.fetchPokemonList(offset: pageKey * 20);
    _cubit.state.maybeMap(
      success: (value) {
        final isLastPage = value.data.length < 20;
        if (isLastPage) {
          _pagingController.appendLastPage(value.data);
        } else {
          final nextPageKey = pageKey + 1;
          _pagingController.appendPage(value.data, nextPageKey);
        }
        setState(() {
          itemLength = _pagingController.itemList!.length;
        });
      },
      error: (e) => _pagingController.error = e.errorMessage,
      orElse: () => logger('Unknown error occured'),
    );
  }

  @override
  void initState() {
    super.initState();
    _pagingController.addPageRequestListener(_fetchPage);
  }

  @override
  void dispose() {
    _cubit.close();
    _pagingController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return BlocListener<AddToFavoritesCubit, ActionStatus>(
      listener: (context, state) async {
        if (state == ActionStatus.success) {
          return showToast(
            context,
            l10n.addedToFavoriteText,
          );
        }
      },
      child: PagedGridView<int, Pokemon>(
        pagingController: _pagingController,
        gridDelegate: SliverQuiltedGridDelegate(
          crossAxisCount: 2,
          mainAxisSpacing: 18,
          crossAxisSpacing: 28,
          repeatPattern: QuiltedGridRepeatPattern.inverted,
          pattern: [
            for (int i = 0; i < itemLength; i++) const QuiltedGridTile(1, 1),
            const QuiltedGridTile(1, 2),
          ],
        ),
        builderDelegate: PagedChildBuilderDelegate<Pokemon>(
          newPageErrorIndicatorBuilder: (_) => CustomErrorWidget(
            message: context.l10n.errorLoadingDataText,
            onRetry: _pagingController.retryLastFailedRequest,
          ),
          firstPageProgressIndicatorBuilder: (context) => GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              mainAxisSpacing: 18,
              crossAxisSpacing: 28,
              childAspectRatio: 9 / 10,
            ),
            itemCount: _dummyPokemonList.length,
            itemBuilder: (context, index) {
              final item = _dummyPokemonList[index];
              return Column(
                children: [
                  CachedNetworkImage(
                    imageUrl: item.imageUrl,
                    placeholder: (_, __) => Skeletonizer(
                      containersColor:
                          context.colors.backgroundColor?.withOpacity(.5),
                      child: Image.asset(
                        Assets.images.dummy.path,
                        width: 100,
                        height: 100,
                      ),
                    ),
                    errorWidget: (_, __, ___) =>
                        Text(context.l10n.errorLoadingDataText),
                  ),
                  Text(item.name),
                ],
              );
            },
          ),
          itemBuilder: (context, item, index) {
            return PokemonCard(
              pokemon: item,
              iconPath: Assets.icons.heart.path,
              onPressed: () => context
                  .read<AddToFavoritesCubit>()
                  .addPokemonToFavorites(item),
            );
          },
        ),
      ),
    );
  }
}
