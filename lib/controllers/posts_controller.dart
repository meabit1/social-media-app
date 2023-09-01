import 'dart:async';
import 'dart:io';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/my_comment.dart';
import 'package:flutter_firebase/models/post.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class PostsController extends GetxController {
  final String postsPath = 'posts';

  StreamSubscription<QuerySnapshot>? _streamSubscription;

  // reactive fields
  final Rx<List<Post>> _posts = Rx<List<Post>>(<Post>[]);
  List<Post> get posts => _posts.value;
  comment(Post post, MyComment comment) {
    FirebaseFirestore.instance.collection(postsPath).doc(post.id).update({
      'comments': [
        ...post.comments.map((e) => (e as MyComment).toJson()).toList(),
        comment.toJson()
      ]
    });
  }

  Future<String> uploadImage() async {
    final ImagePicker imagePicker = ImagePicker();
    final response = await imagePicker.pickImage(source: ImageSource.gallery);
    if (response == null) {
      return '';
    }
    final file = File(response.path);
    final ref =
        FirebaseStorage.instance.ref().child('images/${DateTime.now()}.png');
    final task = ref.putFile(file);
    final snapshot = await task.whenComplete(() => null);
    if (snapshot.state == TaskState.success) {
      return await ref.getDownloadURL();
    } else {
      return '';
    }
  }

  post(Post post) {
    FirebaseFirestore.instance.collection(postsPath).add(post.toJson());
  }

  likePost(Post post, email) {
    FirebaseFirestore.instance.collection(postsPath).doc(post.id).update({
      'likes': [...post.likes, email]
    });
  }

  unlikePost(Post post, email) {
    FirebaseFirestore.instance.collection(postsPath).doc(post.id).update(
      {'likes': post.likes.where((element) => element != email).toList()},
    );
  }

  @override
  void onInit() {
    _subscribeToData();
    super.onInit();
  }

  @override
  void onClose() {
    _streamSubscription!.cancel();
    super.onClose();
  }

  void _subscribeToData() {
    _streamSubscription = FirebaseFirestore.instance
        .collection(postsPath)
        .orderBy('timestamp', descending: true)
        .snapshots()
        .listen((snapshot) {
      _posts.value = snapshot.docs
          .map((doc) => Post.fromJsonId(doc.id, doc.data()))
          .toList();
    });
  }
}
