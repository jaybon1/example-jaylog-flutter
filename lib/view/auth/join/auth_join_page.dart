import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';

class AuthJoinPage extends HookConsumerWidget {
  const AuthJoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Center(
          child: SizedBox(
            width: 350,
            child: Column(
              children: [
                Padding(padding: EdgeInsets.all(16)),
                Image.asset(
                  'asset/image/jaylog.png',
                  width: 200,
                  height: 100,
                ),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '*아이디',
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                const SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '*비밀번호',
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),

                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '*비밀번호 확인',
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(),
                    ),
                    obscureText: true,
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                  width: 300,
                  child: TextField(
                    decoration: InputDecoration(
                      labelText: '한줄소개',
                      contentPadding: EdgeInsets.only(left: 10, right: 10),
                      border: OutlineInputBorder(),
                    ),
                  ),
                ),
                const Padding(padding: EdgeInsets.only(bottom: 20)),
                SizedBox(
                  width: 300,
                  child: TextButton(
                    onPressed: () {
                      GoRouter.of(context).pushReplacement('/auth/login');
                    },
                    child: Text('회원가입'),
                    style: TextButton.styleFrom(
                        foregroundColor: Colors.white,
                        backgroundColor: Colors.blue),
                  ),
                ),
                Container(
                  width: 300,
                  child: Divider(),
                ),
                TextButton(
                  onPressed: () {
                    GoRouter.of(context).pushReplacement('/auth/login');
                  },
                  child: Text('아이디가 있으신가요? 로그인'),
                  style: TextButton.styleFrom(foregroundColor: Colors.blue),
                ),
                Padding(padding: EdgeInsets.all(10)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
