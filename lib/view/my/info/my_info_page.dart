import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jaylog/common/constant/constant.dart';
import 'package:jaylog/store/auth_store.dart';
import 'package:jaylog/util/util_function.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';
import 'package:jaylog/view/_component/layout/user_info_layout.dart';
import 'package:jaylog/viewmodel/my/my_info_view_model.dart';

class MyInfoPage extends HookConsumerWidget {
  const MyInfoPage({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authStoreState = ref.watch(authStoreGlobal);
    final myInfoViewModelState = ref.watch(myInfoViewModelLocal);

    final passwordController = useTextEditingController();
    final passwordCheckController = useTextEditingController();
    final simpleDescriptionController = useTextEditingController();

    final profileImage = useState<String>(Constant.defaultProfileImage);

    useEffect(() {
      if (authStoreState.loginUser == null) {
        UtilFunction.alert(
          context: context,
          content: "잘못된 접근입니다.",
        );
        GoRouter.of(context).go('/');
        return;
      }
      profileImage.value = authStoreState.loginUser!.profileImage;
      return null;
    }, []);

    if (authStoreState.loginUser == null) {
      return const UserInfoLayout(
        body: Center(
          child: CircularProgressIndicator(),
        ),
      );
    }

    return UserInfoLayout(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(45),
          child: Column(
            children: [
              const Text(
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
                          if (authStoreState.loginUser!.profileImage == profileImage.value || (passwordController.text.isEmpty && passwordCheckController.text.isEmpty && simpleDescriptionController.text.isEmpty)) {
                            return;
                          }

                          Future<void> temp() async {
                            final imagePicker = ImagePicker();
                            final xfile = await imagePicker.pickImage(source: ImageSource.gallery);
                            final resizedImageFile = await UtilFunction.resizeXfileImageTo50x50(xfile);
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
                controller: TextEditingController(
                  text: authStoreState.loginUser!.username,
                ),
                decoration: const InputDecoration(
                  labelText: '아이디',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                  enabled: false,
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: passwordController,
                decoration: const InputDecoration(
                  labelText: '비밀번호',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: passwordCheckController,
                decoration: const InputDecoration(
                  labelText: '비밀번호 확인',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
                obscureText: true,
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              TextField(
                controller: simpleDescriptionController,
                decoration: const InputDecoration(
                  labelText: '한줄소개',
                  contentPadding: EdgeInsets.only(left: 10, right: 10),
                  border: OutlineInputBorder(),
                ),
              ),
              const Padding(padding: EdgeInsets.only(bottom: 20)),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  SizedBox(
                    width: 100,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).pop();
                      },
                      style: TextButton.styleFrom(
                        foregroundColor: Colors.black,
                        backgroundColor: Colors.grey,
                      ),
                      child: const Text('나가기'),
                    ),
                  ),
                  SizedBox(
                    width: 150,
                    child: TextButton(
                      onPressed: () {
                        GoRouter.of(context).pushReplacement('/auth/login');
                      },
                      style: TextButton.styleFrom(foregroundColor: Colors.white, backgroundColor: Colors.blue),
                      child: const Text('수정하기'),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
