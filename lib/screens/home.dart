import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_firebase/blocs/app/app_bloc.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});
  static Page page() => MaterialPage<void>(child: HomeScreen());
  final _textController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final user = context.select((AppBloc bloc) => bloc.state.user);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home'),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              context.read<AppBloc>().add(AppLogoutEvent());
            },
            icon: const Icon(Icons.exit_to_app),
          )
        ],
      ),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('posts')
            .orderBy('timestamp', descending: true)
            .snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return ListView.builder(
              itemCount: snapshot.data!.docs.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Card(
                    elevation: 1.4,
                    child: Column(
                      children: [
                        ListTile(
                          title: Text(
                              snapshot.data!.docs[index].data()['user_email'] ??
                                  ''),
                          subtitle: Text(
                            snapshot.data!.docs[index].data()['text'] ?? '',
                          ),
                        ),
                        Row(
                          children: [
                            IconButton(
                              onPressed: () {
                                final List likes = snapshot.data!.docs[index]
                                    .data()['likes'] as List;
                                if (!likes.contains(user.email)) {
                                  FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(snapshot.data!.docs[index].id)
                                      .update({
                                    'likes': [
                                      ...snapshot.data!.docs[index]
                                          .data()['likes'],
                                      user.email
                                    ],
                                  });
                                } else {
                                  likes.remove(user.email);
                                  FirebaseFirestore.instance
                                      .collection('posts')
                                      .doc(snapshot.data!.docs[index].id)
                                      .update({
                                    'likes': likes,
                                  });
                                }
                              },
                              icon: (snapshot.data!.docs[index].data()['likes']
                                          as List)
                                      .contains(user.email)
                                  ? const Icon(Icons.favorite)
                                  : const Icon(Icons.favorite_border),
                            ),
                            Text(
                              snapshot.data!.docs[index]
                                  .data()['likes']
                                  .length
                                  .toString(),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
      bottomNavigationBar: Row(
        children: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: SizedBox(
              width: MediaQuery.of(context).size.width - 80,
              child: TextField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(),
                  hintText: 'Write a post',
                ),
                controller: _textController,
              ),
            ),
          ),
          IconButton(
            onPressed: () {
              if (_textController.text.isEmpty) return;
              FirebaseFirestore.instance.collection('posts').add({
                'text': _textController.text,
                'timestamp': Timestamp.now(),
                'likes': [],
                'user_email': user.email
              });
            },
            icon: const Icon(Icons.keyboard_arrow_up_sharp),
          )
        ],
      ),
    );
  }
}
