part of 'posts_bloc.dart';

class PostsState extends Equatable {
  const PostsState();

  @override
  List<Object> get props => [];
}

final class PostsInitial extends PostsState {}

class PostsLoading extends PostsState {}
