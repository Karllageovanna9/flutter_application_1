import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';

import '../models/usuario.dart';

class AuthService {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseDatabase _database = FirebaseDatabase.instance;

  User? get usuarioAtual => _auth.currentUser;

  Stream<User?> get estadoAutenticacao =>
      _auth.authStateChanges();

  Future<Usuario> cadastrar({
    required String nome,
    required String email,
    required String senha,
  }) async {
    final credencial =
        await _auth.createUserWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );

    final user = credencial.user;

    if (user == null) {
      throw Exception('Não foi possível criar o usuário.');
    }

    await user.updateDisplayName(nome.trim());

    await _database.ref('users/${user.uid}/profile').set({
      'uid': user.uid,
      'nome': nome.trim(),
      'email': email.trim(),
    });

    return Usuario(
      uid: user.uid,
      nome: nome.trim(),
      email: email.trim(),
    );
  }

  Future<Usuario> entrar({
    required String email,
    required String senha,
  }) async {
    final credencial =
        await _auth.signInWithEmailAndPassword(
      email: email.trim(),
      password: senha,
    );

    final user = credencial.user;

    if (user == null) {
      throw Exception('Não foi possível entrar.');
    }

    return Usuario(
      uid: user.uid,
      nome: user.displayName ?? 'Usuário',
      email: user.email ?? email,
    );
  }

  Future<void> sair() async {
    await _auth.signOut();
  }
}