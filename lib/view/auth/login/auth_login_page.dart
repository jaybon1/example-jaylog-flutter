import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';

class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final isRemembered = useState(false);

    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Padding(padding: EdgeInsets.all(16)),
            Image.asset(
              'asset/image/jaylog.png',
              width: 200,
              height: 100,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              width: 300,
              child: TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
            ),
            Row(children: [
              Padding(padding: EdgeInsets.only(left: 43)),
              Checkbox(
                value: isRemembered.value,
                onChanged: (bool? value) {
                  isRemembered.value = !isRemembered.value;
                },
              ),
              Text('아이디 기억하기'),
            ]),
            SizedBox(
              width: 300,
              child: TextButton(
                onPressed: () {},
                child: Text('로그인'),
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
                GoRouter.of(context).pushReplacement('/auth/join');
              },
              child: Text('아이디가 없으신가요? 회원가입'),
              style: TextButton.styleFrom(foregroundColor: Colors.blue),
            ),
            Padding(padding: EdgeInsets.all(10)),
          ],
        ),
      ),
    );
  }
}
