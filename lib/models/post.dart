import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_firebase/models/my_comment.dart';

class Post {
  final String? id;
  final String text;
  final String userEmail;
  final Timestamp timestamp;
  final List<dynamic> likes;
  final List<dynamic> comments;
  final String imageUrl;
  Post({
    this.id,
    required this.text,
    required this.userEmail,
    required this.timestamp,
    required this.likes,
    required this.comments,
    required this.imageUrl,
  });

  static Post fromJsonId(String id, Map<String, dynamic> data) {
    final List<dynamic> comments = data['comments'].isEmpty
        ? []
        : (data['comments'] //as List<Map<String, dynamic>>)
            )
            .map((e) => MyComment.fromJson(e))
            .toList();
    return Post(
      id: id,
      text: data['text'],
      userEmail: data['user_email'],
      timestamp: data['timestamp'],
      likes: data['likes'],
      comments: comments,
      imageUrl: data['image_url'],
    );
  }

  // convert to json
  Map<String, dynamic> toJson() {
    return {
      'text': text,
      'user_email': userEmail,
      'timestamp': timestamp,
      'likes': likes,
      'comments': comments,
      'image_url': imageUrl,
    };
  }
}
