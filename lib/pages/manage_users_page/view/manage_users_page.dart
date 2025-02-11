import 'package:app_ui/app_ui.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/manage_users_page/bloc/manage_users_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class ManageUsersPage extends StatelessWidget {
  const ManageUsersPage({required this.id, super.key});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ManageUsersBloc(clubRepository: getIt<IClubRepository>())
            ..add(GetTeatchersRequired(id: id)),
      child: const ManageUsersView(),
    );
  }
}

class ManageUsersView extends StatelessWidget {
  const ManageUsersView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(kToolbarHeight),
        child: BlocBuilder<ManageUsersBloc, ManageUsersState>(
          builder: (context, state) => myAppbar(state),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTapChildRegistration(context),
        shape: const CircleBorder(),
        backgroundColor: context.colors.primary,
        child: Icon(Icons.person_add_alt_1_rounded,
            color: context.colors.onPrimary),
      ),
      body: BlocConsumer<ManageUsersBloc, ManageUsersState>(
        builder: _handlerBuilder,
        listener: _handlerListener,
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, ManageUsersState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isLoaded) {
      showCustomSnackBar(context, 'Carregado!');
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, ManageUsersState state) {
    if (state.isLoaded) {
      return ListView.builder(
        itemCount: state.teatchersModel!.length,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: Text(state.teatchersModel![index].name),
            subtitle: Text(state.teatchersModel![index].contact),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () =>
                onTapUserInfo(context, state.teatchersModel![index].id),
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
  PreferredSizeWidget myAppbar(ManageUsersState state) {
    return AppBar(
      title: Text('Membros : ${state.teatchersModel?.length ?? 0}'),
      actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
    );
  }

  /// Navigates to the child registration when the action is triggered.
  onTapChildRegistration(BuildContext context) {
    context.push(AppRouter.childRegistration);
  }

  /// Navigates to the user information when the action is triggered.
  onTapUserInfo(BuildContext context, String id) {
    context.push(AppRouter.userInformation, extra: id);
  }
}
