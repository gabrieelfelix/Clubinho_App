import 'package:app_ui/app_ui.dart';
import 'package:flutter/material.dart';

class ChildRegistration extends StatelessWidget {
  const ChildRegistration({super.key});

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
          child: Column(
            children: [
              const SizedBox(height: 20),
              const CustomTextField(hint: 'Nome Completo'),
              const SizedBox(height: 20),
              const CustomTextField(hint: 'Idade'),
              const SizedBox(height: 20),
              CustomTextField.suffixIcon(
                hint: 'Data de Nascimento regex',
                suffixIcon: IconButton(
                  icon: const Icon(Icons.calendar_month),
                  onPressed: () {},
                ),
              ),
              const SizedBox(height: 20),
              const CustomTextField(hint: 'Nome da Mãe'),
              const SizedBox(height: 20),
              const CustomTextField(hint: 'Nome do Pai'),
              const SizedBox(height: 20),
              const CustomTextField.box(
                hint: 'Endereço',
                max: 5,
              ),
              const SizedBox(height: 20),
              const CustomTextField(hint: 'Telefone Regex'),
              const SizedBox(height: 20),
              const CustomTextField.box(
                hint: 'Obs',
                max: 5,
              ),
              const SizedBox(height: 40),
              CustomButton(
                textLabel: 'Save',
                height: 50,
                onPressed: () {},
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
