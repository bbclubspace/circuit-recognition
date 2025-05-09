import 'package:circuit_recognition/services/ai/ai-chat-services.dart';
import 'package:flutter/material.dart';
import 'package:ionicons/ionicons.dart';
import 'package:provider/provider.dart';
import 'package:quickalert/quickalert.dart';

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

@override
void initState() {
  super.initState();
  WidgetsBinding.instance.addPostFrameCallback((_) {
    QuickAlert.show(
      context: context,
      type: QuickAlertType.info,
      title: 'AI chatbot',
      text: 'Dilediğiniz soruları yapay zeka botumuza sorabilirsiniz...',
      showConfirmBtn: false,
    );
  });
}

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

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
  Widget build(BuildContext context) {
    final chatProvider = context.watch<AiChatServices>();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      scrollDown();
    });

    return Scaffold(
            backgroundColor: Theme.of(context).scaffoldBackgroundColor,
            appBar: AppBar(
        leading: IconButton(
          onPressed: () {
            Navigator.pop(context);
          },
          icon: const Icon(Ionicons.chevron_back_outline),
        ),
        leadingWidth: 50,
      ),
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

