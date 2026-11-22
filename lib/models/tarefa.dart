class Tarefa {
  final String id;
  final String titulo;
  final String descricao;
  final DateTime dataVencimento;
  final String prioridade;
  final bool concluida;

  Tarefa({
    required this.id,
    required this.titulo,
    required this.descricao,
    required this.dataVencimento,
    required this.prioridade,
    required this.concluida,
  });

  // Converte a tarefa para um mapa,
  // formato utilizado para salvar no Firebase.
  Map<String, dynamic> toMap() {
    return {
      'titulo': titulo,
      'descricao': descricao,
      'dataVencimento': dataVencimento.toIso8601String(),
      'prioridade': prioridade,
      'concluida': concluida,
    };
  }

  // Cria uma tarefa a partir dos dados
  // recebidos do Firebase.
  factory Tarefa.fromMap(
    String id,
    Map<String, dynamic> map,
  ) {
    return Tarefa(
      id: id,
      titulo: map['titulo']?.toString() ?? '',
      descricao: map['descricao']?.toString() ?? '',
      dataVencimento: DateTime.tryParse(
            map['dataVencimento']?.toString() ?? '',
          ) ??
          DateTime.now(),
      prioridade: map['prioridade']?.toString() ?? 'Média',
      concluida: map['concluida'] == true,
    );
  }

  // Cria uma cópia da tarefa alterando
  // somente os campos informados.
  Tarefa copyWith({
    String? titulo,
    String? descricao,
    DateTime? dataVencimento,
    String? prioridade,
    bool? concluida,
  }) {
    return Tarefa(
      id: id,
      titulo: titulo ?? this.titulo,
      descricao: descricao ?? this.descricao,
      dataVencimento:
          dataVencimento ?? this.dataVencimento,
      prioridade: prioridade ?? this.prioridade,
      concluida: concluida ?? this.concluida,
    );
  }
}