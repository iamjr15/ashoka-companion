// Class representing a contact for a chat conversation
class ChatContact {
  final String name;         // Name of the contact
  final String profilePic;   // URL to the profile picture of the contact
  final String contactId;    // Unique identifier for the contact
  final DateTime timeSent;   // Date and time when the last message was sent in the conversation
  final String lastMessage;  // The content of the last message exchanged with the contact


  // Constructor to initialize the ChatContact object
  ChatContact(
      {required this.name,
      required this.profilePic,
      required this.contactId,
      required this.timeSent,
      required this.lastMessage});

  // Function to convert the ChatContact object to a map for database storage
  Map<String, dynamic> toMap() {
    return {
      'name': name,                       // Store the contact's name
      'profilePic': profilePic,           // Store the URL to the profile picture
      'contactId': contactId,             // Store the unique contact identifier
      'timeSent': timeSent.toIso8601String(),  // Store the time of the last message in ISO 8601 format
      'lastMessage': lastMessage,         // Store the content of the last message
    };
  }

  // Factory constructor to create a ChatContact object from a map retrieved from the database
  factory ChatContact.fromMap(Map<String, dynamic> map) {
    return ChatContact(
      name: map['name'] ?? '',                         // Retrieve the contact's name from the map, default to an empty string if not available
      profilePic: map['profilePic']?? '',              // Retrieve the profile picture URL, default to an empty string if not available
      contactId: map['contactId']?? '',                // Retrieve the contact identifier, default to an empty string if not available
      timeSent: DateTime.parse(map['timeSent'] as String), // Parse and retrieve the time of the last message as a DateTime object
      lastMessage: map['lastMessage']?? '',            // Retrieve the content of the last message, default to an empty string if not available
    );
  }
}
