import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaylog/view/article/byid/article_by_id_page.dart';
import 'package:jaylog/view/article/edit/article_edit_page.dart';
import 'package:jaylog/view/article/write/article_write_page.dart';
import 'package:jaylog/view/auth/join/auth_join_page.dart';
import 'package:jaylog/view/auth/login/auth_login_page.dart';
import 'package:jaylog/view/main/main_page.dart';

void main() async {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return const MainPage();
      },
    ),
    GoRoute(
      path: "/auth",
      redirect: (BuildContext context, GoRouterState state) {
        if (state.path == "/auth") {
          return "/auth/login";
        }
        return null;
      },
      routes: [
        GoRoute(
          path: "join",
          builder: (BuildContext context, GoRouterState state) {
            return const AuthJoinPage();
          },
        ),
        GoRoute(
          path: "login",
          builder: (BuildContext context, GoRouterState state) {
            return const AuthLoginPage();
          },
        ),
      ],
    ),
    GoRoute(
      path: "/article",
      redirect: (BuildContext context, GoRouterState state) => "/",
      routes: [
        GoRoute(
          path: ":id",
          builder: (BuildContext context, GoRouterState state) {
            return const ArticleByIdPage();
          },
          routes: [
            GoRoute(
              path: "edit",
              builder: (BuildContext context, GoRouterState state) {
                return const ArticleEditPage();
              },
            ),
          ],
        ),
        GoRoute(
          path: "write",
          builder: (BuildContext context, GoRouterState state) {
            return const ArticleWritePage();
          },
        ),
      ],
    ),
  ],
);
