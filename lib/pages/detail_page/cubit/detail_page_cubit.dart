import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_page_state.dart';

class DetailPageCubit extends Cubit<DetailPageState> {
  final IClubRepository _clubRepository;

  DetailPageCubit({required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(DetailPageInitial());

  Future<void> removeTeacher({
    required String idTeacher,
    required String idClub,
  }) async {
    emit(DetailPageLoading());

    final response = await _clubRepository.deleteTeacher(
      idClub: idClub,
      idTeacher: idTeacher,
    );

    response.when(
      (success) => emit(DetailPageSuccess(message: success)),
      (failure) => emit(DetailPageFailure(message: failure.message)),
    );
  }

  Future<void> removeKid({
    required String idChild,
    required String idClub,
  }) async {
    emit(DetailPageLoading());

    final response = await _clubRepository.deleteKid(
      clubId: idClub,
      idChild: idChild,
    );

    response.when(
      (success) => emit(DetailPageSuccess(message: success)),
      (failure) => emit(DetailPageFailure(message: failure.message)),
    );
  }
}
