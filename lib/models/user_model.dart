class UserModel {
  String uid;
  String fullName;
  int age;
  String address;
  String email;
  String phone;
  int exp;
  int streak;
  String role;
  bool isAdmin;
  // int adminCounter;

  UserModel({
    required this.uid,
    required this.fullName,
    required this.age,
    required this.address,
    required this.email,
    required this.phone,
    required this.exp,
    required this.streak,
    required this.role,
    required this.isAdmin,
    // required this.adminCounter,
  });

  Map<String, dynamic> toMap(){
    return {
      'uid': uid,
      'name': fullName,
      'email': email,
      'age': age,
      'phone': phone,
      'exp': exp,
      'streak': streak,
      'address': address,
      'isAdmin': isAdmin,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map){
    return UserModel(
      uid: map['uid'] ?? '', 
      fullName: map['fullName'] ?? '', 
      age: map['age'] ?? '0', 
      address: map['address'] ?? '-', 
      email: map['email'] ?? '', 
      phone: map['phone'] ?? '', 
      role: map['role'] ?? '',
      exp: map['exp'] ?? 0,
      streak: map['streak'] ?? 0,
      isAdmin: map['isAdmin'] ?? false,
      // adminCounter: map['adminCounter'] ?? 0,
    );
  }
}