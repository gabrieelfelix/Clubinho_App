part of 'users_manage_bloc.dart';

enum UsersManagePageStatus {
  initial,
  loading,
  empty,
  loaded,
  failure,
  success,
}

class UsersManageState extends Equatable {
  final UsersManagePageStatus state;
  final List<UsersModel>? teachers;
  final String? message;

  const UsersManageState._({
    this.state = UsersManagePageStatus.loading,
    this.teachers,
    this.message,
  });

  const UsersManageState.initial()
      : this._(state: UsersManagePageStatus.initial);

  const UsersManageState.loaded({required List<UsersModel> teachers})
      : this._(state: UsersManagePageStatus.loaded, teachers: teachers);

  const UsersManageState.failure({required String message})
      : this._(state: UsersManagePageStatus.failure, message: message);

  const UsersManageState.success({required String message})
      : this._(state: UsersManagePageStatus.success, message: message);

  const UsersManageState.loading() : this._();

  const UsersManageState.empty() : this._(state: UsersManagePageStatus.empty);

  UsersManageState copyWith({
    UsersManagePageStatus? state,
    List<UsersModel>? teachers,
    String? message,
  }) {
    return UsersManageState._(
      state: state ?? this.state,
      teachers: teachers ?? this.teachers,
      message: message ?? this.message,
    );
  }

  @override
  List<Object?> get props => [state, teachers, message];
}

extension HomePageStateExtensions on UsersManageState {
  bool get isInitial => state == UsersManagePageStatus.initial;
  bool get isLoading => state == UsersManagePageStatus.loading;
  bool get isEmpty => state == UsersManagePageStatus.empty;
  bool get isLoaded => state == UsersManagePageStatus.loaded;
  bool get isFailure => state == UsersManagePageStatus.failure;
  bool get isSuccess => state == UsersManagePageStatus.success;
}
