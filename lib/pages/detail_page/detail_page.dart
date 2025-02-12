import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';

class DetailPage extends StatelessWidget {
  const DetailPage.teacher({super.key, required this.teachersModel})
      : childModel = KidsModel.empty,
        isTeacher = true;

  const DetailPage.kids({super.key, required this.childModel})
      : teachersModel = TeachersModel.empty,
        isTeacher = false;

  final TeachersModel teachersModel;

  final KidsModel childModel;

  final bool isTeacher;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: isTeacher
            ? teacherDetail(teachersModel)
            : //
            kidsDetail(childModel));
  }

  /// Section Widget
  Widget kidsDetail(KidsModel model) {
    return SizedBox.expand(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('Nome: ${model.fullName}'),
          Text('Idade:\n${model.age}'),
          Text('Data de nascimento: ${model.birthDate}'),
          Text('Nome do pai: ${model.fatherName}'),
          Text('Nome da mãe: ${model.motherName}'),
          Text('Contato: ${model.contactNumber}'),
          Text('Endereço: ${model.address}'),
          Text('Obs: ${model.notes}'),
        ],
      ),
    );
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
}
