part of 'chatbot_bloc.dart';

@immutable
sealed class ChatbotState {}

class InitialState extends ChatbotState {}

class LoadingState extends ChatbotState {}

class SuccessState extends ChatbotState {
  final List<String> messages;

  SuccessState(this.messages);
}

class ErrorState extends ChatbotState {
  final String errorMessage;

  ErrorState(this.errorMessage);
}
