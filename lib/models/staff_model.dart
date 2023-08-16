class StaffModel {
  final String uid;
  final String username;
  final String password;

//<editor-fold desc="Data Methods">
  const StaffModel({
    required this.uid,
    required this.username,
    required this.password,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is StaffModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          username == other.username &&
          password == other.password);

  @override
  int get hashCode => uid.hashCode ^ username.hashCode ^ password.hashCode;

  @override
  String toString() {
    return 'StaffModel{' +
        ' uid: $uid,' +
        ' username: $username,' +
        ' password: $password,' +
        '}';
  }

  StaffModel copyWith({
    String? uid,
    String? username,
    String? password,
  }) {
    return StaffModel(
      uid: uid ?? this.uid,
      username: username ?? this.username,
      password: password ?? this.password,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'username': this.username,
      'password': this.password,
    };
  }

  factory StaffModel.fromMap(Map<String, dynamic> map) {
    return StaffModel(
      uid: map['uid'] as String,
      username: map['username'] as String,
      password: map['password'] as String,
    );
  }

//</editor-fold>
}
