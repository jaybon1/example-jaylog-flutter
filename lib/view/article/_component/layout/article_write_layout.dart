import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/view/_component/appbar/default_app_bar.dart';

class ArticleWriteLayout extends HookConsumerWidget {
  final Widget body;

  const ArticleWriteLayout({Key? key, required this.body}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      // backgroundColor: CustomColor.scaffoldColor,
      backgroundColor: CustomColor.scaffoldColor,
      appBar: const DefaultAppBar(),
      body: SafeArea(
        child: body,
      ),
    );
  }
}
