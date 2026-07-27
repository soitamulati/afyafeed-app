import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class FirebaseService {
  final FirebaseFirestore _db = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  // NUMBER 3: BOOK APPOINTMENT FUNCTION
  Future<void> bookAppointment(String consultantId, DateTime dateTime) async {
    await _db.collection('bookings').add({
      'userId': _auth.currentUser!.uid,
      'consultantId': consultantId,
      'dateTime': Timestamp.fromDate(dateTime),
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });
  }

  // Also add these 2 so everything works
  Stream<QuerySnapshot> getVideos() {
    return _db.collection('videos').orderBy('createdAt', descending: true).snapshots();
  }

  Future<void> addComment(String videoId, String text) async {
    await _db.collection('comments').add({
      'videoId': videoId,
      'userId': _auth.currentUser!.uid,
      'text': text,
      'createdAt': FieldValue.serverTimestamp(),
    });
  }
}
