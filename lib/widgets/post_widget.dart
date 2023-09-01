import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:flutter_firebase/widgets/comments_bottom_sheet.dart';
import 'package:get/get.dart';

class PostWidget extends StatelessWidget {
  final int index;
  const PostWidget({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final currentUser = Get.find<AppController>().currentUser;
    final postsController = Get.find<PostsController>();
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Card(
        elevation: 1.5,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(postsController.posts[index].userEmail),
              subtitle: Text(postsController.posts[index].text),
            ),
            SizedBox(
              height: 200,
              child: Image.network(postsController.posts[index].imageUrl),
            ),
            Row(
              children: [
                Obx(() {
                  if (postsController.posts[index].likes
                      .contains(currentUser.email)) {
                    return IconButton(
                      onPressed: () {
                        postsController.unlikePost(
                            postsController.posts[index], currentUser.email);
                      },
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                    );
                  } else {
                    return IconButton(
                      onPressed: () {
                        postsController.likePost(
                            postsController.posts[index], currentUser.email);
                      },
                      icon: const Icon(Icons.favorite_border),
                    );
                  }
                }),
                Text(postsController.posts[index].likes.length.toString()),
                const SizedBox(width: 20),
                IconButton(
                  onPressed: () {
                    // bottom sheet  for comments
                    Get.to(() => CommentsBottomSheet(index: index));
                  },
                  icon: const Icon(Icons.comment),
                ),
                Text(postsController.posts[index].comments.length.toString()),
              ],
            ),
            const SizedBox(height: 5),
          ],
        ),
      ),
    );
  }
}
