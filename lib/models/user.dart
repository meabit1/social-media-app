import 'package:equatable/equatable.dart';

class User extends Equatable {
  final String id;
  final String? email;
  final String? name;
  final String? imageUrl;
  const User({required this.id, this.email, this.name, this.imageUrl});
  static const empty = User(id: '');

  bool get isEmpty => this == empty;
  bool get isNotEmpty => this != empty;

  @override
  List<Object?> get props => [id, email, name, imageUrl];
}
