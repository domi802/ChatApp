import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
/*
this firebase stores posts that users have published
It is stored in collection called 'Posts' in Firebase

Post  contains:
 - a message
 - email
 - timestamp
*/

class FirestoreDatabase {
  //current logged user
  User? user = FirebaseAuth.instance.currentUser;
  //get collection of posts from firebase

  final CollectionReference posts =
      FirebaseFirestore.instance.collection('Posts');

  // post a message
  Future<void> addPost(String message) {
    return posts.add({
      'UserEmail': user!.email,
      'PostMessage': message,
      'Timestamp': Timestamp.now(),
    });
  }

  // read posts from database
  Stream<QuerySnapshot> getPostsStream() {
    final postsStream = FirebaseFirestore.instance
        .collection('Posts')
        .orderBy('TimeStamp', descending: true)
        .snapshots();
    return postsStream;
  }
}
