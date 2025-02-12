import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_users_event.dart';
part 'manage_users_state.dart';

class ManageUsersBloc extends Bloc<IManageUsersEvent, ManageUsersState> {
  final IClubRepository _clubRepository;

  ManageUsersBloc({required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(const ManageUsersState.initial()) {
    on<GetTeatchersRequired>(_onGetTeatchersDataRequired);
    on<GetChildrenRequired>(_onGetChildrenDataRequired);
  }

  Future<void> _onGetTeatchersDataRequired(
      GetTeatchersRequired event, Emitter<ManageUsersState> emit) async {
    emit(const ManageUsersState.loading());

    final response = await _clubRepository.getUsers(id: event.id);

    response.when(
      (success) => emit(
        ManageUsersState.success(teatchersModel: success),
      ),
      (failure) => emit(
        ManageUsersState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onGetChildrenDataRequired(
      GetChildrenRequired event, Emitter<ManageUsersState> emit) async {
    emit(const ManageUsersState.loading());

    final response = await _clubRepository.getChildren(id: event.id);

    response.when(
      (success) => emit(
        ManageUsersState.successChildren(childrenModel: success),
      ),
      (failure) => emit(
        ManageUsersState.failure(message: failure.message),
      ),
    );
  }
}
