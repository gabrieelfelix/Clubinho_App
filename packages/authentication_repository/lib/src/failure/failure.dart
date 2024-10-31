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
      [this.message = 'Ocorreu um erro ao tentar autenticar seu usuário'])
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
