// ignore_for_file: overridden_fields

import 'package:authentication_repository/authentication_repository.dart';

class FailureClub extends Failure {
  const FailureClub({required this.message}) : super(message: '');

  @override
  final String message;

  @override
  List<Object> get props => [message];
}
