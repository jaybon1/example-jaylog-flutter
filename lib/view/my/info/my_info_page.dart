import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';

class MyInfoPage extends HookConsumerWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final profileImage = useState<String>("https://picsum.photos/50");

    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(45),
          child: Column(
            children: [
              Text(
                "내 정보 수정",
                style: TextStyle(
                  fontSize: 30,
                ),
              ),
              CircleProfileImage(
                imageUrl: profileImage.value,
                radius: 50,
              ),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Container(
                  width: double.infinity,
                  height: 40,
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          Future<void> temp() async {
                            final imagePicker = ImagePicker();
                            final xfile = await imagePicker.pickImage(
                                source: ImageSource.gallery);
                            final resizedImageFile =
                                await UtilFunction.resizeXfileImageTo50x50(
                                    xfile);
                            profileImage.value = resizedImageFile.path;
                          }

                          temp();

                          // final imagePicker = ImagePicker();
                          // imagePicker.pickImage(source: ImageSource.gallery)
                          // .then((xfile) {
                          //   UtilFunction.resizeXfileImageTo50x50(xfile)
                          //
                          //
                          //
                          // })
                          // .catchError((e) {
                          //   print(e);
                          // });
                        },
                        child: Text(
                          "프로필 이미지 선택",
                          style: TextStyle(
                            fontSize: 20,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              TextField(
                controller: TextEditingController(text: "temp1"),
                decoration: InputDecoration(
                  labelText: '아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                  enabled: false,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                decoration: InputDecoration(
                  labelText: '비밀번호 확인',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                decoration: InputDecoration(
                  labelText: '한줄소개',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
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
              const Divider(),
              TextButton(
                onPressed: () {
                  GoRouter.of(context).pushReplacement('/auth/login');
                },
                child: Text('아이디가 있으신가요? 로그인'),
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
