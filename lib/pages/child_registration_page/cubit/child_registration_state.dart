part of 'child_registration_cubit.dart';

abstract class ChildRegistrationState extends Equatable {
  const ChildRegistrationState();

  @override
  List<Object> get props => [];
}

final class ChildRegistrationInitial extends ChildRegistrationState {}

final class ChildRegistrationLoading extends ChildRegistrationState {}

final class ChildRegistrationSuccess extends ChildRegistrationState {
  final String message;

  const ChildRegistrationSuccess({required this.message});

  @override
  List<Object> get props => [message];
}

final class ChildRegistrationFailure extends ChildRegistrationState {
  final String message;

  const ChildRegistrationFailure({required this.message});

  @override
  List<Object> get props => [message];
}
