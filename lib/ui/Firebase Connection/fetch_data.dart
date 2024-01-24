import 'package:firebase_auth/firebase_auth.dart';

class FetchData {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Future<String?> fetchUserEmail() async {
    User? user = _auth.currentUser;
    return user?.email;
  }
}
