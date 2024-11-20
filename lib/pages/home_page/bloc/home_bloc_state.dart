part of 'home_bloc.dart';

enum HomePageStatus { initial, loading, empty, loaded, failure }

class HomeBlocState extends Equatable {
  final HomePageStatus state;
  final List<ClubModel>? users;
  final String? message;

  const HomeBlocState._({
    this.state = HomePageStatus.loading,
    this.users,
    this.message,
  });

  const HomeBlocState.initial() : this._(state: HomePageStatus.initial);

  const HomeBlocState.loaded({required List<ClubModel> users})
      : this._(state: HomePageStatus.loaded, users: users);

  const HomeBlocState.failure({required String message})
      : this._(state: HomePageStatus.failure, message: message);

  const HomeBlocState.loading() : this._();

  const HomeBlocState.empty({required String message})
      : this._(state: HomePageStatus.empty, message: message);

  @override
  List<Object?> get props => [state, users, message];
}

extension HomePageStateExtensions on HomeBlocState {
  bool get isInitial => state == HomePageStatus.initial;
  bool get isLoading => state == HomePageStatus.loading;
  bool get isEmpty => state == HomePageStatus.empty;
  bool get isLoaded => state == HomePageStatus.loaded;
  bool get isFailure => state == HomePageStatus.failure;
}
