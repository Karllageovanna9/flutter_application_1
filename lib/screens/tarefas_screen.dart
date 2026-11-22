import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/firebase_service.dart';
import 'cadastro_tarefa_screen.dart';

class TarefasScreen extends StatelessWidget {
  const TarefasScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final service = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Minhas tarefas'),
      ),
      body: StreamBuilder<List<Tarefa>>(
        stream: service.ouvirTarefas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar tarefas.'),
            );
          }

          if (!snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tarefas = snapshot.data!;

          if (tarefas.isEmpty) {
            return const Center(
              child: Text('Você ainda não tem tarefas.'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(12),
            itemCount: tarefas.length,
            itemBuilder: (context, index) {
              final tarefa = tarefas[index];

              return Card(
                child: ListTile(
                  leading: Checkbox(
                    value: tarefa.concluida,
                    onChanged: (_) {
                      service.alterarStatus(tarefa);
                    },
                  ),
                  title: Text(
                    tarefa.titulo,
                    style: TextStyle(
                      decoration: tarefa.concluida
                          ? TextDecoration.lineThrough
                          : TextDecoration.none,
                    ),
                  ),
                  subtitle: Text(
                    '${tarefa.prioridade} • '
                    '${tarefa.dataVencimento.day}/'
                    '${tarefa.dataVencimento.month}/'
                    '${tarefa.dataVencimento.year}',
                  ),
                  onTap: () {
                    _mostrarDetalhes(context, tarefa);
                  },
                  trailing: PopupMenuButton<String>(
                    onSelected: (opcao) async {
                      if (opcao == 'editar') {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (_) =>
                                CadastroTarefaScreen(
                              tarefa: tarefa,
                            ),
                          ),
                        );
                      } else if (opcao == 'excluir') {
                        final confirmar =
                            await showDialog<bool>(
                          context: context,
                          builder: (context) => AlertDialog(
                            title: const Text('Excluir tarefa'),
                            content: const Text(
                              'Deseja realmente excluir esta tarefa?',
                            ),
                            actions: [
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, false),
                                child: const Text('Cancelar'),
                              ),
                              TextButton(
                                onPressed: () =>
                                    Navigator.pop(context, true),
                                child: const Text('Excluir'),
                              ),
                            ],
                          ),
                        );

                        if (confirmar == true) {
                          await service.excluirTarefa(tarefa.id);
                        }
                      }
                    },
                    itemBuilder: (_) => const [
                      PopupMenuItem(
                        value: 'editar',
                        child: Text('Editar'),
                      ),
                      PopupMenuItem(
                        value: 'excluir',
                        child: Text('Excluir'),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (_) => const CadastroTarefaScreen(),
            ),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }

  void _mostrarDetalhes(BuildContext context, Tarefa tarefa) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text(tarefa.titulo),
        content: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Descrição: ${tarefa.descricao}'),
              const SizedBox(height: 8),
              Text('Prioridade: ${tarefa.prioridade}'),
              const SizedBox(height: 8),
              Text(
                'Vencimento: '
                '${tarefa.dataVencimento.day}/'
                '${tarefa.dataVencimento.month}/'
                '${tarefa.dataVencimento.year}',
              ),
              const SizedBox(height: 8),
              Text(
                tarefa.concluida
                    ? 'Status: Concluída'
                    : 'Status: Pendente',
              ),
            ],
          ),
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Fechar'),
          ),
        ],
      ),
    );
  }
}