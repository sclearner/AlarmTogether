import 'package:alarmtogether/controllers/firebase_helper/authentication.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class Database {
  static FirebaseFirestore get instance => FirebaseFirestore.instance;

  static CollectionReference get usersCollection =>
      instance.collection('users');

  static DocumentReference get currentUsersDoc {
    return usersCollection.doc(Authentication.user!.uid);
  }

  static CollectionReference get alarmsCollection =>
      currentUsersDoc.collection('alarms');
}
