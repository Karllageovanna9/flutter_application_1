import 'package:flutter/material.dart';

import '../models/tarefa.dart';
import '../services/firebase_service.dart';
import '../widgets/drawer_menu.dart';
import 'cadastro_tarefa_screen.dart';
import 'tarefas_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final firebaseService = FirebaseService();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Início'),
      ),
      drawer: const DrawerMenu(),
      body: StreamBuilder<List<Tarefa>>(
        stream: firebaseService.ouvirTarefas(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return const Center(
              child: Text('Erro ao carregar tarefas.'),
            );
          }

          if (snapshot.connectionState ==
                  ConnectionState.waiting &&
              !snapshot.hasData) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          final tarefas = snapshot.data ?? [];
          final total = tarefas.length;
          final concluidas =
              tarefas.where((t) => t.concluida).length;
          final pendentes = total - concluidas;

          return Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Resumo das tarefas',
                  style: TextStyle(
                    fontSize: 22,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 16),
                Row(
                  children: [
                    _ResumoCard(
                      titulo: 'Total',
                      quantidade: total,
                      cor: Colors.indigo,
                    ),
                    const SizedBox(width: 8),
                    _ResumoCard(
                      titulo: 'Pendentes',
                      quantidade: pendentes,
                      cor: Colors.orange,
                    ),
                    const SizedBox(width: 8),
                    _ResumoCard(
                      titulo: 'Concluídas',
                      quantidade: concluidas,
                      cor: Colors.green,
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                const Text(
                  'Tarefas recentes',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 8),
                Expanded(
                  child: tarefas.isEmpty
                      ? const Center(
                          child: Text(
                            'Nenhuma tarefa cadastrada.',
                          ),
                        )
                      : ListView.builder(
                          itemCount: tarefas.length > 5
                              ? 5
                              : tarefas.length,
                          itemBuilder: (context, index) {
                            final tarefa = tarefas[index];

                            return Card(
                              child: ListTile(
                                leading: Icon(
                                  tarefa.concluida
                                      ? Icons.check_circle
                                      : Icons.pending_actions,
                                  color: tarefa.concluida
                                      ? Colors.green
                                      : Colors.orange,
                                ),
                                title: Text(tarefa.titulo),
                                subtitle: Text(
                                  tarefa.concluida
                                      ? 'Concluída'
                                      : 'Pendente',
                                ),
                              ),
                            );
                          },
                        ),
                ),
                SizedBox(
                  width: double.infinity,
                  child: ElevatedButton.icon(
                    icon: const Icon(Icons.list),
                    label: const Text('Ver minhas tarefas'),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (_) => const TarefasScreen(),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
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
}

class _ResumoCard extends StatelessWidget {
  final String titulo;
  final int quantidade;
  final Color cor;

  const _ResumoCard({
    required this.titulo,
    required this.quantidade,
    required this.cor,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        color: cor.withValues(alpha: 0.12),
        child: Padding(
          padding: const EdgeInsets.symmetric(
            vertical: 18,
            horizontal: 6,
          ),
          child: Column(
            children: [
              Text(
                quantidade.toString(),
                style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: cor,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                titulo,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }
}