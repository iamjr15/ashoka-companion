// Just Chat Screen Provuider....
import 'package:gojek_university_app/features/blind_chat/chat/data/apis/chat_repository.dart';
import 'package:gojek_university_app/features/blind_chat/chat/data/models/message.dart';

import '../../../../commons/common_imports/apis_commons.dart';

// Define a StreamProvider family to fetch chat streams by user ID
// This provider returns a stream of chat messages for a specific user ID
final fetchChatsStreamByIdProvider = StreamProvider.family((ref, String uid) {
  // Get an instance of ChatScreenController from the provider
  final chatScreenCtr = ref.watch(chatScreenControllerProvider.notifier);
  // Call the chatStream function from the controller to get the chat stream for the specified user ID
  return chatScreenCtr.chatStream(uid);
});


// Define a StateNotifierProvider for ChatScreenController
// This provider creates an instance of ChatScreenController with necessary dependencies.
final chatScreenControllerProvider =
StateNotifierProvider<ChatScreenController, bool>((ref) {
  return ChatScreenController(
    // Create an instance of ChatScreenController with the ChatRepositoryProvider dependency
  chatRepository: ref.watch(ChatRepositoryProvider),
  );
});


// Class that manages the chat screen state and interactions
class ChatScreenController extends StateNotifier<bool> {
  final ChatRepository chatRepository;

  // Constructor to inject dependencies
  ChatScreenController({
    required ChatRepository chatRepository,
  })  : chatRepository = chatRepository,
        super(false);

  // Function to retrieve the chat stream for a specific user
  Stream<List<Message>> chatStream(String receiverUserId) {
    // Call the getChatStream function from the ChatRepository to get the chat messages stream
    return chatRepository.getChatStream(receiverUserId);
  }


}