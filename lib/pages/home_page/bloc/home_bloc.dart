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
  }

  Future<void> _onGetClubsRequired(
      GetClubsRequired event, Emitter<HomeBlocState> emit) async {}
}
