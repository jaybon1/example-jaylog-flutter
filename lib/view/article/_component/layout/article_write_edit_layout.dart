import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/view/article/_component/appbar/article_write_edit_app_bar.dart';

class ArticleWriteEditLayout extends HookConsumerWidget {
  final Widget body;

  const ArticleWriteEditLayout({Key? key, required this.body})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      backgroundColor: CustomColor.scaffoldColor,
      extendBodyBehindAppBar: false,
      appBar: const WriteEditAppBar(),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
