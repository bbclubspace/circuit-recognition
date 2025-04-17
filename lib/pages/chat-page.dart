import 'package:circuit_recognition/services/ai/ai-chat-services.dart';
import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/chat/chat-buble.dart';
import '../widgets/textfield/chat-user-input-widget.dart';

class ChatPage extends StatefulWidget {
  const ChatPage({Key? key}) : super(key: key);

  @override
  State<ChatPage> createState() => _ChatPageState();
}

class _ChatPageState extends State<ChatPage> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();

  void scrollDown({bool animated = true}) {
    if (_scrollController.hasClients) {
      final position = _scrollController.position.maxScrollExtent;
      if (animated) {
        _scrollController.animateTo(
          position,
          duration: const Duration(milliseconds: 100),
          curve: Curves.easeOut,
        );
      } else {
        _scrollController.jumpTo(position);
      }
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final chatProvider = context.watch<AiChatServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });

    return Scaffold(
      backgroundColor: AppColors.primaryColor,
      body: Column(
        children: [
          // Logo gibi görseller burada eklenebilir
          Expanded(
            child: ListView.builder(
              controller: _scrollController,
              itemCount: chatProvider.messages.length,
              itemBuilder: (context, index) {
                final currentMessage = chatProvider.messages[index];
                return KeyedSubtree(
                  key: ValueKey(index),
                  child: ChatBuble(
                    isUserInput: currentMessage["isUser"],
                    message: currentMessage["message"],
                    isLoading: currentMessage["isLoading"] ?? false,
                  ),
                );
              },
            ),
          ),
          ChatUserInputWidget(
            controller: _messageController,
            send: () {
              final userMessage = _messageController.text;
              if (userMessage.isNotEmpty) {
                chatProvider.sendMessage(userMessage);
                _messageController.clear();
              }
            },
          ),
        ],
      ),
    );
  }
}
