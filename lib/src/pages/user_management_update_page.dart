import 'package:arquitectura_cliente_sistema_vision/core/app/consts.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/ctrl_response.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/entities/user_entity.dart';
import 'package:arquitectura_cliente_sistema_vision/src/clean_features/widgets/custom_shimmer.dart';
import 'package:arquitectura_cliente_sistema_vision/src/controller/logic/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shimmer/shimmer.dart';

class UserManagementUpdatePage extends StatefulWidget {
  UserManagementUpdatePage({super.key});

  @override
  State<UserManagementUpdatePage> createState() => _UserManagementUpdatePageState();
}

class _UserManagementUpdatePageState extends State<UserManagementUpdatePage> {
  UserEntity? selectedUser;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: PageView(
        children: [
          _UserList(
            onChanged: (userEntity) {
              selectedUser = userEntity;
              print(userEntity);
              setState(() {});
            },
            selectedUser: selectedUser,
          )
        ],
      ),
    );
  }
}

class _UserList extends StatefulWidget {

  final UserEntity? selectedUser;
  final void Function(UserEntity? userEntity) onChanged;

  const _UserList({
    super.key,
    required this.selectedUser,
    required this.onChanged
  });

  @override
  State<_UserList> createState() => _UserListState();
}

class _UserListState extends State<_UserList> {

  late Future<CtrlResponse> _future;

  @override
  void initState() {
    super.initState();
    AuthController authController = context.read();
    _future = authController.getUsers();
  }

  @override
  Widget build(BuildContext context) {
    ThemeData theme = Theme.of(context);
    ColorScheme colorScheme = theme.colorScheme;
    TextTheme textTheme = theme.textTheme;

    return FutureBuilder(
      future: _future,
      builder: (context, snapshot) {

        if (snapshot.connectionState == ConnectionState.waiting) {
          return SizedBox(
            height: 50,
            child: CustomShimmer(
              width: double.infinity,
              height: double.infinity
            ),
          );
        }

        if (!snapshot.data!.success) {
          return Center(child: Text("No se encontraron usuarios"),);
        }

        List<UserEntity> users = snapshot.data!.element;

        return ListView.separated(
          itemCount: users.length,
          separatorBuilder: (context, index) => const SizedBox(height: 10,),
          itemBuilder: (context, index) {
            UserEntity user = users[index];

            bool selected = user == widget.selectedUser;

            return ListTile(
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
              tileColor: theme.scaffoldBackgroundColor,
              selectedTileColor: colorScheme.primary,
              title: Text(user.name, style: textTheme.bodyMedium?.copyWith(color: selected ? colorScheme.onPrimary : AppColors.grey),),
              selected: selected,
              onTap: () => widget.onChanged(user),
            );
          },
        );

      },
    );
  }
}

