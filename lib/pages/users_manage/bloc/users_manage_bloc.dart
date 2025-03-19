import 'package:authentication_repository/authentication_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'users_manage_event.dart';
part 'users_manage_state.dart';

class UsersManageBloc extends Bloc<IUsersManageEvent, UsersManageState> {
  final IAuthenticationRepository _authenticationRepository;
  UsersManageBloc({required IAuthenticationRepository authenticationRepository})
      : _authenticationRepository = authenticationRepository,
        super(const UsersManageState.initial()) {
    on<GetAllUsersRequired>(_onGetAllUsersRequired);
  }

  Future<void> _onGetAllUsersRequired(
      GetAllUsersRequired event, Emitter<UsersManageState> emit) async {
    emit(const UsersManageState.loading());

    final response = await _authenticationRepository.getAllUsers();

    response.when(
      (success) => emit(
        success.isNotEmpty
            ? UsersManageState.loaded(teachers: success)
            : const UsersManageState.empty(),
      ),
      (failure) => emit(UsersManageState.failure(message: failure.message)),
    );
  }
}
