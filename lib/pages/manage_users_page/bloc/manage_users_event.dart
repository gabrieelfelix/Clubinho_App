part of 'manage_users_bloc.dart';

abstract class IManageUsersEvent extends Equatable {
  const IManageUsersEvent();

  @override
  List<Object> get props => [];
}

// class EditClubNameRequired extends IManageUsersEvent {
//   final String name;
//   final String id;

//   const EditClubNameRequired({required this.name, required this.id});

//   @override
//   List<Object> get props => [name];
// }

// class EditClubAddressRequired extends IManageClubEvent {
//   final String address;
//   final String id;

//   const EditClubAddressRequired({required this.address, required this.id});

//   @override
//   List<Object> get props => [address];
// }

class GetTeatchersRequired extends IManageUsersEvent {
  final String id;

  const GetTeatchersRequired({required this.id});

  @override
  List<Object> get props => [id];
}
