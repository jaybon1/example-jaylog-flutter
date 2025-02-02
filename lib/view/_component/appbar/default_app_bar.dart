import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';

class DefaultAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final goRouterState = GoRouterState.of(context);
    final authStoreState = ref.watch(authStoreGlobal);

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
      actions: [
        Row(
          children: [
            authStoreState.loginUser != null
                ? Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          GoRouter.of(context).push("/article/write");
                        },
                        child: const Text("새 글 작성"),
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 15)),
                      CircleProfileImage(imageUrl: authStoreState.loginUser?.profileImage),
                      PopupMenuButton(
                          offset: const Offset(0, 40),
                          icon: const Icon(Icons.arrow_drop_down),
                          padding: const EdgeInsets.only(right: 20),
                          itemBuilder: (context) {
                            return [
                              PopupMenuItem(
                                onTap: () {
                                  if (goRouterState.fullPath != "/my") {
                                    GoRouter.of(context).push("/my");
                                  }
                                },
                                child: Text("내 제이로그"),
                              ),
                              PopupMenuItem(
                                onTap: () {
                                  authStoreState.logout();
                                  GoRouter.of(context).pushReplacement("/");
                                },
                                child: Text("로그아웃"),
                              ),
                            ];
                          })
                    ],
                  )
                : Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (goRouterState.fullPath != "/auth/login") {
                            authStoreState.logout();
                            GoRouter.of(context).go("/auth/login");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          foregroundColor: Colors.white,
                          backgroundColor: Colors.black,
                          textStyle: const TextStyle(
                            fontSize: 16,
                          ),
                        ),
                        child: const Text("로그인"),
                      ),
                      const Padding(padding: EdgeInsets.only(right: 15)),
                    ],
                  )
          ],
        )
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
