import 'dart:developer';

import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/clubs_page/bloc/clubs_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_app/utils/constants.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';

class ClubsPage extends StatelessWidget {
  const ClubsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ClubsBloc(clubRepository: getIt<IClubRepository>())
        ..add(GetClubsRequired()),
      child: ClubsPageView(),
    );
  }
}

// ignore: must_be_immutable
class ClubsPageView extends StatelessWidget {
  ClubsPageView({super.key});

  final TextEditingController _inputController = TextEditingController();

  bool isCoordinatorOrAdmin = false;

  @override
  Widget build(BuildContext context) {
    final authUser =
        CacheClient.read<AuthUserModel>(key: AppConstants.userCacheKey);
    isCoordinatorOrAdmin = authUser?.userRole == UserRole.coordinator ||
        authUser?.userRole == UserRole.admin;
    return BlocConsumer<ClubsBloc, ClubsBlocState>(
      listener: _handlerListener,
      builder: _handlerBuilder,
    );
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(
    BuildContext context,
    ClubsBlocState state,
  ) {
    if (state.clubs != null) {
      return Scaffold(
        floatingActionButton: _buildFloatingActionButton(context),
        body: RefreshIndicator(
          onRefresh: () => _refreshClubs(context),
          child: ListView.builder(
            itemCount: state.clubs!.length,
            itemBuilder: (context, index) {
              return Column(
                children: [
                  const SizedBox(height: 20),
                  _buildRoundedSquare(context, state.clubs![index].name,
                      state.clubs![index].id),
                  const SizedBox(height: 20),
                ],
              );
            },
          ),
        ),
      );
    } else if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return Scaffold(
          floatingActionButton: _buildFloatingActionButton(context),
          body: const Center(child: Text('Nenhum Clubinho Vinculado!')));
    }
  }

  /// Section Widget
  _buildAlertDialog(
    BuildContext context, {
    required String title,
    required String actionLabel,
    required bool event,
  }) {
    final bloc = context.read<ClubsBloc>();
    final authUser =
        CacheClient.read<AuthUserModel>(key: AppConstants.userCacheKey);
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocConsumer<ClubsBloc, ClubsBlocState>(
            listener: (context, state) {
              if (state.isFailure) {
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text(state.message!),
                  ),
                );
              } else if (state.isCreated) {
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
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _inputController,
                      ),
                    ),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () async {
                      if (event) {
                        context.read<ClubsBloc>().add(JoinClubRequired(
                              clubInput: _inputController.text,
                              userId: authUser!.userId,
                            ));
                      } else {
                        context
                            .read<ClubsBloc>()
                            .add(AddClubRequired(name: _inputController.text));
                      }
                      _inputController.clear();
                      Navigator.of(context).pop();
                    },
                    child: Text(actionLabel),
                  ),
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Voltar'),
                  ),
                ],
              );
            },
          ),
        );
      },
    );
  }

  /// Section Widget
  Widget _buildRoundedSquare(BuildContext context, String name, String id) {
    return ElevatedButton(
      onPressed: () => onTapManageClub(context, id),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.surface.withOpacity(0.01),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          Positioned(
            top: 30,
            left: 150,
            child: Text(
              name,
              style: TextStyle(
                color: context.colors.onPrimary,
                fontSize: 20,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomLeft,
            child: SizedBox(
              child: Image.asset(
                'assets/icons/wired-outline-1531-rocking-horse-hover-pinch.png',
                filterQuality: FilterQuality.high,
                fit: BoxFit.contain,
                height: 106,
              ),
            ),
          ),
          Align(
            alignment: Alignment.bottomRight,
            child: Container(
              margin: const EdgeInsets.only(bottom: 13),
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: context.colors.surface,
                shape: BoxShape.circle,
              ),
              child: Transform(
                alignment: Alignment.center,
                transform: Matrix4.rotationZ(10.2),
                child: Icon(
                  Icons.arrow_downward_rounded,
                  color: context.colors.onSecondary,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  /// Section Widget
  Widget _buildFloatingActionButton(BuildContext context) {
    return isCoordinatorOrAdmin
        ? SpeedDial(
            animatedIcon: AnimatedIcons.menu_home,
            children: [
              SpeedDialChild(
                child: const Icon(Icons.add),
                label: 'Criar clubinho',
                onTap: () => _buildAlertDialog(
                  context,
                  title: 'Crie um clubinho',
                  actionLabel: 'Criar',
                  event: false,
                ),
              ),
              SpeedDialChild(
                child: const Icon(Icons.join_full),
                label: 'Entrar no clubinho',
                onTap: () => _buildAlertDialog(
                  context,
                  title: 'Entrar em um clubinho',
                  actionLabel: 'Entrar',
                  event: true,
                ),
              ),
            ],
          )
        : FloatingActionButton(
            onPressed: () => _buildAlertDialog(
              context,
              title: 'Entrar em um clubinho',
              actionLabel: 'Entrar',
              event: true,
            ),
            child: const Icon(Icons.join_full),
          );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, ClubsBlocState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isLoaded) {
      showCustomSnackBar(context, 'Carregado!');
    } else if (state.isCreated) {
      context.read<ClubsBloc>().add(GetClubsRequired());
      showCustomSnackBar(context, state.message!);
    } else if (state.isSuccess) {
      context.read<ClubsBloc>().add(GetClubsRequired());
      showCustomSnackBar(context, state.message!);
    }
  }

  /// Navigates to the manage club when the action is triggered.
  onTapManageClub(BuildContext context, String id) {
    context.push(AppRouter.manageClub, extra: id);
  }

  /// Refreshes the list of clubs.
  Future<void> _refreshClubs(BuildContext context) async {
    context.read<ClubsBloc>().add(GetClubsRequired());
  }
}
