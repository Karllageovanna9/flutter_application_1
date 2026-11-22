import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/firebase_service.dart';

class CadastroTarefaScreen extends StatefulWidget {
  final Tarefa? tarefa;

  const CadastroTarefaScreen({
    super.key,
    this.tarefa,
  });

  @override
  State<CadastroTarefaScreen> createState() =>
      _CadastroTarefaScreenState();
}

class _CadastroTarefaScreenState
    extends State<CadastroTarefaScreen> {
  final _formKey = GlobalKey<FormState>();
  final _tituloController = TextEditingController();
  final _descricaoController = TextEditingController();

  final FirebaseService _service = FirebaseService();

  DateTime _dataVencimento = DateTime.now();
  String _prioridade = 'Média';
  bool _carregando = false;

  bool get _editando => widget.tarefa != null;

  @override
  void initState() {
    super.initState();

    final tarefa = widget.tarefa;

    if (tarefa != null) {
      _tituloController.text = tarefa.titulo;
      _descricaoController.text = tarefa.descricao;
      _dataVencimento = tarefa.dataVencimento;
      _prioridade = tarefa.prioridade;
    }
  }

  Future<void> _selecionarData() async {
    final data = await showDatePicker(
      context: context,
      initialDate: _dataVencimento,
      firstDate: DateTime(2020),
      lastDate: DateTime(2100),
    );

    if (data != null) {
      setState(() {
        _dataVencimento = data;
      });
    }
  }

  Future<void> _salvar() async {
    if (!_formKey.currentState!.validate()) return;

    setState(() => _carregando = true);

    try {
      final tarefa = Tarefa(
        id: widget.tarefa?.id ?? '',
        titulo: _tituloController.text.trim(),
        descricao: _descricaoController.text.trim(),
        dataVencimento: _dataVencimento,
        prioridade: _prioridade,
        concluida: widget.tarefa?.concluida ?? false,
      );

      if (_editando) {
        await _service.atualizarTarefa(tarefa);
      } else {
        await _service.adicionarTarefa(tarefa);
      }

      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            _editando
                ? 'Tarefa atualizada!'
                : 'Tarefa cadastrada!',
          ),
        ),
      );

      Navigator.pop(context);
    } catch (erro) {
      if (!mounted) return;

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Erro ao salvar tarefa: $erro'),
        ),
      );
    } finally {
      if (mounted) {
        setState(() => _carregando = false);
      }
    }
  }

  @override
  void dispose() {
    _tituloController.dispose();
    _descricaoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          _editando ? 'Editar tarefa' : 'Nova tarefa',
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                controller: _tituloController,
                decoration: const InputDecoration(
                  labelText: 'Título',
                  prefixIcon: Icon(Icons.title),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe o título da tarefa.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _descricaoController,
                maxLines: 4,
                decoration: const InputDecoration(
                  labelText: 'Descrição',
                  alignLabelWithHint: true,
                  prefixIcon: Icon(Icons.description),
                ),
                validator: (valor) {
                  if (valor == null || valor.trim().isEmpty) {
                    return 'Informe a descrição.';
                  }

                  return null;
                },
              ),
              const SizedBox(height: 16),
              ListTile(
                contentPadding: EdgeInsets.zero,
                leading: const Icon(Icons.calendar_month),
                title: const Text('Data de vencimento'),
                subtitle: Text(
                  '${_dataVencimento.day}/'
                  '${_dataVencimento.month}/'
                  '${_dataVencimento.year}',
                ),
                trailing: const Icon(Icons.edit_calendar),
                onTap: _selecionarData,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<String>(
                initialValue: _prioridade,
                decoration: const InputDecoration(
                  labelText: 'Prioridade',
                  prefixIcon: Icon(Icons.flag),
                ),
                items: const [
                  DropdownMenuItem(
                    value: 'Baixa',
                    child: Text('Baixa'),
                  ),
                  DropdownMenuItem(
                    value: 'Média',
                    child: Text('Média'),
                  ),
                  DropdownMenuItem(
                    value: 'Alta',
                    child: Text('Alta'),
                  ),
                ],
                onChanged: (valor) {
                  if (valor != null) {
                    setState(() {
                      _prioridade = valor;
                    });
                  }
                },
              ),
              const SizedBox(height: 24),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton.icon(
                  onPressed: _carregando ? null : _salvar,
                  icon: const Icon(Icons.save),
                  label: Text(
                    _carregando
                        ? 'Salvando...'
                        : 'Salvar tarefa',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}