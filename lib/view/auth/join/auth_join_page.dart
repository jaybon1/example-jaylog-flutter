import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/model/auth/dto/req/req_auth_post_join_dto.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';
import 'package:jaylog/viewmodel/auth/auth_join_view_model.dart';

class AuthJoinPage extends HookConsumerWidget {
  const AuthJoinPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final usernameController = useTextEditingController();
    final passwordController = useTextEditingController();
    final passwordCheckController = useTextEditingController();
    final simpleDescriptionController = useTextEditingController();
    final authJoinViewModelState = ref.watch(authJoinViewModelLocal);

    final usernameFocusNode = useFocusNode();
    final passwordFocusNode = useFocusNode();
    final passwordCheckFocusNode = useFocusNode();
    final simpleDescriptionFocusNode = useFocusNode();

    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            children: [
              Image.asset(
                'asset/image/jaylog.png',
                width: 200,
                height: 100,
              ),
              TextField(
                controller: usernameController,
                focusNode: usernameFocusNode,
                decoration: const InputDecoration(
                  labelText: '*아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: passwordController,
                focusNode: passwordFocusNode,
                decoration: const InputDecoration(
                  labelText: '*비밀번호',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: passwordCheckController,
                focusNode: passwordCheckFocusNode,
                decoration: const InputDecoration(
                  labelText: '*비밀번호 확인',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: simpleDescriptionController,
                focusNode: simpleDescriptionFocusNode,
                decoration: const InputDecoration(
                  labelText: '한 줄 소개',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              SizedBox(
                width: 300,
                child: TextButton(
                  onPressed: authJoinViewModelState.isPendingJoin
                      ? null
                      : () async {
                          FocusScope.of(context).unfocus();
                          if (usernameController.text.isEmpty) {
                            UtilFunction.alert(
                              context: context,
                              content: '아이디를 입력해주세요.',
                              callback: () {
                                usernameFocusNode.requestFocus();
                              },
                            );
                            return;
                          }
                          if (passwordController.text.isEmpty) {
                            UtilFunction.alert(
                              context: context,
                              content: '비밀번호를 입력해주세요.',
                              callback: () {
                                passwordFocusNode.requestFocus();
                              },
                            );
                            return;
                          }
                          if (passwordCheckController.text.isEmpty) {
                            UtilFunction.alert(
                              context: context,
                              content: '비밀번호 확인을 입력해주세요.',
                              callback: () {
                                passwordCheckFocusNode.requestFocus();
                              },
                            );
                            return;
                          }
                          if (passwordController.text !=
                              passwordCheckController.text) {
                            UtilFunction.alert(
                              context: context,
                              content: '비밀번호가 일치하지 않습니다.',
                              callback: () {
                                passwordCheckFocusNode.requestFocus();
                              },
                            );
                            return;
                          }
                          await authJoinViewModelState.postJoin(
                            reqAuthPostJoinDTO: ReqAuthPostJoinDTO.of(
                              username: usernameController.text,
                              password: passwordController.text,
                              simpleDescription:
                                  simpleDescriptionController.text,
                            ),
                            onSuccess: (message) {
                              UtilFunction.alert(
                                context: context,
                                content: message,
                                callback: () {
                                  GoRouter.of(context)
                                      .pushReplacement('/auth/login');
                                },
                              );
                            },
                          );
                        },
                  style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                      backgroundColor: Colors.blue),
                  child: authJoinViewModelState.isPendingJoin
                      ? const SizedBox(
                          width: 20,
                          height: 20,
                          child: CircularProgressIndicator(
                            strokeWidth: 3,
                          ),
                        )
                      : const Text('회원가입'),
                ),
              ),
              const Divider(),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement('/auth/login');
                },
                style: TextButton.styleFrom(
                  foregroundColor: Colors.blue,
                ),
                child: const Text('아이디가 있으신가요? 로그인'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
