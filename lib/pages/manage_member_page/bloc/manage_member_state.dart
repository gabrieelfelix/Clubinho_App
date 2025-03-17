part of 'manage_member_bloc.dart';

enum ManageMemberPageStatus {
  initial,
  loading,
  empty,
  loaded,
  failure,
  edit,
}

class ManageMemberState extends Equatable {
  final ManageMemberPageStatus state;
  final String? message;
  final List<TeachersModel>? teatchersModel;
  final List<KidsModel>? childrenModel;

  const ManageMemberState._({
    this.state = ManageMemberPageStatus.loading,
    this.message,
    this.teatchersModel,
    this.childrenModel,
  });

  const ManageMemberState.initial()
      : this._(state: ManageMemberPageStatus.initial);

  // const ManageClubBlocState.loaded({required List<ClubModel> clubs})
  //     : this._(state: HomePageStatus.loaded, clubs: clubs);

  const ManageMemberState.failure({required String message})
      : this._(state: ManageMemberPageStatus.failure, message: message);

  const ManageMemberState.successEdit({required String message})
      : this._(state: ManageMemberPageStatus.edit, message: message);

  const ManageMemberState.success(
      {required List<TeachersModel>? teatchersModel})
      : this._(
            state: ManageMemberPageStatus.loaded,
            teatchersModel: teatchersModel);

  const ManageMemberState.successChildren(
      {required List<KidsModel>? childrenModel})
      : this._(
          state: ManageMemberPageStatus.loaded,
          childrenModel: childrenModel,
        );

  const ManageMemberState.loading() : this._();

  @override
  List<Object?> get props => [state, message];
}

extension HomePageStateExtensions on ManageMemberState {
  bool get isInitial => state == ManageMemberPageStatus.initial;
  bool get isLoading => state == ManageMemberPageStatus.loading;
  bool get isEmpty => state == ManageMemberPageStatus.empty;
  bool get isLoaded => state == ManageMemberPageStatus.loaded;
  bool get isFailure => state == ManageMemberPageStatus.failure;
}
