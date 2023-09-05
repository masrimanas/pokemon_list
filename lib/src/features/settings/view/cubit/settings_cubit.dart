import 'package:hydrated_bloc/hydrated_bloc.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/features/settings/settings.dart';

class SettingsCubit extends HydratedCubit<SettingsState> {
  SettingsCubit() : super(SettingsState.initial());

  void toggleTheme({required bool newValue}) {
    emit(state.copyWith(isDarkModeEnabled: newValue));
  }

  Future<void> toggleLanguage({required Language newValue}) async {
    emit(state.copyWith(languageCode: newValue));
  }

  @override
  SettingsState? fromJson(Map<String, dynamic> json) =>
      SettingsState.fromMap(json['settings'] as Map<String, dynamic>);

  @override
  Map<String, dynamic>? toJson(SettingsState state) =>
      {'settings': state.toMap()};
}
