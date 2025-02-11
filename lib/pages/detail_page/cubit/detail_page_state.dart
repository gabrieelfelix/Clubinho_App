part of 'detail_page_cubit.dart';

enum DetailPageStatus {
  initial,
  loading,
  loaded,
  failure,
  edit,
}

class DetailPageState extends Equatable {
  final DetailPageStatus state;
  final String? message;
  final DefaultModel? model;

  const DetailPageState._({
    this.state = DetailPageStatus.loading,
    this.message,
    this.model,
  });

  const DetailPageState.initial() : this._(state: DetailPageStatus.initial);

  // const ManageClubBlocState.loaded({required List<ClubModel> clubs})
  //     : this._(state: HomePageStatus.loaded, clubs: clubs);

  const DetailPageState.failure({required String message})
      : this._(state: DetailPageStatus.failure, message: message);

  const DetailPageState.successEdit({required String message})
      : this._(state: DetailPageStatus.edit, message: message);

  const DetailPageState.success({required DefaultModel? model})
      : this._(state: DetailPageStatus.loaded, model: model);

  const DetailPageState.loading() : this._();

  @override
  List<Object?> get props => [state, message];
}

extension HomePageStateExtensions on DetailPageState {
  bool get isInitial => state == DetailPageStatus.initial;
  bool get isLoading => state == DetailPageStatus.loading;
  bool get isLoaded => state == DetailPageStatus.loaded;
  bool get isFailure => state == DetailPageStatus.failure;
}
