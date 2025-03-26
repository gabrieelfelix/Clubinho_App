import 'package:authentication_repository/authentication_repository.dart';
import 'package:club_app/pages/clubs_page/view/clubs_page.dart';
import 'package:club_app/pages/users_manage/view/users_manage_page.dart';
import 'package:club_app/utils/constants.dart';
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
    final authUser =
        CacheClient.read<AuthUserModel>(key: AppConstants.userCacheKey);
    final bool isAdmin = authUser?.userRole == UserRole.admin;

    // Define o número de tabs com base na role
    final int tabCount = isAdmin ? 4 : 3;
    return DefaultTabController(
      length: tabCount,
      child: Scaffold(
        appBar: _buildAppBar(context, isAdmin),
        body: TabBarView(
          children: [
            Container(color: Colors.blue),
            const ClubsPage(),
            if (isAdmin) const UsersManagePage(),
            Container(
              color: Colors.red,
            )
          ],
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar(BuildContext context, bool isAdmin) {
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
      actions: const [
        Padding(
            padding: EdgeInsets.only(right: 15),
            child: Icon(
              Icons.notifications,
              color: Colors.white,
            ))
      ],
      automaticallyImplyLeading: false,
      backgroundColor: context.colors.primary,
      bottom: TabBar(
        labelColor: Colors.black,
        tabs: [
          const Tab(
            text: 'Estatisticas Gerais Dashboard',
          ),
          const Tab(
            text: 'Clubinhos',
          ),
          if (isAdmin)
            const Tab(
              text: 'Usuários',
            ),
          const Tab(
            text: 'Conta',
          ),
        ],
      ),
    );
  }
}
