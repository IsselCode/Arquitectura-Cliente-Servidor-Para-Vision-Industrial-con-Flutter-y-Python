import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/asset_container.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/tab_switcher.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/user_management_create_page.dart';
import 'package:arquitectura_cliente_sistema_vision/src/pages/user_management_update_page.dart';
import 'package:flutter/material.dart';

class UserManagementView extends StatefulWidget {
  const UserManagementView({super.key});

  @override
  State<UserManagementView> createState() => _UserManagementViewState();
}

class _UserManagementViewState extends State<UserManagementView> {

  PageController pageController = PageController();
  TabSwitcherAlignStates state = TabSwitcherAlignStates.left;

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    TextTheme textTheme = theme.textTheme;
    ColorScheme colorScheme = theme.colorScheme;

    return Scaffold(
      body: Center(
        child: Container(
          width: 350,
          height: 500,
          padding: EdgeInsets.all(20),
          decoration: BoxDecoration(
            color: colorScheme.surface,
            borderRadius: BorderRadius.circular(24)
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            spacing: 40,
            children: [
              AssetContainer(asset: AppAssets.logo, width: 64, height: 64,),
              TabSwitcher(
                state: state,
                leftText: "Crear",
                rightText: "Actualizar",
                onChanged: changePage,
                color: theme.scaffoldBackgroundColor,
              ),
              // Paginas
              Expanded(
                child: PageView(
                  controller: pageController,
                  children: [
                    UserManagementCreatePage(),
                    UserManagementUpdatePage()
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  void changePage(TabSwitcherAlignStates value) {

    Duration duration = Duration(milliseconds: 350);
    Curve curve = Curves.linearToEaseOut;

    switch (value) {
      case TabSwitcherAlignStates.left:
        pageController.animateToPage(0, duration: duration, curve: curve);
      case TabSwitcherAlignStates.right:
        pageController.animateToPage(1, duration: duration, curve: curve);
    }

    state = value;
    setState(() {});

  }

}
