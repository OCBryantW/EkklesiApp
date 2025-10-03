// class AdminModel {
//   final String uid;
//   final int counter;

//   AdminModel({required this.uid, required this.counter});

//   factory AdminModel.fromMap(Map<String, dynamic> map){
//     return AdminModel(
//       uid: map['uid'], 
//       counter: map['counter'] ?? 0,
//     );
//   }

//   Map<String, dynamic> toMap() => {
//     'uid': uid,
//     'counter': counter,
//   };
// }