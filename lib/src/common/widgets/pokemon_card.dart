// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_list/src/common/widgets/widgets.dart';
import 'package:pokemon_list/src/features/pokemon/pokemon.dart';
import 'package:pokemon_list/src/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class PokemonCard extends StatelessWidget {
  const PokemonCard({
    required this.pokemon,
    required this.iconPath,
    required this.onPressed,
    super.key,
  });

  final Pokemon pokemon;
  final String iconPath;
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: context.colors.accentColor?.withOpacity(.15),
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Align(
            alignment: Alignment.topRight,
            child: Padding(
              padding: const EdgeInsets.all(4),
              child: CustomIconButton(
                color: context.colors.primaryColor!,
                iconColor: context.colors.backgroundColor,
                shape: BoxShape.circle,
                size: const Size(24, 24),
                iconPadding: (top: 4, bottom: 4, right: 4, left: 4),
                icon: iconPath,
                onPressed: onPressed,
              ),
            ),
          ),
          Flexible(
            flex: 6,
            child: CachedNetworkImage(
              imageUrl: pokemon.imageUrl,
              placeholder: (_, __) => Skeletonizer(
                containersColor:
                    context.colors.backgroundColor?.withOpacity(.5),
                child: Image.asset(
                  Assets.images.dummy.path,
                  width: 100,
                  height: 100,
                ),
              ),
              errorWidget: (_, __, ___) => const Icon(Icons.error),
            ),
          ),
          Text(pokemon.name.capitalize),
          const Spacer(),
        ],
      ),
    );
  }
}
