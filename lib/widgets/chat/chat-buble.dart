import 'package:chat_bubbles/bubbles/bubble_special_one.dart';
import 'package:circuit_recognition/themes/themes.dart';
import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';

class ChatBuble extends StatelessWidget {
  final String? message;
  final bool isUserInput;
  final bool isLoading;

  const ChatBuble({
    super.key,
    required this.isUserInput,
    this.message,
    required this.isLoading,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment:
            isUserInput ? MainAxisAlignment.end : MainAxisAlignment.start,
        children: [
          if (!isUserInput)
            Padding(
              padding: const EdgeInsets.only(right: 5),
              child: Column(
                children: [
                  Lottie.asset(
                    "assets/lottie.json",
                    width: 60,
                    height: 60,
                    repeat: false,
                  ),
                  if (isLoading)
                    Lottie.asset(
                      "assets/loading.json",
                      width: 60,
                      height: 60,
                    ),
                ],
              ),
            ),

          Flexible(
            child: Container(
              constraints: BoxConstraints(
                maxWidth: MediaQuery.of(context).size.width * 0.7,
              ),
              margin: const EdgeInsets.symmetric(vertical: 2), // minimize spacing
              child: BubbleSpecialOne(
                text: message?.trim() ?? "",
                isSender: isUserInput,
                color: isUserInput
                    ? AppColors.chatBubleUser
                    : AppColors.chatBubleAi,
                textStyle: TextStyle(
                  color: isUserInput
                      ? AppColors.chatBubleUserText
                      : AppColors.chatBubleAiText,
                  fontSize: 15,
                  height: 1.2, // satır yüksekliği azaltıldı
                ),
                tail: true,
                seen: false,
                delivered: false,
                sent: false,
              ),
            ),
          ),

          if (isUserInput)
            Padding(
              padding: const EdgeInsets.only(left: 5),
              child: Image.asset(
                "assets/working.png",
                width: 60,
                height: 60,
              ),
            ),
        ],
      ),
    );
  }
}
