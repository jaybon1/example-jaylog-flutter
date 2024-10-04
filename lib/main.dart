import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:jaylog/view/article/byid/article_by_id_page.dart';
import 'package:jaylog/view/article/edit/article_edit_page.dart';
import 'package:jaylog/view/article/write/article_write_page.dart';
import 'package:jaylog/view/auth/join/auth_join_page.dart';
import 'package:jaylog/view/auth/login/auth_login_page.dart';
import 'package:jaylog/view/main/main_page.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:jaylog/view/my/info/my_info_page.dart';
import 'package:jaylog/view/my/my_page.dart';

void main() async {
  usePathUrlStrategy();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
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
        if (state.fullPath == "/auth") {
          return "/auth/login";
        }
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
      redirect: (BuildContext context, GoRouterState state) {
        // print(state.pathParameters);
        if (state.fullPath == "/article") {
          return "/";
        }
      },
      routes: [
        GoRoute(
          path: "write",
          builder: (BuildContext context, GoRouterState state) {
            return const ArticleWritePage();
          },
        ),
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
      ],
    ),
    GoRoute(
      path: "/my",
      builder: (BuildContext context, GoRouterState state) {
        return const MyPage();
      },
      routes: [
        GoRoute(
          path: "info",
          builder: (BuildContext context, GoRouterState state) {
            return const MyInfoPage();
          },
        ),
      ],
    ),
  ],
);
