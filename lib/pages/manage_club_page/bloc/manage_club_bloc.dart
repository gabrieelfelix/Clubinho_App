import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'manage_club_event.dart';
part 'manage_club_state.dart';

class ManageClubBloc extends Bloc<IManageClubEvent, ManageClubBlocState> {
  final IClubRepository _clubRepository;

  ManageClubBloc({required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(const ManageClubBlocState.initial()) {
    on<EditClubNameRequired>(_onEditClubNameRequired);
    on<EditClubAddressRequired>(_onEditClubAddressRequired);
    on<GetClubDataRequired>(_onGetClubDataRequired);
    on<DeleteClubRequired>(_onDeleteClubRequired);
  }

  Future<void> _onGetClubDataRequired(
      GetClubDataRequired event, Emitter<ManageClubBlocState> emit) async {
    emit(const ManageClubBlocState.loading());

    final response = await _clubRepository.getClubInfo(id: event.id);

    response.when(
      (success) => emit(
        ManageClubBlocState.success(
          clubData: success.copyWith(id: event.id),
        ),
      ),
      (failure) => emit(
        ManageClubBlocState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onEditClubNameRequired(
      EditClubNameRequired event, Emitter<ManageClubBlocState> emit) async {
    emit(const ManageClubBlocState.loading());

    final response = await _clubRepository.editName(
      name: event.name.trim(),
      uuid: event.id,
    );

    response.when(
      (success) => emit(ManageClubBlocState.successEdit(message: success)),
      (failure) => emit(
        ManageClubBlocState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onEditClubAddressRequired(
      EditClubAddressRequired event, Emitter<ManageClubBlocState> emit) async {
    emit(const ManageClubBlocState.loading());

    final response = await _clubRepository.editAddress(
      address: event.address,
      uuid: event.id,
    );

    response.when(
      (success) => emit(ManageClubBlocState.successEdit(message: success)),
      (failure) => emit(
        ManageClubBlocState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onDeleteClubRequired(
      DeleteClubRequired event, Emitter<ManageClubBlocState> emit) async {
    emit(const ManageClubBlocState.loading());

    final response = await _clubRepository.deleteClub(id: event.id);

    response.when(
      (success) => emit(
        ManageClubBlocState.deleted(
          message: success,
        ),
      ),
      (failure) => emit(
        ManageClubBlocState.failure(message: failure.message),
      ),
    );
  }
}
