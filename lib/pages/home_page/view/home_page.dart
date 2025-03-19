import 'package:club_app/pages/clubs_page/view/clubs_page.dart';
import 'package:club_app/pages/users_manage/view/users_manage_page.dart';
import 'package:flutter/material.dart';
import 'package:app_ui/app_ui.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return const HomeScreenView();
  }
}

class HomeScreenView extends StatelessWidget {
  const HomeScreenView({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 3,
      child: Scaffold(
        appBar: _buildAppBar(context),
        body: TabBarView(
          children: [
            Container(color: Colors.blue),
            const ClubsPage(),
            const UsersManagePage()
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context) {
    return AppBar(
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
      bottom: const TabBar(
        labelColor: Colors.black,
        tabs: [
          Tab(
            text: 'Estatisticas Gerais Dashboard',
          ),
          Tab(
            text: 'Clubinhos',
          ),
          Tab(
            text: 'Usuários',
          ),
        ],
      ),
    );
  }
}
