import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/tarefa.dart';

class FirebaseService {
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  String get _uid {
    final user = FirebaseAuth.instance.currentUser;

    if (user == null) {
      throw Exception('Usuário não autenticado.');
    }

    return user.uid;
  }

  DatabaseReference get _tarefasRef =>
      _database.ref('users/$_uid/tasks');

  Stream<List<Tarefa>> ouvirTarefas() {
    return _tarefasRef.onValue.map((evento) {
      final dados = evento.snapshot.value;

      if (dados == null) {
        return <Tarefa>[];
      }

      final mapa = Map<dynamic, dynamic>.from(dados as Map);

      return mapa.entries.map((entrada) {
        final dadosTarefa =
            Map<String, dynamic>.from(entrada.value as Map);

        return Tarefa.fromMap(
          entrada.key.toString(),
          dadosTarefa,
        );
      }).toList();
    });
  }

  Future<void> adicionarTarefa(Tarefa tarefa) async {
    final novaReferencia = _tarefasRef.push();

    await novaReferencia.set(tarefa.toMap());
  }

  Future<void> atualizarTarefa(Tarefa tarefa) async {
    await _tarefasRef.child(tarefa.id).update(
      tarefa.toMap(),
    );
  }

  Future<void> excluirTarefa(String id) async {
    await _tarefasRef.child(id).remove();
  }

  Future<void> alterarStatus(Tarefa tarefa) async {
    await _tarefasRef.child(tarefa.id).update({
      'concluida': !tarefa.concluida,
    });
  }
}