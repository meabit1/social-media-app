class MyUser {
  final String email;
  final String id;
  MyUser({required this.id, required this.email});
  bool get isEmpty => email.isEmpty && id.isEmpty;
}
