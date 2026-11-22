import 'package:flutter/material.dart';

import '../services/preferences_service.dart';
import '../main.dart';

class ConfiguracoesScreen extends StatefulWidget {
  const ConfiguracoesScreen({super.key});

  @override
  State<ConfiguracoesScreen> createState() =>
      _ConfiguracoesScreenState();
}

class _ConfiguracoesScreenState
    extends State<ConfiguracoesScreen> {
  final PreferencesService _preferences =
      PreferencesService();

  bool _temaEscuro = false;

  @override
  void initState() {
    super.initState();
    _carregarPreferencia();
  }

  Future<void> _carregarPreferencia() async {
    final valor = await _preferences.carregarTemaEscuro();

    if (!mounted) return;

    setState(() {
      _temaEscuro = valor;
    });
  }

  Future<void> _alterarTema(bool valor) async {
    setState(() {
      _temaEscuro = valor;
    });

    temaAplicativo.value = valor
        ? ThemeMode.dark
        : ThemeMode.light;

    await _preferences.salvarTemaEscuro(valor);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Configurações'),
      ),
      body: ListView(
        children: [
          SwitchListTile(
            title: const Text('Tema escuro'),
            subtitle: const Text(
              'Ativar ou desativar o modo escuro',
            ),
            secondary: const Icon(Icons.dark_mode),
            value: _temaEscuro,
            onChanged: _alterarTema,
          ),
        ],
      ),
    );
  }
}