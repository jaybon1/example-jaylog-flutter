import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';

class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStoreState = ref.watch(authStoreGlobal);
    final authStore = ref.read(authStoreGlobal);
    final isRemembered = useState(false);

    // useEffect(() {
    //   authStore.logout();
    // }, []);

    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Column(
            children: [
              Image.asset(
                'asset/image/jaylog.png',
                width: 200,
                height: 100,
              ),
              TextField(
                decoration: InputDecoration(
                  labelText: '아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              Row(children: [
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
                  onPressed: () {
                    authStore.setLoginUser(
                        LoginUser(
                          username: "temp1",
                          simpleDescription: "simpleDescription",
                          profileImage: "https://picsum.photos/50",
                          roleList: ["USER"],
                        )
                    );
                    GoRouter.of(context).pushReplacement("/");
                  },
                  child: Text('로그인'),
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                ),
              ),
              Divider(),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement('/auth/join');
                },
                child: Text('아이디가 없으신가요? 회원가입'),
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
