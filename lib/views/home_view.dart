import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_firebase/controllers/app_controller.dart';
import 'package:flutter_firebase/controllers/posts_controller.dart';
import 'package:flutter_firebase/models/post.dart';
import 'package:flutter_firebase/widgets/post_widget.dart';
import 'package:get/get.dart';

class HomeView extends StatelessWidget {
  HomeView({super.key});
  final _textController = TextEditingController();
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
          ],
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            SizedBox(
              width: Get.width - 70,
              child: TextField(
                controller: _textController,
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write your post here',
                ),
              ),
            ),
            IconButton(
              onPressed: () {
                postsController.post(
                  Post(
                    text: _textController.text,
                    userEmail: appController.currentUser.email,
                    timestamp: Timestamp.now(),
                    likes: [],
                    comments: [],
                  ),
                );
                _textController.clear();
              },
              icon: const Icon(Icons.arrow_upward_sharp),
            ),
          ],
        ),
      ),
    );
  }
}
