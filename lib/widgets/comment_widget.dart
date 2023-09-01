import 'package:flutter/material.dart';
import 'package:flutter_firebase/models/my_comment.dart';

class CommentWidget extends StatelessWidget {
  final MyComment comment;
  const CommentWidget({super.key, required this.comment});

  @override
  Widget build(BuildContext context) {
    return ListTile(
      title: Text(comment.userEmail),
      subtitle: Text(comment.comment),
    );
  }
}
