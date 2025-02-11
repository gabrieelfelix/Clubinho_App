import 'package:app_ui/app_ui.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/detail_page/cubit/detail_page_cubit.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class DetailPage extends StatelessWidget {
  const DetailPage.teacher({super.key, required this.id})
      : type = TypeInfo.teacher;

  const DetailPage.kids({super.key, required this.id}) : type = TypeInfo.kids;

  final TypeInfo type;

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => DetailPageCubit(
        type,
        clubRepository: getIt<IClubRepository>(),
      )..getInfo(
          type,
          id: id,
        ),
      child: DetailView(type: type),
    );
  }
}

class DetailView extends StatelessWidget {
  final TypeInfo type;

  const DetailView({super.key, required this.type});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<DetailPageCubit, DetailPageState>(
        listener: _handlerListener,
        builder: _handlerBuilder,
      ),
    );
  }

  /// Section Widget
  Widget kidsDetail() {
    return Container();
  }

  /// Section Widget
  Widget teacherDetail(TeachersModel model) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nome: ${model.name}'),
          Text('Email: ${model.email}'),
          Text('Telefone: ${model.contact}'),
          Text('Clubinhos que participa:\n${model.classIds}'),
        ],
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, DetailPageState state) {
    if (state.isFailure) {
      showCustomSnackBar(context, state.message!);
    } else if (state.isLoaded) {
      showCustomSnackBar(context, 'Carregado!');
    }
  }

  /// Dealing with bloc builder
  Widget _handlerBuilder(BuildContext context, DetailPageState state) {
    if (state.isLoaded) {
      return type == TypeInfo.teacher
          ? teacherDetail(state.model as TeachersModel)
          : kidsDetail();
    } else if (state.isLoading) {
      return const Center(
        child: CircularProgressIndicator(),
      );
    } else {
      return const Center(child: Text('Erro ao carregar dados!'));
    }
  }
}
