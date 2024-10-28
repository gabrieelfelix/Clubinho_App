import 'package:app_ui/app_ui.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageChildren extends StatelessWidget {
  const ManageChildren({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Membros : 15'),
        actions: [IconButton(onPressed: () {}, icon: const Icon(Icons.search))],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => onTapChildRegistration(context),
        shape: const CircleBorder(),
        backgroundColor: context.colors.primary,
        child: Icon(Icons.person_add_alt_1_rounded,
            color: context.colors.onPrimary),
      ),
      body: ListView.builder(
        itemCount: 15,
        itemBuilder: (context, index) {
          return ListTile(
            leading: const Icon(Icons.person),
            title: const Text('João Guilherme'),
            subtitle: const Text('Subtítulo'),
            trailing: const Icon(Icons.arrow_forward_ios),
            onTap: () {},
          );
        },
      ),
    );
  }

  /// Navigates to the child registration when the action is triggered.
  onTapChildRegistration(BuildContext context) {
    context.push(AppRouter.childRegistration);
  }
}
