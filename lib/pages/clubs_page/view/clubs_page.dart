import 'package:app_ui/app_ui.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/clubs_page/bloc/clubs_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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

class ClubsPageView extends StatelessWidget {
  ClubsPageView({super.key});

  final TextEditingController _nameClubController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ClubsBloc, ClubsBlocState>(
      listener: _handlerListener,
      builder: _handlerBuilder,
    );
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, ClubsBlocState state) {
    if (state.isLoaded) {
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
      return const Center(child: Text('Nenhum Clubinho Vinculado!'));
    }
  }

  /// Section Widget
  _buildAlertDialog(BuildContext context) {
    final bloc = context.read<ClubsBloc>();
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
                title: const Text('Crie um clubinho'),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    SizedBox(
                      height: 50,
                      child: TextField(
                        controller: _nameClubController,
                      ),
                    ),
                    state.isLoading
                        ? const CircularProgressIndicator()
                        : const SizedBox.shrink(),
                  ],
                ),
                actions: [
                  TextButton(
                    onPressed: () {
                      context
                          .read<ClubsBloc>()
                          .add(AddClubRequired(name: _nameClubController.text));
                      Navigator.of(context).pop();
                    },
                    child: const Text('Criar'),
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
    return FloatingActionButton(
      onPressed: () => _buildAlertDialog(context),
      child: const Icon(Icons.add),
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
