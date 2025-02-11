import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'detail_page_state.dart';

enum TypeInfo {
  kids,
  teacher,
}

extension DetailPageExtensions on DetailPageCubit {
  bool get isKid => type == TypeInfo.kids;
  bool get isTeacher => type == TypeInfo.teacher;
}

class DetailPageCubit extends Cubit<DetailPageState> {
  final IClubRepository _clubRepository;
  final TypeInfo? type;

  DetailPageCubit(this.type, {required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(const DetailPageState.initial());

  Future<void> getInfo(TypeInfo type, {required String id}) async {
    emit(const DetailPageState.loading());

    if (isTeacher) {
      final response = await _clubRepository.getUserInfo(id: id);

      response.when(
        (success) => emit(DetailPageState.success(model: success)),
        (failure) => emit(DetailPageState.failure(message: failure.message)),
      );
    } else {
      /////
    }
  }
}
