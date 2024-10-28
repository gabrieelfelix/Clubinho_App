import 'package:app_ui/app_ui.dart';
import 'package:club_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ManageClub extends StatelessWidget {
  const ManageClub({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        // leading: SizedBox(
        //   child: Image.asset(
        //     'assets/logo_ibavin.png',
        //     filterQuality: FilterQuality.high,
        //     fit: BoxFit.contain,
        //   ),
        // ),
        title: Text(
          'Configurações',
          style: TextStyle(color: context.colors.onPrimary),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: context.colors.primary,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 0),
          child: GridView.builder(
            gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2,
              childAspectRatio: 1,
              crossAxisSpacing: 1.5,
              mainAxisSpacing: 1.5,
            ),
            padding: const EdgeInsets.all(10),
            itemCount: 8,
            itemBuilder: (context, index) => _buildRoundedSquare(context),
          ),
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRoundedSquare(BuildContext context) {
    return ElevatedButton(
      onPressed: () => onTapManageChildren(context),
      style: ElevatedButton.styleFrom(
        backgroundColor: context.colors.onSurface.withOpacity(0),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(50.0),
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Text(
              'Crianças',
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

  /// Navigates to the manage children when login is performed.
  onTapManageChildren(BuildContext context) {
    context.push(AppRouter.manageChildren);
  }
}
