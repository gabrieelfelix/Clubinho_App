import 'package:club_app/routes/routes.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';
import 'package:go_router/go_router.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Text(
          'Clubinhos',
          style: TextStyle(color: context.colors.onPrimary),
        ),
        leadingWidth: 80,
        leading: SizedBox(
          child: Image.asset(
            'assets/logo_ibavin.png',
            filterQuality: FilterQuality.high,
            fit: BoxFit.contain,
          ),
        ),
        automaticallyImplyLeading: false,
        backgroundColor: context.colors.primary,
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            return Column(children: [
              const SizedBox(height: 20),
              _buildRoundedSquare(context),
              const SizedBox(height: 20),
            ]);
          },
        ),
      ),
    );
  }

  /// Section Widget
  Widget _buildRoundedSquare(BuildContext context) {
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

  /// Navigates to the manage club when the action is triggered.
  onTapManageClub(BuildContext context) {
    context.push(AppRouter.manageClub);
  }
}
