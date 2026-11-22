import 'package:shared_preferences/shared_preferences.dart';

class PreferencesService {
  static const String _chaveTemaEscuro = 'tema_escuro';

  Future<bool> carregarTemaEscuro() async {
    final preferencias = await SharedPreferences.getInstance();

    return preferencias.getBool(_chaveTemaEscuro) ?? false;
  }

  Future<void> salvarTemaEscuro(bool temaEscuro) async {
    final preferencias = await SharedPreferences.getInstance();

    await preferencias.setBool(
      _chaveTemaEscuro,
      temaEscuro,
    );
  }
}