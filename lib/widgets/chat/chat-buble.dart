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
    return Row(
      mainAxisAlignment:
          isUserInput ? MainAxisAlignment.end : MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        // Kullanıcı değilse ve loading varsa avatar + lottie göster
        if (!isUserInput)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Row(
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
                    width: 100,
                    height: 100,
                  ),
              ],
            ),
          ),

        // Chat baloncuğu
        if (isUserInput || !isLoading)
          Flexible(
            child: Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 5),
              child: BubbleSpecialOne(
                text: message ?? "",
                isSender: isUserInput,
                color: isUserInput
                    ? AppColors.chatBubleUser
                    : AppColors.chatBubleAi,
                textStyle: TextStyle(
                  color: isUserInput
                      ? AppColors.chatBubleUserText
                      : AppColors.chatBubleAiText,
                  fontSize: 15,
                ),
                tail: true,
                seen: false,
                delivered: false,
                sent: false,
              ),
            ),
          ),

        // Kullanıcı ise: sağda avatar göster
        if (isUserInput)
          Padding(
            padding: const EdgeInsets.only(right: 5),
            child: Image.asset(
              "assets/working.png",
              width: 50,
              height: 50
            ),
          ),
      ],
    );
  }
}
