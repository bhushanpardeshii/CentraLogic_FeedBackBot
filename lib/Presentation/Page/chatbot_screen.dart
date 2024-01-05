// feedback_chatbot.dart
import 'package:chatbot/buildusermesssagewidget.dart';
import 'package:chatbot/Presentation/bloc/chatbot_bloc.dart';
import 'package:chatbot/Presentation/Widgets/BuildBotMessageWidget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class Chatbot extends StatelessWidget {
  final ChatbotBloc chatbotBloc = ChatbotBloc();

  Chatbot({super.key});
  Widget _buildUserMessage(String message, bool isUser) {
    return UserMessageWidget(message: message);
  }

  Widget _buildBotMessage(String message, BuildContext context) {
    return BotMessageWidget(message: message);
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => chatbotBloc,
      child: BlocBuilder<ChatbotBloc, ChatbotState>(
        builder: (context, state) {
          return Scaffold(
            appBar: AppBar(
              title: const Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Welcome to CentraLogic",
                    style: TextStyle(color: Colors.black, fontSize: 16),
                  ),
                  Text(
                    "Hi Charles",
                    style: TextStyle(color: Colors.black, fontSize: 14),
                  ),
                  Divider(),
                ],
              ),
            ),
            body: Container(
              alignment: Alignment.center,
              child: Column(
                children: [
                  const Image(
                    image: AssetImage("assets/img.png"),
                    width: 50,
                  ),
                  const Text(
                    'CentraLogic Bot',
                    style: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                  ),
                  const Text(
                    "Hi! Im CentraLogic Bot,your onboarding agent",
                    style: TextStyle(fontSize: 12),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  Flexible(
                    child: ListView(
                      children: state is SuccessState
                          ? state.messages
                              .map(
                                (message) => message.startsWith(' ')
                                    ? _buildUserMessage(message, true)
                                    : _buildBotMessage(message, context),
                              )
                              .toList()
                          : [],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.all(16),
                    child: Row(
                      children: [
                        Expanded(
                          child: TextField(
                            controller: chatbotBloc.textController,
                            decoration: InputDecoration(
                              hintText: 'Type Your Message',
                              hintStyle: const TextStyle(fontSize: 14),
                              filled: true,
                              fillColor: Colors.grey.shade300,
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                                borderSide: BorderSide.none,
                              ),
                              contentPadding: const EdgeInsets.symmetric(
                                vertical: 8.0,
                                horizontal: 8.0,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 5),
                        ElevatedButton(
                          onPressed: () {
                            chatbotBloc.add(
                              SendMessageEvent(
                                chatbotBloc.textController.text,
                              ),
                            );
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.blue,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10),
                            ),
                          ),
                          child: const Text(
                            'Send',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
