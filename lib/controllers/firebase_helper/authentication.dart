import 'package:firebase_auth/firebase_auth.dart';

abstract class Authentication {
  static FirebaseAuth get instance => FirebaseAuth.instance;
  static User? get user => instance.currentUser;
}