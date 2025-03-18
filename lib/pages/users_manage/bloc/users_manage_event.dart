part of 'users_manage_bloc.dart';

abstract class IUsersManageEvent extends Equatable {
  const IUsersManageEvent();

  @override
  List<Object> get props => [];
}

class GetAllUsersRequired extends IUsersManageEvent {}
