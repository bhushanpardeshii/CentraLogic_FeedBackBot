import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
part 'chatbot_event.dart';
part 'chatbot_state.dart';

class ChatbotBloc extends Bloc<ChatbotEvent, ChatbotState> {
  final _textController = TextEditingController();
  final _messages = <String>[];

  TextEditingController get textController => _textController;

  ChatbotBloc() : super(InitialState());
  @override
  Stream<ChatbotState> mapEventToState(ChatbotEvent event) async* {
    if (event is SendMessageEvent) {
      yield LoadingState();
      String message = event.message;
      _messages.add(' $message');
      yield SuccessState(List.from(_messages));
      try {
        String response = await _getResponse(message);
        _messages.add(response);
        yield SuccessState(List.from(_messages));
      } catch (e) {
        yield ErrorState("Error generating response");
      }
    }
  }

  Future<String> _getResponse(String message) async {
    try {
      String response = await generateText(message);
      if (response.isEmpty) {
        return ('Error');
      } else {
        textController.clear();
      }
      return response;
    } catch (e) {
      throw Exception("Error generating response");
    }
  }

  Future<String> generateText(String prompt) async {
    String apiUrl =
        "https://sapdos-api-v2.azurewebsites.net/api/Credentials/FeedbackJoiningBot";
    Uri uri = Uri.parse(apiUrl);
    final response = await http.post(
      uri,
      headers: {
        "Content-Type": "application/json",
        "Authorization": "Bearer $apiUrl",
      },
      body: jsonEncode({
        "step": prompt,
      }),
    );

    if (response.statusCode == 200) {
      final responseJson = jsonDecode(response.body);
      String responseMessage = responseJson['message'];
      return responseMessage;
    } else {
      return "Invaid input";
    }
  }
}
