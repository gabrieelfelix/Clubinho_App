part of 'manage_club_bloc.dart';

abstract class IManageClubEvent extends Equatable {
  const IManageClubEvent();

  @override
  List<Object> get props => [];
}

class EditClubNameRequired extends IManageClubEvent {
  final String name;
  final String id;

  const EditClubNameRequired({required this.name, required this.id});

  @override
  List<Object> get props => [name];
}

class EditClubAddressRequired extends IManageClubEvent {
  final String address;
  final String id;

  const EditClubAddressRequired({required this.address, required this.id});

  @override
  List<Object> get props => [address];
}

class GetClubDataRequired extends IManageClubEvent {
  final String id;

  const GetClubDataRequired({required this.id});

  @override
  List<Object> get props => [id];
}
