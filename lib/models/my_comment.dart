import 'package:cloud_firestore/cloud_firestore.dart';

class MyComment {
  String userEmail;
  String comment;
  Timestamp createdAt;
  // List<MyComment> replies;
  MyComment({
    required this.userEmail,
    required this.comment,
    //required this.replies,
    required this.createdAt,
  });

  static MyComment fromJson(Map<String, dynamic> json) {
    return MyComment(
      userEmail: json['user_email'],
      comment: json['comment'],
      //replies: json['replies'],
      createdAt: json['created_at'],
    );
  }
}
