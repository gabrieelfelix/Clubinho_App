import 'package:app_ui/app_ui.dart';
import 'package:club_app/main.dart';
import 'package:club_app/pages/child_registration_page/cubit/child_registration_cubit.dart';
import 'package:club_repository/club_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ChildRegistrationPage extends StatelessWidget {
  const ChildRegistrationPage({super.key, required this.id});

  final String id;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          ChildRegistrationCubit(clubRepository: getIt<IClubRepository>()),
      child: ChildRegistrationView(id: id),
    );
  }
}

class ChildRegistrationView extends StatelessWidget {
  ChildRegistrationView({super.key, required this.id});

  final String id;

  final TextEditingController _fullNameController = TextEditingController();

  final TextEditingController _ageController = TextEditingController();

  final TextEditingController _birthDateController = TextEditingController();

  final TextEditingController _motherNameController = TextEditingController();

  final TextEditingController _fatherNameController = TextEditingController();

  final TextEditingController _addressController = TextEditingController();

  final TextEditingController _contactController = TextEditingController();

  final TextEditingController _observationController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Adicionar Membros'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(
            horizontal: 25,
          ),
          child: BlocListener<ChildRegistrationCubit, ChildRegistrationState>(
            listener: _handlerListener,
            child: Column(
              children: [
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Nome Completo',
                  textEditingController: _fullNameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Idade',
                  textEditingController: _ageController,
                ),
                const SizedBox(height: 20),
                // ver esse aqui o controller
                ///
                /////
                TextField(
                  controller: _birthDateController,
                  readOnly: true,
                  decoration: const InputDecoration(
                    labelText: 'Data',
                    suffixIcon: Icon(Icons.calendar_today),
                    border: OutlineInputBorder(),
                  ),
                  onTap: () => _selectDate(context),
                ),

                ///
                /////
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Nome da Mãe',
                  textEditingController: _motherNameController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Nome do Pai',
                  textEditingController: _fatherNameController,
                ),
                const SizedBox(height: 20),
                CustomTextField.box(
                  hint: 'Endereço',
                  max: 5,
                  textEditingController: _addressController,
                ),
                const SizedBox(height: 20),
                CustomTextField(
                  hint: 'Telefone Regex',
                  textEditingController: _contactController,
                ),
                const SizedBox(height: 20),
                CustomTextField.box(
                  textEditingController: _observationController,
                  hint: 'Obs',
                  max: 5,
                ),
                const SizedBox(height: 40),
                CustomButton(
                  textLabel: 'Save',
                  height: 50,
                  onPressed: () =>
                      context.read<ChildRegistrationCubit>().registationChild(
                            address: _addressController.text,
                            age: _ageController.text,
                            birthDate: _birthDateController.text,
                            contactNumber: _contactController.text,
                            fatherName: _fatherNameController.text,
                            fullName: _fullNameController.text,
                            id: id,
                            motherName: _motherNameController.text,
                            notes: _observationController.text,
                          ),
                ),
                if (context.read<ChildRegistrationCubit>().state
                    is ChildRegistrationLoading)
                  const CircularProgressIndicator(),
                const SizedBox(height: 40),
              ],
            ),
          ),
        ),
      ),
    );
  }

  /// Dealing with bloc listening
  _handlerListener(BuildContext context, ChildRegistrationState state) {
    if (state is ChildRegistrationSuccess) {
      showCustomSnackBar(context, state.message);
    } else if (state is ChildRegistrationFailure) {
      showCustomSnackBar(context, state.message);
    }
  }

  /// Dealing with Date picker
  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1900),
      lastDate: DateTime(2050),
    );

    if (picked != null) {
      _birthDateController.text = "${picked.day.toString().padLeft(2, '0')}/"
          "${picked.month.toString().padLeft(2, '0')}/"
          "${picked.year}";
    }
  }
}
