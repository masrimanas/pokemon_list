enum ButtonType { primary, secondary }

enum ActionStatus { initial, loading, success, error }

enum Language {
  en(code: 'en', name: 'English'),
  id(code: 'id', name: 'Bahasa Indonesia');

  const Language({
    required this.code,
    required this.name,
  });
  final String code;
  final String name;
}
