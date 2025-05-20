import 'package:app_ui/app_ui.dart';
import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/pages/clubs_page/bloc/clubs_bloc.dart';
import 'package:club_app/routes/routes.dart';
import 'package:club_app/utils/constants.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:go_router/go_router.dart';
import 'package:loading_animation_widget/loading_animation_widget.dart';

// class ClubsPage extends StatelessWidget {
//   const ClubsPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return BlocProvider(
//       create: (context) => ClubsBloc(clubRepository: getIt<IClubRepository>())
//         ..add(GetClubsRequired()),
//       child: ClubsPageView(),
//     );
//   }
// }

//? TO DO
//? Loading Shimmer
//? Responsive layout
//? Regex pra mais de um espaço
//? Imagem legal quando estiver sem clubinho
//! quando o textfield do criar/entrar num clubinho da erro ele nao tira o erro quando digita
//! quando um clubinho é deletado quando voltamos pra tela de clubinhos ele nao some
//! qu8ando entrar em um clubinho o feedback ta funcionando direito?
// ignore: must_be_immutable
class ClubsPageView extends StatelessWidget {
  ClubsPageView({super.key});

  final TextEditingController _nameController = TextEditingController();

  final TextEditingController _codeController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

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
      barrierDismissible: false,
      context: context,
      builder: (BuildContext context) {
        return BlocProvider.value(
          value: bloc,
          child: BlocConsumer<ClubsBloc, ClubsBlocState>(
            listener: _handlerListenerDialog,
            builder: (context, state) {
              return AlertDialog(
                actionsAlignment: MainAxisAlignment.center,
                backgroundColor: context.theme.colorScheme.onPrimary,
                title: Text(
                  title,
                  style: context.text.headlineMedium?.copyWith(
                    color: context.colors.onSecondary,
                  ),
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.r),
                  side: BorderSide(
                    color: context.colors.surface,
                    width: 2.w,
                  ),
                ),
                content: Form(
                  key: _formKey,
                  child: event
                      ? Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              // height: 40.h,
                              child: CustomTextField(
                                hint: 'Código do CLubinho',
                                textInputAction: TextInputAction.next,
                                textEditingController: _codeController,
                                validator: (vl) =>
                                    state.code.validator(vl ?? '')?.text(),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            if (state.isLoading)
                              LoadingAnimationWidget.waveDots(
                                color: context.colors.primary,
                                size: 30.sp,
                              )
                          ],
                        )
                      : Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            SizedBox(
                              // height: 40.h,
                              child: CustomTextField(
                                hint: 'Nome',
                                textInputAction: TextInputAction.next,
                                textEditingController: _nameController,
                                validator: (vl) =>
                                    state.name.validator(vl ?? '')?.text(),
                              ),
                            ),
                            SizedBox(height: 20.h),
                            SizedBox(
                              child: CustomTextField(
                                hint: 'Endereço',
                                maxLines: 3,
                                textInputAction: TextInputAction.next,
                                textEditingController: _addressController,
                                validator: (vl) =>
                                    state.address.validator(vl ?? '')?.text(),
                              ),
                            ),
                            SizedBox(height: 15.h),
                            if (state.isLoading)
                              LoadingAnimationWidget.waveDots(
                                color: context.colors.primary,
                                size: 30.sp,
                              )
                          ],
                        ),
                ),
                actions: [
                  ConstrainedBox(
                    constraints: BoxConstraints(
                      maxWidth: 245.h,
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Expanded(
                          child: CustomButton.pop(
                            label: 'Voltar',
                            isLoading: false,
                            height: 35.h,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                          ),
                        ),
                        SizedBox(width: 12.w),
                        Expanded(
                          child: CustomButton(
                            label: actionLabel,
                            isLoading: false,
                            height: 35.h,
                            onPressed: () async {
                              if (_formKey.currentState!.validate()) {
                                if (event) {
                                  context.read<ClubsBloc>().add(
                                        JoinClubRequired(
                                          clubInput: _codeController.text,
                                          userId: authUser!.userId,
                                        ),
                                      );
                                } else {
                                  context.read<ClubsBloc>().add(
                                        AddClubRequired(
                                          name: _nameController.text,
                                          address: _addressController.text,
                                        ),
                                      );
                                }
                              }
                            },
                          ),
                        ),
                      ],
                    ),
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
            animatedIcon: AnimatedIcons.menu_close,
            spacing: 10.h,
            spaceBetweenChildren: 10.h,
            childrenButtonSize: Size(47.w, 47.h),
            children: [
              SpeedDialChild(
                shape: const CircleBorder(),
                child: const Icon(Icons.add),
                label: 'Criar Clubinho',
                labelStyle: context.text.labelSmall?.copyWith(fontSize: 13.sp),
                onTap: () => _buildAlertDialog(
                  context,
                  title: 'Novo Clubinho Bíblico',
                  actionLabel: 'Criar',
                  event: false,
                ),
              ),
              SpeedDialChild(
                shape: const CircleBorder(),
                child: const Icon(Icons.join_full),
                label: 'Entrar no Clubinho',
                labelStyle: context.text.labelSmall?.copyWith(fontSize: 13.sp),
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
      showCustomSnackBar(
        context,
        state.message!,
        type: SnackBarType.error,
      );
    } else if (state.isLoading) {
      // showCustomSnackBar(
      //   context,
      //   'Carregado!',
      //   type: SnackBarType.success,
      // );
    } else if (state.isCreated) {
      context.read<ClubsBloc>().add(GetClubsRequired());
      showCustomSnackBar(
        context,
        state.message!,
        type: SnackBarType.success,
      );
    } else if (state.isSuccess) {
      context.read<ClubsBloc>().add(GetClubsRequired());
      showCustomSnackBar(
        context,
        state.message!,
        type: SnackBarType.success,
      );
    }
  }

  /// Dealing with bloc listening
  _handlerListenerDialog(BuildContext context, ClubsBlocState state) {
    if (state.isFailure) {
      Navigator.of(context).pop();
    } else if (state.isLoading) {
      FocusManager.instance.primaryFocus?.unfocus();
    } else if (state.isCreated) {
      context.read<ClubsBloc>().add(GetClubsRequired());

      Navigator.of(context).pop();
    } else if (state.isSuccess) {
      context.read<ClubsBloc>().add(GetClubsRequired());
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
