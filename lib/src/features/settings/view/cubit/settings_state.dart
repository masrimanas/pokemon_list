// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';

import 'package:equatable/equatable.dart';
import 'package:pokemon_list/src/common/enums.dart';

class SettingsState extends Equatable {
  final bool isDarkModeEnabled;
  final Language languageCode;

  const SettingsState({
    this.isDarkModeEnabled = false,
    this.languageCode = Language.en,
  });

  factory SettingsState.initial() {
    return const SettingsState();
  }

  @override
  List<Object?> get props => [isDarkModeEnabled, languageCode];

  SettingsState copyWith({
    bool? isDarkModeEnabled,
    Language? languageCode,
  }) {
    return SettingsState(
      isDarkModeEnabled: isDarkModeEnabled ?? this.isDarkModeEnabled,
      languageCode: languageCode ?? this.languageCode,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'isDarkModeEnabled': isDarkModeEnabled,
      'languageCode': languageCode.code,
    };
  }

  factory SettingsState.fromMap(Map<String, dynamic> map) {
    return SettingsState(
      isDarkModeEnabled: map['isDarkModeEnabled'] as bool,
      languageCode: Language.values
          .firstWhere((e) => e.code == map['languageCode'] as String),
    );
  }

  String toJson() => json.encode(toMap());

  factory SettingsState.fromJson(String source) =>
      SettingsState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  bool get stringify => true;
}
