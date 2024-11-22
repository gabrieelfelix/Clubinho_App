part of 'home_bloc.dart';

enum HomePageStatus { initial, loading, empty, loaded, failure, successCreate }

class HomeBlocState extends Equatable {
  final HomePageStatus state;
  final List<ClubModel>? clubs;
  final String? message;

  const HomeBlocState._({
    this.state = HomePageStatus.loading,
    this.clubs,
    this.message,
  });

  const HomeBlocState.initial() : this._(state: HomePageStatus.initial);

  const HomeBlocState.loaded({required List<ClubModel> clubs})
      : this._(state: HomePageStatus.loaded, clubs: clubs);

  const HomeBlocState.failure({required String message})
      : this._(state: HomePageStatus.failure, message: message);

  const HomeBlocState.successCreate({required String message})
      : this._(state: HomePageStatus.successCreate, message: message);

  const HomeBlocState.loading() : this._();

  const HomeBlocState.empty() : this._(state: HomePageStatus.empty);

  @override
  List<Object?> get props => [state, clubs, message];
}

extension HomePageStateExtensions on HomeBlocState {
  bool get isInitial => state == HomePageStatus.initial;
  bool get isLoading => state == HomePageStatus.loading;
  bool get isEmpty => state == HomePageStatus.empty;
  bool get isLoaded => state == HomePageStatus.loaded;
  bool get isFailure => state == HomePageStatus.failure;
  bool get isCreated => state == HomePageStatus.successCreate;
}
