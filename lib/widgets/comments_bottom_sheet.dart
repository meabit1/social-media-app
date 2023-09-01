import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:flutter_firebase/widgets/post_or_comment_text_widget.dart';
import 'package:get/get.dart';

import '../models/my_comment.dart';
import 'comment_widget.dart';

class CommentsBottomSheet extends StatelessWidget {
  final int index; // index of the comment
  const CommentsBottomSheet({super.key, required this.index});

  @override
  Widget build(BuildContext context) {
    final postsController = Get.find<PostsController>();
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Comments',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
                ),
                const SizedBox(height: 5),
                Container(
                    margin: const EdgeInsets.only(left: 30),
                    child: Obx(() {
                      return Column(
                        children: [
                          for (MyComment comment
                              in postsController.posts[index].comments)
                            CommentWidget(comment: comment)
                        ],
                      );
                    })),
                PostOrCommentTextWidget(
                  isPost: false,
                  hintText: 'Write your comment here',
                  post: postsController.posts[index],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
