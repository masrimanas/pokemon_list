import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/features/settings/view/cubit/cubit.dart';
import 'package:pokemon_list/src/l10n/l10n.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final l10n = context.l10n;
    return Scaffold(
      appBar: AppBar(
        title: Text(l10n.settings),
      ),
      body: BlocBuilder<SettingsCubit, SettingsState>(
        builder: (context, state) {
          return Column(
            children: [
              const SizedBox(height: 16),
              ListTile(
                title: Text(l10n.darkMode),
                trailing: Switch(
                  thumbColor:
                      MaterialStateProperty.all(context.colors.accentColor),
                  activeColor: context.colors.primaryColor,
                  inactiveTrackColor: context.colors.secondaryColor,
                  value: state.isDarkModeEnabled,
                  onChanged: (value) {
                    context.read<SettingsCubit>().toggleTheme(newValue: value);
                  },
                ),
              ),
              const Divider(),
              ListTile(
                onTap: () async => showCupertinoModalPopup<void>(
                  context: context,
                  builder: (BuildContext context) {
                    return Material(
                      borderRadius: const BorderRadius.only(
                        topLeft: Radius.circular(20),
                        topRight: Radius.circular(20),
                      ),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                          vertical: 16,
                        ),
                        width: double.infinity,
                        margin: EdgeInsets.only(
                          bottom: context.bottomBarHeight,
                        ),
                        decoration: BoxDecoration(
                          color: context.colors.backgroundColor,
                          borderRadius: const BorderRadius.only(
                            topLeft: Radius.circular(20),
                            topRight: Radius.circular(20),
                          ),
                        ),
                        child: BlocBuilder<SettingsCubit, SettingsState>(
                          builder: (context, state) {
                            return Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                for (final lang in Language.values)
                                  ListBody(
                                    children: [
                                      ListTile(
                                        onTap: () {
                                          context
                                              .read<SettingsCubit>()
                                              .toggleLanguage(newValue: lang);
                                          // ignore: use_build_context_synchronously
                                          context.pop();
                                        },
                                        title: Text(
                                          lang.name,
                                          textAlign: TextAlign.center,
                                        ),
                                      ),
                                      const Divider(),
                                    ],
                                  ),
                              ],
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
                title: Text(l10n.language),
                trailing: const Icon(Icons.arrow_forward_ios),
              ),
              const Divider(),
            ],
          );
        },
      ),
    );
  }
}
