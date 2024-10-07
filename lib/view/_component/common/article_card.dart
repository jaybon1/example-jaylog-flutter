import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/profile_image.dart';

class ArticleCard extends HookConsumerWidget {
  const ArticleCard({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Padding(
      padding: const EdgeInsets.only(
        top: 15,
        left: 15,
        right: 15,
      ),
      child: Card(
        elevation: 4.0,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(5.0),
        ),
        clipBehavior: Clip.antiAliasWithSaveLayer,
        child: Container(
          color: Colors.white,
          child: Column(
            children: [
              Image.asset(
                "asset/image/no-image.png",
                fit: BoxFit.cover,
                width: double.infinity,
                height: 150,
              ),
              // Image.network(
              //   "asset/image/no-image.png",
              //   fit: BoxFit.cover,
              //   width: double.infinity,
              //   height: 150,
              // ),
              const ListTile(
                titleTextStyle: TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                title: Padding(
                  padding: EdgeInsets.only(top: 5, bottom: 5),
                  child: Text(
                    "[번역] Node.js 개요: 아키텍처, API, 이벤트",
                    overflow: TextOverflow.ellipsis,
                    maxLines: 1,
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(bottom: 18),
                      child: Text(
                        "4.1 Node.js 플랫폼4.1.1 Node.js 전역 변수4.1.2 Node.js 내장 모듈4.1.3 Node.js 함수의 다양한 스타일4.2 Node.js 이벤트 루프4.2.1 실행을 완료하면 코드가 더 간단해집니다4.2.2 Node.js 코드가 싱글 스레드에서",
                        style: TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.only(bottom: 15),
                      child: Text(
                        "2024-10-01T19:18:27.565936",
                        style: TextStyle(color: Colors.grey),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 1,
                      ),
                    ),
                  ],
                ),
              ),
              const Divider(
                height: 1,
              ),
              const ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        ProfileImage(
                          imageUrl: "https://picsum.photos/200",
                          radius: 15,
                        ),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text(
                            "temp1",
                            style: TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        )
                      ],
                    ),
                    Row(
                      children: [
                        // Icon(Icons.favorite_border),
                        Icon(Icons.favorite, color: Colors.red,),
                        Padding(
                          padding: EdgeInsets.only(left: 5),
                          child: Text("0"),
                        )
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
