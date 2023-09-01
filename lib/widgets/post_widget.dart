import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:flutter_firebase/models/my_comment.dart';
import 'package:flutter_firebase/widgets/comment_widget.dart';
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
              ],
            ),
            const SizedBox(height: 5),
            if (postsController.posts[index].comments.isNotEmpty)
              const Text(
                '     Comments',
                style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
              ),
            const SizedBox(height: 5),
            // Container(
            //   margin: const EdgeInsets.only(left: 30),
            //   child: SizedBox(
            //     height: postsController.posts[index].comments.length * 50.0,
            //     child: ListView.builder(
            //       itemCount: postsController.posts[index].comments.length,
            //       itemBuilder: (context, idx) {
            //         return CommentWidget(
            //           comment: postsController.posts[index].comments[idx],
            //         );
            //       },
            //     ),
            //   ),
            // ),
            Container(
              margin: const EdgeInsets.only(left: 30),
              child: Column(
                children: [
                  for (MyComment comment
                      in postsController.posts[index].comments)
                    CommentWidget(comment: comment)
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
