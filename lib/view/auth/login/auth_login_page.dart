import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/main.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_login_dto.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';
import 'package:jaylog/viewmodel/auth/auth_login_view_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthLoginPage extends HookConsumerWidget {
  const AuthLoginPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final authStoreState = ref.watch(authStoreGlobal);
    final authLoginViewModelState = ref.watch(authLoginViewModelLocal);
    final isRemembered = useState(false);

    Future<void> requestLogin() async {
      FocusScope.of(context).unfocus();
      if (usernameController.text.isEmpty) {
        UtilFunction.alert(
          context: context,
          content: '아이디를 입력해주세요.',
        );
        return;
      }
      if (passwordController.text.isEmpty) {
        UtilFunction.alert(
          context: context,
          content: '비밀번호를 입력해주세요.',
        );
        return;
      }
      await authLoginViewModelState.postLogin(
        reqAuthPostLoginDTO: ReqAuthPostLoginDTO.of(
          username: usernameController.text,
          password: passwordController.text,
        ),
        onSuccess: (String message) async {
          if (isRemembered.value) {
            final sharedPreferences = await SharedPreferences.getInstance();
            sharedPreferences.setString("rememberedUsername", usernameController.text);
          }
          authStoreState.setLoginUser();
          GoRouter.of(navigatorKey.currentContext!).pushReplacement("/");
        },
      );
    }

    useEffect(() {
      SharedPreferences.getInstance().then((sharedPreferences) {
        final rememberedUsername = sharedPreferences.getString("rememberedUsername");
        if (rememberedUsername != null) {
          usernameController.text = rememberedUsername;
          isRemembered.value = true;
        }
      });
      return null;
    }, []);

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
                controller: usernameController,
                decoration: InputDecoration(
                  labelText: '아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: passwordController,
                obscureText: true,
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
                  onPressed: authLoginViewModelState.isPendingLogin ? null : requestLogin,
                  style: TextButton.styleFrom(
                    foregroundColor: Colors.white,
                    backgroundColor: Colors.blue,
                  ),
                  child: authLoginViewModelState.isPendingLogin
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('로그인'),
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
