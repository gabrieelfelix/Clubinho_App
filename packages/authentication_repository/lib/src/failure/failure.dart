// ignore_for_file: overridden_fields

import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  final String message;
  const Failure({required this.message});

  @override
  List<Object> get props => [message];
}

class CreateUserWithEmailAndPasswordFailure extends Failure {
  const CreateUserWithEmailAndPasswordFailure(
      [this.message = 'Ocorreu um erro ao tentar criar seu usuário'])
      : super(message: message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory CreateUserWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const CreateUserWithEmailAndPasswordFailure(
          'O email fornecido não é válido.',
        );
      case 'too-many-requests':
        return const CreateUserWithEmailAndPasswordFailure(
          'Muitas tentativas de login. Tente novamente mais tarde.',
        );
      case 'internal-error':
        return const CreateUserWithEmailAndPasswordFailure(
          'Erro interno no servidor. Por favor, tente novamente mais tarde.',
        );
      case 'email-already-exists':
        return const CreateUserWithEmailAndPasswordFailure(
          'Este email já está cadastrado. Por favor, faça login ou use outro email.',
        );
      default:
        return const CreateUserWithEmailAndPasswordFailure(
          'Ocorreu um erro ao tentar criar seu usuário',
        );
    }
  }

  /// The associated error message.
  @override
  final String message;

  @override
  List<Object> get props => [message];
}

class SignInWithEmailAndPasswordFailure extends Failure {
  const SignInWithEmailAndPasswordFailure(
      [this.message = 'Ocorreu um erro ao tentar autenticar seu usuário'])
      : super(message: message);

  /// Create an authentication message
  /// from a firebase authentication exception code.
  factory SignInWithEmailAndPasswordFailure.fromCode(String code) {
    switch (code) {
      case 'invalid-email':
        return const SignInWithEmailAndPasswordFailure(
          'O email fornecido não é válido.',
        );
      case 'account-exists-with-different-credential':
        return const SignInWithEmailAndPasswordFailure(
          'A conta já existe com uma credencial diferente',
        );
      case 'user-disabled':
        return const SignInWithEmailAndPasswordFailure(
          'Esta conta foi desativada. Por favor, entre em contato com o suporte.',
        );
      case 'user-not-found':
        return const SignInWithEmailAndPasswordFailure(
          'Usuário não encontrado. Verifique suas credenciais e tente novamente.',
        );
      case 'wrong-password':
        return const SignInWithEmailAndPasswordFailure(
          'Senha incorreta. Por favor, tente novamente.',
        );
      case 'too-many-requests':
        return const SignInWithEmailAndPasswordFailure(
          'Muitas tentativas de login. Tente novamente mais tarde.',
        );
      case 'operation-not-allowed':
        return const SignInWithEmailAndPasswordFailure(
          'O login com email e senha não está habilitado. Entre em contato com o suporte.',
        );
      default:
        return const SignInWithEmailAndPasswordFailure(
          'Ocorreu um erro ao tentar autenticar seu usuário',
        );
    }
  }

  /// The associated error message.
  @override
  final String message;

  @override
  List<Object> get props => [message];
}
