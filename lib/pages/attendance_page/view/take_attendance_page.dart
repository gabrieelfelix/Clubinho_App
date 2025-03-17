import 'package:app_ui/app_ui.dart';
import 'package:attendance_repository/attendance_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/attendance_page/bloc/attendance_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TakeAttendancePage extends StatelessWidget {
  final String id;
  const TakeAttendancePage({required this.id, super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          AttendanceBloc(attendanceRepository: getIt<IAttendanceRepository>())
            ..add(GetAllKidsRequired(id: id)),
      child: TakeAttendanceView(id: id),
    );
  }
}

class TakeAttendanceView extends StatelessWidget {
  final String id;
  const TakeAttendanceView({super.key, required this.id});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Chamada do clubinho'),
        centerTitle: true,
      ),
      body: BlocConsumer<AttendanceBloc, AttendanceBlocState>(
        builder: _handlerBuilder,
        listener: _handlerListener,
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, AttendanceBlocState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isSuccess) {
      showCustomSnackBar(context, state.message ?? 'Carregado!');
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, AttendanceBlocState state) {
    if (state.isSuccess) {
      return RefreshIndicator(
        onRefresh: () => _refreshKids(context, id),
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 15),
                child: ListView.builder(
                  itemCount: state.kidsList!.length,
                  itemBuilder: (context, index) {
                    final kid = state.kidsList![index];

                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                            '${state.kidsList![index].fullName}\n${state.kidsList![index].age} anos'),
                        Row(
                          children: [
                            Checkbox(
                              side: const BorderSide(color: Colors.green),
                              value: kid.isPresent,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  context.read<AttendanceBloc>().add(
                                        ChangeRequired(
                                          kidId: kid.id,
                                          isPresent: true,
                                          isAbsent: false,
                                        ),
                                      );
                                } else {
                                  context.read<AttendanceBloc>().add(
                                        ChangeRequired(
                                          kidId: kid.id,
                                          isPresent: false,
                                          isAbsent: false,
                                        ),
                                      );
                                }
                              },
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.green;
                                }
                                return Colors.grey;
                              }),
                              checkColor: Colors.white,
                            ),
                            Checkbox(
                              side: const BorderSide(color: Colors.red),
                              value: kid.isAbsent,
                              onChanged: (bool? value) {
                                if (value == true) {
                                  context.read<AttendanceBloc>().add(
                                        ChangeRequired(
                                          kidId: kid.id,
                                          isPresent: false,
                                          isAbsent: true,
                                        ),
                                      );
                                } else {
                                  context.read<AttendanceBloc>().add(
                                        ChangeRequired(
                                          kidId: kid.id,
                                          isPresent: false,
                                          isAbsent: false,
                                        ),
                                      );
                                }
                              },
                              fillColor:
                                  MaterialStateProperty.resolveWith<Color>(
                                      (Set<MaterialState> states) {
                                if (states.contains(MaterialState.selected)) {
                                  return Colors.red;
                                }
                                return Colors.grey;
                              }),
                              checkColor: Colors.white,
                            )
                          ],
                        )
                      ],
                    );
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: ElevatedButton(
                onPressed: () => context
                    .read<AttendanceBloc>()
                    .add(TakeAttendanceRequired(kidsList: state.kidsList!)),
                style: ElevatedButton.styleFrom(
                    minimumSize: const Size.fromHeight(50),
                    backgroundColor: Colors.green),
                child: const Text(
                  'Salvar Chamada',
                  style: TextStyle(
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    } else if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(child: Text('Nenhuma Chamada Encontrada!'));
    }
  }

  /// Refreshes the list of clubs.
  Future<void> _refreshKids(BuildContext context, String id) async {
    context.read<AttendanceBloc>().add(GetAllKidsRequired(id: id));
  }
}
