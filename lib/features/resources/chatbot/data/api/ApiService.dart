
import 'dart:convert';
import 'dart:developer';
import 'dart:io';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:gojek_university_app/commons/common_imports/apis_commons.dart';
import 'package:gojek_university_app/features/resources/chatbot/constants/api_const.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/model/chat_model.dart';
import 'package:gojek_university_app/features/resources/chatbot/data/model/sonic_response_model.dart';
import 'package:http/http.dart' as http;

final chatBotApiServiceProvider = Provider<ChatBotApiService>((ref) {
  return ChatBotApiService();
});

class ChatBotApiService {
  //Send Message to model
  // FutureEither<List<ChatModel>> sendMessageGPT(
  //     {required String message, required String modelId}) async {
  //   try {
  //     var response = await http.post(Uri.parse('$baseUrl/completions'),
  //         headers: {
  //           'Authorization': 'Bearer $YOUR_API_KEY',
  //           'Content-Type': 'application/json'
  //         },
  //         body: jsonEncode({
  //           "model": modelId,
  //           "prompt": message,
  //           "max_tokens": 1000,
  //         }));
  //     Map<String, dynamic> jsonResponse = jsonDecode(response.body);
  //
  //     if (jsonResponse['error'] != null) {
  //       throw HttpException(jsonResponse['error']['message']);
  //     }
  //     List<ChatModel> chatList = [];
  //
  //     if (jsonResponse['choices'].length > 0) {
  //       // log('jsonesponce[choices]text ${jsonResponse['choices'][0]['text']}');
  //       chatList = List.generate(
  //         jsonResponse['choices'].length,
  //         (index) => ChatModel(
  //           msg: jsonResponse['choices'][index]['text'].toString().trim(),
  //           chatIndex: 1,
  //         ),
  //       );
  //     }
  //
  //     return Right(chatList);
  //   } catch (error, stackTrace) {
  //     return Left(Failure(error.toString(), stackTrace));
  //     log("error $error");
  //     rethrow;
  //   }
  // }

  FutureEither<List<ChatModel>> sendMessageSonic(
      {required String message}) async {
    try {
      var headers = {
        'Accept-Encoding': 'application/json',
        'Connection': 'keep-alive',
        'Content-Type': 'application/json',
        'User-Agent': 'python-requests/2.28.1',
        'accept': 'application/json',
        'token': Bot_Sonic_Token,
      };
      var data = '{"question": "$message", "chat_history": []}';
      var url = Uri.parse(baseUrlBotSonic);
      var res = await http.post(url, headers: headers, body: data);
      if (res.statusCode != 200) {
        print(res.reasonPhrase);
        throw Exception('http.post error: statusCode= ${res.statusCode}');
      }


      List<dynamic> decodedJson  = jsonDecode(res.body);
      Map<String, dynamic> jsonResponse = decodedJson[0]['data'];
      List<ChatModel> chatList = [];
      chatList.add(ChatModel(msg: jsonResponse['answer'], chatIndex: 1));

      return Right(chatList);
    } catch (error, stackTrace) {
      return Left(Failure(error.toString(), stackTrace));
    }
  }
}
