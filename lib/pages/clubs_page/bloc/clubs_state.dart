part of 'clubs_bloc.dart';

enum ClubsState { initial, loading, empty, loaded, failure, successCreate }

class ClubsBlocState extends Equatable {
  final ClubsState state;
  final List<ClubModel>? clubs;
  final String? message;

  const ClubsBlocState._({
    this.state = ClubsState.loading,
    this.clubs,
    this.message,
  });

  const ClubsBlocState.initial() : this._(state: ClubsState.initial);

  const ClubsBlocState.loaded({required List<ClubModel> clubs})
      : this._(state: ClubsState.loaded, clubs: clubs);

  const ClubsBlocState.failure({required String message})
      : this._(state: ClubsState.failure, message: message);

  const ClubsBlocState.successCreate({required String message})
      : this._(state: ClubsState.successCreate, message: message);

  const ClubsBlocState.loading() : this._();

  const ClubsBlocState.empty() : this._(state: ClubsState.empty);

  @override
  List<Object?> get props => [state, clubs, message];
}

extension HomePageStateExtensions on ClubsBlocState {
  bool get isInitial => state == ClubsState.initial;
  bool get isLoading => state == ClubsState.loading;
  bool get isEmpty => state == ClubsState.empty;
  bool get isLoaded => state == ClubsState.loaded;
  bool get isFailure => state == ClubsState.failure;
  bool get isCreated => state == ClubsState.successCreate;
}
