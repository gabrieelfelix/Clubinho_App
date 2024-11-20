part of 'home_bloc.dart';

abstract class IHomeEvent extends Equatable {
  const IHomeEvent();

  @override
  List<Object> get props => [];
}

class GetClubsRequired extends IHomeEvent {
  final String userId;

  const GetClubsRequired({required this.userId});
}
