// To parse this JSON data, do
//
//     final sonicResponseModel = sonicResponseModelFromMap(jsonString);

import 'dart:convert';

List<SonicResponseModel> sonicResponseModelFromMap(String str) => List<SonicResponseModel>.from(json.decode(str).map((x) => SonicResponseModel.fromMap(x)));

String sonicResponseModelToMap(List<SonicResponseModel> data) => json.encode(List<dynamic>.from(data.map((x) => x.toMap())));

class SonicResponseModel {
  Data? data;

  SonicResponseModel({
    this.data,
  });

  factory SonicResponseModel.fromMap(Map<String, dynamic> json) => SonicResponseModel(
    data: json["data"] == null ? null : Data.fromMap(json["data"]),
  );

  Map<String, dynamic> toMap() => {
    "data": data?.toMap(),
  };
}

class Data {
  String? answer;
  String? sources;
  List<ChatHistory>? chatHistory;

  Data({
    this.answer,
    this.sources,
    this.chatHistory,
  });

  factory Data.fromMap(Map<String, dynamic> json) => Data(
    answer: json["answer"],
    sources: json["sources"],
    chatHistory: json["chat_history"] == null ? [] : List<ChatHistory>.from(json["chat_history"]!.map((x) => ChatHistory.fromMap(x))),
  );

  Map<String, dynamic> toMap() => {
    "answer": answer,
    "sources": sources,
    "chat_history": chatHistory == null ? [] : List<dynamic>.from(chatHistory!.map((x) => x.toMap())),
  };
}

class ChatHistory {
  String? message;
  bool? sent;
  List<dynamic>? sources;

  ChatHistory({
    this.message,
    this.sent,
    this.sources,
  });

  factory ChatHistory.fromMap(Map<String, dynamic> json) => ChatHistory(
    message: json["message"],
    sent: json["sent"],
    sources: json["sources"] == null ? [] : List<dynamic>.from(json["sources"]!.map((x) => x)),
  );

  Map<String, dynamic> toMap() => {
    "message": message,
    "sent": sent,
    "sources": sources == null ? [] : List<dynamic>.from(sources!.map((x) => x)),
  };
}