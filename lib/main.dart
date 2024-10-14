import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/view/article/byid/article_by_id_page.dart';
import 'package:jaylog/view/article/edit/article_edit_page.dart';
import 'package:jaylog/view/article/write/article_write_page.dart';
import 'package:jaylog/view/auth/join/auth_join_page.dart';
import 'package:jaylog/view/auth/login/auth_login_page.dart';
import 'package:jaylog/view/main/main_page.dart';
import 'package:jaylog/view/my/info/my_info_page.dart';
import 'package:jaylog/view/my/my_page.dart';

final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

void main() async {
  usePathUrlStrategy();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}

class MyApp extends HookConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStoreState = ref.watch(authStoreGlobal);

    useEffect(() {
      authStoreState.setLoginUser();
      return null;
    }, []);

    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      routerConfig: _router,
    );
  }
}

final GoRouter _router = GoRouter(
  navigatorKey: navigatorKey,
  initialLocation: "/",
  routes: [
    GoRoute(
      path: "/",
      builder: (BuildContext context, GoRouterState state) {
        return MainPage(
          key: UniqueKey(),
        );
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
            final id = state.pathParameters["id"];
            return ArticleByIdPage(
              id: BigInt.parse(id!),
            );
          },
          routes: [
            GoRoute(
              path: "edit",
              builder: (BuildContext context, GoRouterState state) {
                final id = state.pathParameters["id"];
                return ArticleEditPage(
                  id: BigInt.parse(id!),
                );
              },
            ),
          ],
        ),
      ],
    ),
    GoRoute(
      path: "/my",
      builder: (BuildContext context, GoRouterState state) {
        return MyPage(
          key: UniqueKey(),
        );
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
