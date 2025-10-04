import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AppLanguage {
  const AppLanguage({required this.code, required this.name, required this.sub});
  final String code; // e.g. en, hi
  final String name; // English
  final String sub; // Hi
}

final List<AppLanguage> kLanguages = <AppLanguage>[
  AppLanguage(code: 'en', name: 'English', sub: 'Hi'),
  AppLanguage(code: 'hi', name: 'Hindi', sub: 'नमस्ते'),
  AppLanguage(code: 'bn', name: 'Bengali', sub: 'ইউহালো'),
  AppLanguage(code: 'kn', name: 'Kannada', sub: 'ನಮಸ್ಕಾರ'),
  AppLanguage(code: 'pa', name: 'Punjabi', sub: 'ਸਤ ਸ੍ਰੀ ਅਕਾਲ'),
  AppLanguage(code: 'ta', name: 'Tamil', sub: 'வணக்கம்'),
  AppLanguage(code: 'te', name: 'Telugu', sub: 'హలో'),
  AppLanguage(code: 'fr', name: 'French', sub: 'Bonjour'),
  AppLanguage(code: 'es', name: 'Spanish', sub: 'Hola'),
];

final StateNotifierProvider<LanguageController, String?> languageControllerProvider =
    StateNotifierProvider<LanguageController, String?>((ref) => LanguageController());

class LanguageController extends StateNotifier<String?> {
  LanguageController() : super(null) {
    _load();
  }

  static const String _prefsKey = 'app_language';

  Future<void> _load() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    state = prefs.getString(_prefsKey);
  }

  Future<void> select(String code) async {
    state = code;
  }

  Future<void> persist() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    if (state != null) {
      await prefs.setString(_prefsKey, state!);
    }
  }
}


