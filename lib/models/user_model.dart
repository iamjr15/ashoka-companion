class UserModel {
  final String uid;
  final String name;
  final String email;
  final String profileImage;
  final DateTime createdAt;
  final bool isOnline;
  final String instagramHandle;
  final bool isAvailable;
  final String matcheduser;
  final String notificationToken;
  final List<String> interests;

//<editor-fold desc="Data Methods">
  const UserModel({
    required this.uid,
    required this.name,
    required this.email,
    required this.profileImage,
    required this.createdAt,
    required this.isOnline,
    required this.instagramHandle,
    required this.isAvailable,
    required this.matcheduser,
    required this.notificationToken,
    required this.interests,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is UserModel &&
          runtimeType == other.runtimeType &&
          uid == other.uid &&
          name == other.name &&
          email == other.email &&
          profileImage == other.profileImage &&
          createdAt == other.createdAt &&
          isOnline == other.isOnline &&
          instagramHandle == other.instagramHandle &&
          isAvailable == other.isAvailable &&
          matcheduser == other.matcheduser &&
          notificationToken == other.notificationToken &&
          interests == other.interests);

  @override
  int get hashCode =>
      uid.hashCode ^
      name.hashCode ^
      email.hashCode ^
      profileImage.hashCode ^
      createdAt.hashCode ^
      isOnline.hashCode ^
      instagramHandle.hashCode ^
      isAvailable.hashCode ^
      matcheduser.hashCode ^
      notificationToken.hashCode ^
      interests.hashCode;

  @override
  String toString() {
    return 'UserModel{' +
        ' uid: $uid,' +
        ' name: $name,' +
        ' email: $email,' +
        ' profileImage: $profileImage,' +
        ' createdAt: $createdAt,' +
        ' isOnline: $isOnline,' +
        ' instagramHandle: $instagramHandle,' +
        ' isAvailable: $isAvailable,' +
        ' matcheduser: $matcheduser,' +
        ' notificationToken: $notificationToken,' +
        ' interests: $interests,' +
        '}';
  }

  UserModel copyWith({
    String? uid,
    String? name,
    String? email,
    String? profileImage,
    DateTime? createdAt,
    bool? isOnline,
    String? instagramHandle,
    bool? isAvailable,
    String? matcheduser,
    String? notificationToken,
    List<String>? interests,
  }) {
    return UserModel(
      uid: uid ?? this.uid,
      name: name ?? this.name,
      email: email ?? this.email,
      profileImage: profileImage ?? this.profileImage,
      createdAt: createdAt ?? this.createdAt,
      isOnline: isOnline ?? this.isOnline,
      instagramHandle: instagramHandle ?? this.instagramHandle,
      isAvailable: isAvailable ?? this.isAvailable,
      matcheduser: matcheduser ?? this.matcheduser,
      notificationToken: notificationToken ?? this.notificationToken,
      interests: interests ?? this.interests,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'uid': this.uid,
      'name': this.name,
      'email': this.email,
      'profileImage': this.profileImage,
      'createdAt':  this.createdAt.toIso8601String(),
      'isOnline': this.isOnline,
      'instagramHandle': this.instagramHandle,
      'isAvailable': this.isAvailable,
      'matcheduser': this.matcheduser,
      'notificationToken': this.notificationToken,
      'interests': this.interests,
    };
  }

  factory UserModel.fromMap(Map<String, dynamic> map) {
    return UserModel(
      uid: map['uid'] as String,
      name: map['name'] as String,
      email: map['email'] as String,
      profileImage: map['profileImage'] as String,
      createdAt: DateTime.parse(map['createdAt'] as String),
      isOnline: map['isOnline'] as bool,
      instagramHandle: map['instagramHandle'] as String,
      isAvailable: map['isAvailable'] as bool,
      matcheduser: map['matcheduser'] as String,
      notificationToken: map['notificationToken'] as String,
      interests: List<String>.from(map['interests']),
    );
  }

//</editor-fold>
}



// 'createdAt':  this.createdAt.toIso8601String(),
// createdAt: DateTime.parse(map['createdAt'] as String),
//List<String>.from(map['interests'])