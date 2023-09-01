import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:flutter_firebase/widgets/post_or_comment_text_widget.dart';
import 'package:flutter_firebase/widgets/post_widget.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  const HomeView({super.key});
  @override
  Widget build(BuildContext context) {
    final appController = Get.find<AppController>();
    final postsController = Get.put(PostsController());
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              appController.signOut();
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: Center(
        child: Column(
          children: [
            Obx(() {
              if (postsController.posts.isEmpty) {
                return const Center(
                  child: Text('NO POSTS'),
                );
              } else {
                return Expanded(
                  child: ListView.builder(
                    itemCount: postsController.posts.length,
                    itemBuilder: ((context, index) {
                      return PostWidget(
                        index: index,
                      );
                    }),
                  ),
                );
              }
            }),
            Padding(
              padding: const EdgeInsets.all(10.0),
              child: PostOrCommentTextWidget(
                isPost: true,
                hintText: 'Write your post here',
              ),
            ),
          ],
        ),
      ),
    );
  }
}
