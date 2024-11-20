part of 'home_bloc.dart';

abstract class IHomeEvent extends Equatable {
  const IHomeEvent();

  @override
  List<Object> get props => [];
}

class GetClubsRequired extends IHomeEvent {}

class AddClubRequired extends IHomeEvent {
  final String name;

  const AddClubRequired({required this.name});

  @override
  List<Object> get props => [name];
}
