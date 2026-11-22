class Usuario {
  final String uid;
  final String nome;
  final String email;

  Usuario({
    required this.uid,
    required this.nome,
    required this.email,
  });

  // Converte o usuário para um mapa
  // para salvar os dados no Firebase.
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'nome': nome,
      'email': email,
    };
  }

  // Cria um usuário a partir dos dados
  // recebidos do Firebase.
  factory Usuario.fromMap(Map<String, dynamic> map) {
    return Usuario(
      uid: map['uid']?.toString() ?? '',
      nome: map['nome']?.toString() ?? '',
      email: map['email']?.toString() ?? '',
    );
  }
}