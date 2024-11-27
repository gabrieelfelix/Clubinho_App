import 'dart:developer';

import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/utils/constants.dart';
import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'home_bloc_event.dart';
part 'home_bloc_state.dart';

class HomeBloc extends Bloc<IHomeEvent, HomeBlocState> {
  final IClubRepository _clubRepository;

  HomeBloc({required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(const HomeBlocState.initial()) {
    on<GetClubsRequired>(_onGetClubsRequired);
    on<AddClubRequired>(_onAddClubRequired);
  }

  Future<void> _onGetClubsRequired(
      GetClubsRequired event, Emitter<HomeBlocState> emit) async {
    emit(const HomeBlocState.loading());

    final userId =
        CacheClient.read<AuthUserModel>(key: AppConstants.userCacheKey)!.userId;
    final response = await _clubRepository.getAllClubs(uuid: userId);

    response.when(
      (success) => emit(
        success.isNotEmpty
            ? HomeBlocState.loaded(clubs: success)
            : const HomeBlocState.empty(),
      ),
      (failure) => emit(
        HomeBlocState.failure(message: failure.message),
      ),
    );
  }

  Future<void> _onAddClubRequired(
      AddClubRequired event, Emitter<HomeBlocState> emit) async {
    emit(const HomeBlocState.loading());

    final response = await _clubRepository.createClub(name: event.name.trim());

    response.when(
      (success) => emit(HomeBlocState.successCreate(message: success)),
      (failure) => emit(
        HomeBlocState.failure(message: failure.message),
      ),
    );
  }
}
