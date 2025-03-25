part of 'users_manage_bloc.dart';

abstract class IUsersManageEvent extends Equatable {
  const IUsersManageEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersRequired extends IUsersManageEvent {}

class ChangeRoleRequired extends IUsersManageEvent {
  final UserRole role;
  final String userId;

  const ChangeRoleRequired({
    required this.role,
    required this.userId,
  });
}
