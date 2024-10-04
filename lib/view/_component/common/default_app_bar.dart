import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class DefaultAppBar extends HookConsumerWidget implements PreferredSizeWidget {
  const DefaultAppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return AppBar(
      shadowColor: Colors.black,
      elevation: 10.0,
      backgroundColor: Colors.white,
      actions: [],
      leading: IconButton(
        icon: const Image(
          image: AssetImage("asset/image/favicon-3.png"),
          width: 40,
          height: 40,
        ),
        onPressed: () {},
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(55);
}
