// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/injection.dart';
import 'package:pokemon_list/src/common/widgets/widgets.dart';
import 'package:pokemon_list/src/features/my_favorite/my_favorite.dart';
import 'package:pokemon_list/src/features/pokemon/domain/entities/pokemon.dart';
import 'package:pokemon_list/src/l10n/l10n.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class MyFavoriteScreen extends HookWidget {
  const MyFavoriteScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final keyword = useState('');
    final stream = useStream(sl<FavoriteListCubit>().stream);
    final l10n = context.l10n;
    return Scaffold(
      extendBody: true,
      appBar: AppBar(
        title: CustomSearchField(
          onChanged: (kw) {
            context.read<FavoriteSearchBloc>().add(
                  FavoriteSearchCalled(kw),
                );
            keyword.value = kw;
          },
        ),
      ),
      body: SafeArea(
        child: BlocListener<FavoriteBloc, FavoriteState>(
          listener: (context, state) async {
            if (state == const FavoriteSuccess()) {
              return showToast(
                context,
                l10n.deletedPokemonText,
              );
            }
          },
          child: Builder(
            builder: (context) {
              final searchValue = context.select(
                (FavoriteSearchBloc bloc) => bloc.state,
              );
              return switch (stream.data?.isNotEmpty) {
                true => GridView.builder(
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      mainAxisSpacing: 18,
                      crossAxisSpacing: 28,
                      childAspectRatio: 9 / 10,
                    ),
                    itemCount: keyword.value.isEmpty
                        ? stream.data!.length
                        : searchValue.length,
                    itemBuilder: (context, index) {
                      final pokemon = keyword.value.isEmpty
                          ? stream.data![index]
                          : searchValue[index];
                      return PokemonCard(
                        iconPath: Assets.icons.delete.path,
                        pokemon: pokemon,
                        onPressed: () async {
                          await _showDialog(
                            context,
                            pokemon: pokemon,
                            onCancel: () => context.pop(),
                            onConfirm: () {
                              context
                                ..pop()
                                ..read<FavoriteBloc>().add(
                                  FavoriteDeleteCalled(pokemon),
                                );
                            },
                          );
                        },
                      );
                    },
                  ),
                _ => Padding(
                    padding: const EdgeInsets.only(top: 100),
                    child: Center(
                      child: Text(l10n.pokemonNotFound),
                    ),
                  ),
              };
            },
          ),
        ),
      ),
    );
  }

  Future<void> _showDialog(
    BuildContext context, {
    required Pokemon pokemon,
    required VoidCallback onConfirm,
    required VoidCallback onCancel,
  }) {
    return showGeneralDialog<void>(
      useRootNavigator: false,
      context: context,
      pageBuilder: (
        context,
        animation,
        secondaryAnimation,
      ) {
        final l10n = context.l10n;
        return CustomDialog(
          text: l10n.deleteConfirmationText,
          path: Assets.lottie.deleteFiles.path,
          onConfirmText: l10n.yes,
          onCancelText: l10n.cancel,
          onConfirm: onConfirm,
          onCancel: onCancel,
        );
      },
    );
  }
}
