import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:get/get.dart';

import '../models/my_comment.dart';
import '../models/post.dart';

class PostOrCommentTextWidget extends StatelessWidget {
  final Post? post;
  final String hintText;
  final bool isPost;
  PostOrCommentTextWidget(
      {super.key, required this.hintText, required this.isPost, this.post});
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final postsController = Get.find<PostsController>();
    final appController = Get.find<AppController>();
    String imageUrl = '';
    return Row(
      children: [
        SizedBox(
          width: isPost ? Get.width - 120 : Get.width - 70,
          child: TextField(
            controller: _textController,
            decoration: InputDecoration(
              border: const OutlineInputBorder(),
              hintText: hintText,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            if (_textController.text.isEmpty) {
              return;
            }
            if (isPost) {
              postsController.post(
                Post(
                    text: _textController.text,
                    userEmail: appController.currentUser.email,
                    timestamp: Timestamp.now(),
                    likes: [],
                    comments: [],
                    imageUrl: imageUrl),
              );
              _textController.clear();
            } else {
              postsController.comment(
                post!,
                MyComment(
                  userEmail: appController.currentUser.email,
                  comment: _textController.text,
                  createdAt: Timestamp.now(),
                ),
              );
              _textController.clear();
            }
          },
          icon: const Icon(Icons.arrow_upward_sharp),
        ),
        if (isPost)
          IconButton(
            onPressed: () async {
              imageUrl = await postsController.uploadImage();
            },
            icon: const Icon(Icons.image),
          )
      ],
    );
  }
}
