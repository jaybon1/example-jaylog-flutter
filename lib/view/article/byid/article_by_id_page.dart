import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleByIdPage extends HookConsumerWidget {
  const ArticleByIdPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return const Scaffold(
      body: Center(
        child: Text("ArticleById Page"),
      ),
    );
  }
}
