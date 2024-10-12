import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/auth_store.dart';

class UserInfoAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const UserInfoAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouterState = GoRouterState.of(context);
    final authStoreState = ref.watch(authStoreGlobal);
    final authStore = ref.read(authStoreGlobal);

    return AppBar(
      toolbarHeight: 75,
      shadowColor: Colors.black,
      elevation: 10.0,
      backgroundColor: Colors.white,
      title: InkWell(
        onTap: () {
          if (goRouterState.fullPath != "/") {
            GoRouter.of(context).go("/");
          }
        },
        child: const Padding(
          padding: EdgeInsets.only(top: 7),
          child: Image(
            image: AssetImage("asset/image/jaylog.png"),
            width: 100,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
