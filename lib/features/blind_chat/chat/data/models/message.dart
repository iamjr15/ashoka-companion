import 'package:gojek_university_app/commons/enums/message_enum.dart';

// Class definition for a chat message

class Message {
  final String senderId;    // ID of the message sender
  final String receiverId;  // ID of the message receiver
  final String text;        // Content of the message
  final MessageEnum type;   // Type of the message (text, image, etc.)
  final DateTime timeSent;  // Timestamp when the message was sent
  final String messageId;   // Unique ID for the message
  final bool isSeen;        // Flag indicating whether the message has been seen by the receiver

//<editor-fold desc="Data Methods">

  const Message({
    required this.senderId,
    required this.receiverId,
    required this.text,
    required this.type,
    required this.timeSent,
    required this.messageId,
    required this.isSeen,
  });

  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is Message &&
          runtimeType == other.runtimeType &&
          senderId == other.senderId &&
          receiverId == other.receiverId &&
          text == other.text &&
          type == other.type &&
          timeSent == other.timeSent &&
          messageId == other.messageId &&
          isSeen == other.isSeen);

  @override
  int get hashCode =>
      senderId.hashCode ^
      receiverId.hashCode ^
      text.hashCode ^
      type.hashCode ^
      timeSent.hashCode ^
      messageId.hashCode ^
      isSeen.hashCode;

  @override
  String toString() {
    return 'Message{' +
        ' senderId: $senderId,' +
        ' receiverId: $receiverId,' +
        ' text: $text,' +
        ' type: $type,' +
        ' timeSent: $timeSent,' +
        ' messageId: $messageId,' +
        ' isSeen: $isSeen,' +
        '}';
  }

  Message copyWith({
    String? senderId,
    String? receiverId,
    String? text,
    MessageEnum? type,
    DateTime? timeSent,
    String? messageId,
    bool? isSeen,
  }) {
    return Message(
      senderId: senderId ?? this.senderId,
      receiverId: receiverId ?? this.receiverId,
      text: text ?? this.text,
      type: type ?? this.type,
      timeSent: timeSent ?? this.timeSent,
      messageId: messageId ?? this.messageId,
      isSeen: isSeen ?? this.isSeen,
    );
  }

  // Function to convert the message to a map for database storage
  Map<String, dynamic> toMap() {
    return {
      'senderId': this.senderId,
      'receiverId': this.receiverId,
      'text': this.text,
      'type': this.type.type,
      'timeSent': timeSent.millisecondsSinceEpoch,
      'messageId': this.messageId,
      'isSeen': this.isSeen,
    };
  }

  // Factory constructor to create a Message instance from a map
  factory Message.fromMap(Map<String, dynamic> map) {
    return Message(
      senderId: map['senderId'] as String,
      receiverId: map['receiverId'] as String,
      text: map['text'] as String,
      type: (map['type'] as String).toEnum(),
      timeSent: DateTime.fromMillisecondsSinceEpoch(map['timeSent']),
      messageId: map['messageId'] as String,
      isSeen: map['isSeen'] as bool,
    );
  }

//</editor-fold>
}

