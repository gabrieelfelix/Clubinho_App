import 'package:club_repository/club_repository.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'child_registration_state.dart';

class ChildRegistrationCubit extends Cubit<ChildRegistrationState> {
  final IClubRepository _clubRepository;

  ChildRegistrationCubit({required IClubRepository clubRepository})
      : _clubRepository = clubRepository,
        super(ChildRegistrationInitial());

  Future<void> registationChild({
    required String id,
    required String address,
    required String age,
    required String birthDate,
    required String contactNumber,
    required String fatherName,
    required String fullName,
    required String motherName,
    required String notes,
  }) async {
    emit(ChildRegistrationLoading());

    final response = await _clubRepository.addChild(
      id: id,
      address: address,
      age: age,
      birthDate: birthDate,
      contactNumber: contactNumber,
      fatherName: fatherName,
      fullName: fullName,
      motherName: motherName,
      notes: notes,
    );

    response.when(
      (success) => emit(
        ChildRegistrationSuccess(message: success),
      ),
      (failure) => emit(
        ChildRegistrationFailure(message: failure.message),
      ),
    );
  }
}
