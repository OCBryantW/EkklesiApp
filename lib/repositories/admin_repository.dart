// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:comp_vis_project/models/admin_model.dart';

// class AdminRepository {
//   final _admins = FirebaseFirestore.instance.collection('admin');

//   Future<AdminModel?> getAdmin(String uid) async {
//     final doc = await _admins.doc(uid).get();
//     if (!doc.exists) return null;
//     return AdminModel.fromMap(doc.data()!);
//   }

//   Future<void> createAdmin(String uid) async {
//     await _admins.doc(uid).set({'uid': uid, 'counter': 0});
//   }

//   Future<void> incrementCounter(String uid) async {
//     await _admins.doc(uid).update({'counter': FieldValue.increment(1)});
//   }
// }