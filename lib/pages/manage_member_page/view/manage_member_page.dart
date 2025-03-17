import 'package:app_ui/app_ui.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/manage_member_page/bloc/manage_member_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageMemberPage extends StatelessWidget {
  const ManageMemberPage.teachers({required this.id, super.key})
      : isTeacher = true;

  const ManageMemberPage.children({required this.id, super.key})
      : isTeacher = false;

  final bool isTeacher;

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) {
        final bloc = ManageMemberBloc(clubRepository: getIt<IClubRepository>());
        _initializeBloc(bloc);
        return bloc;
      },
      child: ManageUsersView(isTeacher: isTeacher, id: id),
    );
  }

  /// Dealing bloc initialize
  void _initializeBloc(ManageMemberBloc bloc) {
    final event = isTeacher
        ? GetTeatchersRequired(id: id)
        : //
        GetChildrenRequired(id: id);

    bloc.add(event);
  }
}

class ManageUsersView extends StatelessWidget {
  const ManageUsersView({super.key, required this.isTeacher, required this.id});

  final bool isTeacher;

  final String id;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ManageMemberBloc, ManageMemberState>(
          builder: (context, state) => myAppbar(state, isTeacher),
        ),
      ),
      floatingActionButton: !isTeacher
          ? FloatingActionButton(
              onPressed: () => onTapChildRegistration(context, id),
              shape: const CircleBorder(),
              backgroundColor: context.colors.primary,
              child: Icon(Icons.person_add_alt_1_rounded,
                  color: context.colors.onPrimary),
            )
          : null,
      body: BlocConsumer<ManageMemberBloc, ManageMemberState>(
        builder: _handlerBuilder,
        listener: _handlerListener,
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, ManageMemberState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isLoaded) {
      showCustomSnackBar(context, 'Carregado!');
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, ManageMemberState state) {
    if (state.isLoaded) {
      return ListView.builder(
        itemCount: isTeacher
            ? state.teatchersModel!.length
            : state.childrenModel!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(isTeacher
                ? state.teatchersModel![index].name
                : state.childrenModel![index].fullName),
            subtitle: Text(isTeacher
                ? state.teatchersModel![index].contact
                : "${state.childrenModel![index].age} anos"),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () => isTeacher
                ? onTapUserInfo(context, state.teatchersModel![index])
                : onTapChildInfo(context, state.childrenModel![index]),
          );
        },
      );
    } else if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(child: Text('Nenhum Professor Vinculado!'));
    }
  }

  /// Section Widget
  PreferredSizeWidget myAppbar(ManageMemberState state, bool isTeacher) {
    return AppBar(
      title: Text(
          '${isTeacher ? 'Membros' : 'Crianças'} : ${isTeacher ? state.teatchersModel?.length ?? 0 : state.childrenModel?.length ?? 0}'),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
    );
  }

  /// Navigates to the child registration when the action is triggered.
  onTapChildRegistration(BuildContext context, String id) {
    context.push(AppRouter.childRegistration, extra: id);
  }

  /// Navigates to the user information when the action is triggered.
  onTapUserInfo(BuildContext context, TeachersModel model) {
    context.push(AppRouter.userInformation, extra: model);
  }

  /// Navigates to the user information when the action is triggered.
  onTapChildInfo(BuildContext context, KidsModel model) {
    context.push(AppRouter.childInformation, extra: model);
  }
}
