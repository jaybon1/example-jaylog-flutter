import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleCard extends HookConsumerWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 20,
        left: 20,
        right: 20,
      ),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Column(
          children: [
            Image.network(
              "asset/image/no-image.png",
              fit: BoxFit.cover,
              width: double.infinity,
              height: 150,
            ),
            const ListTile(
              title: Text("Title"),
              subtitle: Text("Subtitle"),
            ),
            const Divider(),
            const ListTile(
              title: Text("Title"),
            ),
          ],
        ),
      ),
    );
  }
}
