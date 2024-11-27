import 'package:club_app/main.dart';
import 'package:club_app/pages/home_page/bloc/home_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:go_router/go_router.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(clubRepository: getIt<IClubRepository>())
        ..add(GetClubsRequired()),
      child: HomeScreenView(),
    );
  }
}

class HomeScreenView extends StatelessWidget {
  HomeScreenView({super.key});

  final TextEditingController _nameClubController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () => _buildAlertDialog(context),
        child: const Icon(Icons.add),
      ),
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Clubinhos',
          style: TextStyle(color: context.colors.onPrimary),
        ),
        leadingWidth: 80,
        leading: SizedBox(
          child: Image.asset(
            ImageConstant.logoIbavin,
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: context.colors.primary,
      ),
      body: SafeArea(
        child: BlocConsumer<HomeBloc, HomeBlocState>(
          listener: (context, state) {
            if (state.isFailure) {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(state.message!),
                ),
              );
            } else if (state.isLoaded) {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(
                  content: Text('Carregado'),
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
            if (state.isLoaded) {
              return RefreshIndicator(
                onRefresh: () => _onRefresh(context),
                child: ListView.builder(
                  itemCount: state.clubs!.length,
                  itemBuilder: (context, index) {
                    return Column(
                      children: [
                        const SizedBox(height: 20),
                        _buildRoundedSquare(context, state.clubs![index].name),
                        const SizedBox(height: 20),
                      ],
                    );
                  },
                ),
              );
            } else if (state.isLoading) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return const Center(child: Text('Nenhum Clubinho Vinculado!'));
            }
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRoundedSquare(BuildContext context, String name) {
    return ElevatedButton(
      onPressed: () => onTapManageClub(context),
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
  _buildAlertDialog(BuildContext context) {
    return showDialog(
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: context.read<HomeBloc>(),
          child: BlocConsumer<HomeBloc, HomeBlocState>(
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
                          .read<HomeBloc>()
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

  /// Navigates to the manage club when the action is triggered.
  onTapManageClub(BuildContext context) {
    context.push(AppRouter.manageClub);
  }

  _onRefresh(BuildContext context) async {
    context.read<HomeBloc>().add(GetClubsRequired());
  }
}
