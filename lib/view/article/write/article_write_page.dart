import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleWritePage extends HookConsumerWidget {
  const ArticleWritePage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("ArticleWrite Page"),
      ),
    );
  }
}
