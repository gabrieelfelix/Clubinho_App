import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/detail_page/cubit/detail_page_cubit.dart';
import 'package:club_app/utils/constants.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  final TeachersModel? teacher;
  final KidsModel? kid;

  const DetailPage.teacher({super.key, required this.teacher}) : kid = null;
  const DetailPage.kid({super.key, required this.kid}) : teacher = null;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          DetailPageCubit(clubRepository: getIt<IClubRepository>()),
      child: teacher != null
          ? DetailPageView.teacher(teachersModel: teacher!)
          : DetailPageView.kids(childModel: kid!),
    );
  }
}

// ignore: must_be_immutable
class DetailPageView extends StatelessWidget {
  DetailPageView.teacher({super.key, required this.teachersModel})
      : childModel = KidsModel.empty,
        isTeacher = true;

  DetailPageView.kids({super.key, required this.childModel})
      : teachersModel = TeachersModel.empty,
        isTeacher = false;

  final TeachersModel teachersModel;

  final KidsModel childModel;

  final bool isTeacher;

  bool isCoordinatorOrAdmin = false;

  bool isCurrentUser = false;

  @override
  Widget build(BuildContext context) {
    final authUser =
        CacheClient.read<AuthUserModel>(key: AppConstants.userCacheKey);
    isCurrentUser = authUser?.userId == teachersModel.id;
    isCoordinatorOrAdmin = authUser?.userRole == UserRole.coordinator ||
        authUser?.userRole == UserRole.admin;
    return Scaffold(
        body: isTeacher
            ? teacherDetail(teachersModel, context)
            : //
            kidsDetail(childModel, context));
  }

  /// Section Widget
  Widget kidsDetail(KidsModel model, BuildContext ct) {
    return BlocConsumer<DetailPageCubit, DetailPageState>(
      listener: (context, state) {
        if (state is DetailPageSuccess) {
          showCustomSnackBar(
            context,
            state.message!,
            type: SnackBarType.success,
          );
        } else if (state is DetailPageFailure) {
          showCustomSnackBar(
            context,
            state.message,
            type: SnackBarType.error,
          );
        }
      },
      builder: (context, state) {
        if (state is DetailPageInitial) {
          return SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Id: ${model.id}'),
                Text('Nome: ${model.fullName}'),
                Text('Idade:\n${model.age}'),
                Text('Data de nascimento: ${model.birthDate}'),
                Text('Nome do pai: ${model.fatherName}'),
                Text('Nome da mãe: ${model.motherName}'),
                Text('Contato: ${model.contactNumber}'),
                Text('Endereço: ${model.address}'),
                Text('Obs: ${model.notes}'),
                if (isCoordinatorOrAdmin)
                  ElevatedButton(
                    onPressed: () => ct
                        .read<DetailPageCubit>()
                        .removeKid(idClub: model.clubIdSave, idChild: model.id),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    child: const Text(
                      'Remover Criança',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        } else if (state is DetailPageSuccess) {
          return Center(child: Text(state.message!));
        } else if (state is DetailPageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Erro'));
        }
      },
    );
  }

  /// Section Widget
  Widget teacherDetail(TeachersModel model, BuildContext ct) {
    return BlocConsumer<DetailPageCubit, DetailPageState>(
      listener: (context, state) {
        if (state is DetailPageSuccess) {
          showCustomSnackBar(
            context,
            state.message!,
            type: SnackBarType.success,
          );
        }
      },
      builder: (context, state) {
        if (state is DetailPageInitial) {
          return SizedBox.expand(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Nome: ${model.name}'),
                Text('Email: ${model.email}'),
                Text('Telefone: ${model.contact}'),
                Text('Clubinhos que participa:\n${model.classIds}'),
                if (isCoordinatorOrAdmin && !isCurrentUser)
                  ElevatedButton(
                    onPressed: () => ct.read<DetailPageCubit>().removeTeacher(
                        idClub: model.clubIdSave, idTeacher: model.id),
                    style: const ButtonStyle(
                        backgroundColor: WidgetStatePropertyAll(Colors.red)),
                    child: const Text(
                      'Remover professor',
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
              ],
            ),
          );
        } else if (state is DetailPageSuccess) {
          return Center(child: Text(state.message!));
        } else if (state is DetailPageLoading) {
          return const Center(child: CircularProgressIndicator());
        } else {
          return const Center(child: Text('Erro'));
        }
      },
    );
  }
}
