part of 'clubs_bloc.dart';

abstract class IClubsEvent extends Equatable {
  const IClubsEvent();

  @override
  List<Object> get props => [];
}

class GetClubsRequired extends IClubsEvent {}

class AddClubRequired extends IClubsEvent {
  final String name;

  const AddClubRequired({required this.name});

  @override
  List<Object> get props => [name];
}

class JoinClubRequired extends IClubsEvent {
  final String clubInput;
  final String userId;

  const JoinClubRequired({
    required this.clubInput,
    required this.userId,
  });

  @override
  List<Object> get props => [clubInput, userId];
}
