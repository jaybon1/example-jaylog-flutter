import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/appbar/_component/login_or_write_pill_button.dart';
import 'package:jaylog/view/_component/common/profile_image.dart';

class DefaultAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      toolbarHeight: 75,
      shadowColor: Colors.black,
      elevation: 10.0,
      backgroundColor: Colors.white,
      leading: IconButton(
        icon: const Image(
          image: AssetImage("asset/image/favicon-3.png"),
          width: 40,
          height: 40,
        ),
        onPressed: () {
          context.go("/");
        },
      ),
      actions: [
        Row(
          children: [
            LoginOrWritePillButton(),
            const Padding(padding: EdgeInsets.only(right: 15)),
            ProfileImage(imageUrl: "https://picsum.photos/200"),
            PopupMenuButton(
                offset: const Offset(0, 40),
                icon: const Icon(Icons.arrow_drop_down),
                padding: const EdgeInsets.only(right: 20),
                itemBuilder: (context) {
                  return [
                    PopupMenuItem(
                      child: InkWell(
                        child: Text("내 제이로그"),
                        onTap: () {
                          context.go("/my");
                        },
                      ),
                    ),
                    PopupMenuItem(
                      child: Text("로그아웃"),
                    ),
                  ];
                })
          ],
        ),
      ],
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(75);
}
