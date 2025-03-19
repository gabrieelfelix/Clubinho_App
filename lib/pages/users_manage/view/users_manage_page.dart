import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/users_manage/bloc/users_manage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// toda vez que entra ele carrega
class UsersManagePage extends StatelessWidget {
  const UsersManagePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UsersManageBloc(
        authenticationRepository: getIt<IAuthenticationRepository>(),
      )..add(GetAllUsersRequired()),
      child: const UsersManageView(),
    );
  }
}

class UsersManageView extends StatelessWidget {
  const UsersManageView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<UsersManageBloc, UsersManageState>(
        listener: _handlerListener,
        builder: _handlerBuilder,
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, UsersManageState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isLoaded) {
      showCustomSnackBar(context, 'Carregado!');
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, UsersManageState state) {
    if (state.isLoaded) {
      return RefreshIndicator(
        onRefresh: () => _refreshUsers(context),
        child: ListView.builder(
          itemCount: state.teachers!.length,
          itemBuilder: (context, index) {
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                state.teachers![index].name,
              ),
              subtitle: Text(state.teachers![index].email),
            );
          },
        ),
      );
    } else if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else if (state.isEmpty) {
      return const Center(child: Text('Nenhum usuário encontrado!'));
    } else {
      return const Center(child: Text('Nenhum Usuário Vinculado!'));
    }
  }

  /// Refreshes the list of clubs.
  Future<void> _refreshUsers(BuildContext context) async {
    context.read<UsersManageBloc>().add(GetAllUsersRequired());
  }
}
