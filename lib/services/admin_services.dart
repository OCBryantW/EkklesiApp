// import 'package:cloud_firestore/cloud_firestore.dart';

// class AdminServices {
//   static final _adminCollection = FirebaseFirestore.instance.collection("admin");

//   static Future<bool> isAdmin(String uid) async {
//     final doc = await _adminCollection.doc(uid).get();
//     if (doc.exists) {
//       return doc.data()?['counter'] ?? 0;
//     }
//     return false;
//   }

//   static Future<void> incrementAdminCounter(String uid) async {
//     await _adminCollection.doc(uid).update({
//       "counter": FieldValue.increment(1),
//     });
//   }
// }