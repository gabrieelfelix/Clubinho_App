part of 'manage_club_bloc.dart';

enum ManageClubPageStatus {
  initial,
  loading,
  empty,
  loaded,
  failure,
  edit,
  deleted,
}

class ManageClubBlocState extends Equatable {
  final ManageClubPageStatus state;
  final String? message;
  final ClubModel? clubModel;

  const ManageClubBlocState._({
    this.state = ManageClubPageStatus.loading,
    this.message,
    this.clubModel,
  });

  const ManageClubBlocState.initial()
      : this._(state: ManageClubPageStatus.initial);

  // const ManageClubBlocState.loaded({required List<ClubModel> clubs})
  //     : this._(state: HomePageStatus.loaded, clubs: clubs);

  const ManageClubBlocState.failure({required String message})
      : this._(state: ManageClubPageStatus.failure, message: message);

  const ManageClubBlocState.successEdit({required String message})
      : this._(state: ManageClubPageStatus.edit, message: message);

  const ManageClubBlocState.deleted({required String message})
      : this._(state: ManageClubPageStatus.deleted, message: message);

  const ManageClubBlocState.success({required ClubModel clubData})
      : this._(state: ManageClubPageStatus.loaded, clubModel: clubData);

  const ManageClubBlocState.loading() : this._();

  // const ManageClubBlocState.empty() : this._(state: HomePageStatus.empty);

  ManageClubBlocState copyWith({
    ManageClubPageStatus? state,
    ClubModel? clubModel,
    String? message,
  }) {
    return ManageClubBlocState._(
      state: state ?? this.state,
      clubModel: clubModel ?? this.clubModel,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, message];
}

extension HomePageStateExtensions on ManageClubBlocState {
  bool get isInitial => state == ManageClubPageStatus.initial;
  bool get isLoading => state == ManageClubPageStatus.loading;
  bool get isEmpty => state == ManageClubPageStatus.empty;
  bool get isLoaded => state == ManageClubPageStatus.loaded;
  bool get isFailure => state == ManageClubPageStatus.failure;
}
