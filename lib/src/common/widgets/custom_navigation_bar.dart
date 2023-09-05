// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/src/common/widgets/widgets.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class _CustomNavDestination {
  final dynamic icon;
  const _CustomNavDestination({
    required this.icon,
  });
}

final _navMenus = [
  _CustomNavDestination(icon: Assets.icons.home.path),
  _CustomNavDestination(icon: Assets.icons.heart.path),
  _CustomNavDestination(icon: Assets.icons.settings.path),
];

class CustomNavigationBar extends StatelessWidget {
  const CustomNavigationBar({
    this.navigationShell,
    super.key,
    this.height = 65,
  });

  final double height;
  final StatefulNavigationShell? navigationShell;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(bottom: 24, right: 32, left: 32),
      padding: const EdgeInsets.only(bottom: 6, right: 20, left: 20),
      width: double.infinity,
      height: height,
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(20)),
        border: Border.all(
          color: context.colors.accentColor!,
        ),
        color: context.colors.backgroundColor,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          for (int index = 0; index < _navMenus.length; index++)
            Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                CustomIconButton(
                  iconPadding: (top: 6, bottom: 0, right: 12, left: 12),
                  onPressed: () {
                    navigationShell?.goBranch(
                      index,
                      initialLocation: index == navigationShell?.currentIndex,
                    );
                  },
                  icon: _navMenus[index].icon,
                  iconColor: navigationShell?.currentIndex == index
                      ? context.colors.textColor
                      : context.colors.primaryColor,
                ),
              ],
            ),
        ],
      ),
    );
  }
}
