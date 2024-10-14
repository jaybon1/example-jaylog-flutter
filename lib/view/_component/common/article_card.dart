import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:jaylog/view/_component/common/circle_profile_image.dart';

class ArticleCard extends HookConsumerWidget {
  final BigInt id;
  final String username;
  final String profileImage;
  final String title;
  final String? thumbnail;
  final String summary;
  final int likeCount;
  final bool isLikeClicked;
  final DateTime createDate;

  const ArticleCard({
    super.key,
    required this.id,
    required this.username,
    required this.profileImage,
    required this.title,
    required this.thumbnail,
    required this.summary,
    required this.likeCount,
    required this.isLikeClicked,
    required this.createDate,
  });

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
              thumbnail == null
                  ? Image.asset(
                      "asset/image/no-image.png",
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    )
                  : Image.network(
                      thumbnail!,
                      fit: BoxFit.cover,
                      width: double.infinity,
                      height: 150,
                    ),
              ListTile(
                titleTextStyle: const TextStyle(
                  fontSize: 20,
                  color: Colors.black,
                ),
                title: Padding(
                  padding: const EdgeInsets.only(top: 5, bottom: 5),
                  child: InkWell(
                    onTap: () {
                      GoRouter.of(context).push("/article/$id");
                    },
                    child: Text(
                      title,
                      overflow: TextOverflow.ellipsis,
                      maxLines: 1,
                    ),
                  ),
                ),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(bottom: 18),
                      child: Text(
                        summary,
                        style: const TextStyle(fontSize: 16),
                        overflow: TextOverflow.ellipsis,
                        maxLines: 4,
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 15),
                      child: Text(
                        createDate.toString(),
                        style: const TextStyle(color: Colors.grey),
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
              ListTile(
                title: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleProfileImage(
                          imageUrl: profileImage,
                          radius: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            username,
                            style: const TextStyle(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ],
                    ),
                    Row(
                      children: [
                        // Icon(Icons.favorite_border),
                        isLikeClicked
                            ? const Icon(
                                Icons.favorite,
                                color: Colors.red,
                              )
                            : const Icon(
                                Icons.favorite_border,
                                color: Colors.grey,
                              ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            likeCount.toString(),
                          ),
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
