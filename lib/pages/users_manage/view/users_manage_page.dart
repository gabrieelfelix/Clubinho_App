import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/pages/users_manage/bloc/users_manage_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

// class UsersManagePage extends StatelessWidget {
//   const UsersManagePage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => UsersManageBloc(
//         authenticationRepository: getIt<IAuthenticationRepository>(),
//       )..add(GetAllUsersRequired()),
//       child: const UsersManageView(),
//     );
//   }
// }

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
      showCustomSnackBar(
        context,
        state.message!,
        type: SnackBarType.error,
      );
    } else if (state.isLoaded) {
      //showCustomSnackBar(context, 'Carregado!');
    } else if (state.isSuccess) {
      showCustomSnackBar(
        context,
        state.message!,
        type: SnackBarType.success,
      );
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, UsersManageState state) {
    if (state.teachers != null) {
      return RefreshIndicator(
        onRefresh: () => _refreshUsers(context),
        child: ListView.builder(
          itemCount: state.teachers!.length,
          itemBuilder: (context, index) {
            final user = state.teachers![index];
            final TextEditingController controller = TextEditingController(
              text: _getRoleLabel(user.userRole),
            );
            return ListTile(
              leading: const Icon(Icons.person),
              title: Text(
                user.name,
              ),
              enabled: true,
              subtitle: Text(user.email),
              trailing: DropdownMenu<UserRole>(
                initialSelection: user.userRole,
                dropdownMenuEntries: const [
                  DropdownMenuEntry(
                    value: UserRole.teacher,
                    label: 'Teacher',
                  ),
                  DropdownMenuEntry(
                    value: UserRole.coordinator,
                    label: 'Coordinator',
                  ),
                  DropdownMenuEntry(
                    value: UserRole.admin,
                    label: 'Admin',
                  ),
                ],
                onSelected: (role) {
                  if (role != null) {
                    controller.text = _getRoleLabel(user.userRole);
                    _buildAlertDialog(context, role, user.id);
                  }
                },
                controller: controller,
              ),
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

  /// Section Widget
  _buildAlertDialog(BuildContext context, UserRole role, String id) {
    final bloc = context.read<UsersManageBloc>();
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocConsumer<UsersManageBloc, UsersManageState>(
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              }
            },
            builder: (context, state) {
              return AlertDialog(
                backgroundColor: context.theme.colorScheme.onPrimary,
                title: const Text('Alterar role, tem certeza?'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context.read<UsersManageBloc>().add(
                            ChangeRoleRequired(role: role, userId: id),
                          );
                      Navigator.of(context).pop();
                    },
                    child: const Text('Sim'),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Não'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Função auxiliar para obter o label do role
  String _getRoleLabel(UserRole role) {
    switch (role) {
      case UserRole.teacher:
        return 'Teacher';
      case UserRole.coordinator:
        return 'Coordinator';
      case UserRole.admin:
        return 'Admin';
    }
  }

  /// Refreshes the list of clubs.
  Future<void> _refreshUsers(BuildContext context) async {
    context.read<UsersManageBloc>().add(GetAllUsersRequired());
  }
}
