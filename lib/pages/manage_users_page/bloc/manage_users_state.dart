part of 'manage_users_bloc.dart';

enum ManageUsersPageStatus {
  initial,
  loading,
  empty,
  loaded,
  failure,
  edit,
}

class ManageUsersState extends Equatable {
  final ManageUsersPageStatus state;
  final String? message;
  final List<TeachersModel>? teatchersModel;

  const ManageUsersState._({
    this.state = ManageUsersPageStatus.loading,
    this.message,
    this.teatchersModel,
  });

  const ManageUsersState.initial()
      : this._(state: ManageUsersPageStatus.initial);

  // const ManageClubBlocState.loaded({required List<ClubModel> clubs})
  //     : this._(state: HomePageStatus.loaded, clubs: clubs);

  const ManageUsersState.failure({required String message})
      : this._(state: ManageUsersPageStatus.failure, message: message);

  const ManageUsersState.successEdit({required String message})
      : this._(state: ManageUsersPageStatus.edit, message: message);

  const ManageUsersState.success({required List<TeachersModel>? teatchersModel})
      : this._(
            state: ManageUsersPageStatus.loaded,
            teatchersModel: teatchersModel);

  const ManageUsersState.loading() : this._();

  @override
  List<Object?> get props => [state, message];
}

extension HomePageStateExtensions on ManageUsersState {
  bool get isInitial => state == ManageUsersPageStatus.initial;
  bool get isLoading => state == ManageUsersPageStatus.loading;
  bool get isEmpty => state == ManageUsersPageStatus.empty;
  bool get isLoaded => state == ManageUsersPageStatus.loaded;
  bool get isFailure => state == ManageUsersPageStatus.failure;
}
