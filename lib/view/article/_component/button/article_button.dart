import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

class ArticleButton extends HookConsumerWidget {
  final Widget child;
  final VoidCallback? onPressed;
  final Color? color;

  const ArticleButton({
    super.key,
    required this.child,
    this.onPressed,
    this.color = Colors.grey,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ElevatedButton(
      style: ButtonStyle(
        shape: WidgetStatePropertyAll(
          RoundedRectangleBorder(
            side: BorderSide(color: color ?? Colors.grey),
            borderRadius: BorderRadius.circular(10),
          ),
        ),
      ),
      onPressed: onPressed,
      child: child,
    );
  }
}
