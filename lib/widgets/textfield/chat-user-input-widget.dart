import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import '../../themes/themes.dart';
import 'rounded-border-with-icon.dart';

class ChatUserInputWidget extends StatelessWidget {
  const ChatUserInputWidget({
    super.key,
    required this.controller,
    required this.send,
  });

  final TextEditingController controller;
  final Function() send;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Padding(
      padding: const EdgeInsets.only(bottom: 35.0, right: 15, left: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            width: size.width * 0.75,
            child: TextField(
              style: TextStyle(color: Colors.black),
              controller: controller,
              cursorColor: Theme.of(context).brightness == Brightness.light
                  ? AppColors.textFieldStroke
                  : AppColors.buttonPurple,
              decoration: InputDecoration(
                filled: true,
                fillColor: const Color.fromARGB(255, 229, 228, 228),
                hintText: "Dilediğin soruyu sor...",
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                ),
                enabledBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 254, 127, 33)),
                  borderRadius: BorderRadius.circular(20),
                ),
                focusedBorder: OutlineInputBorder(
                  borderSide:
                      BorderSide(color: Color.fromARGB(255, 254, 127, 33)),
                  borderRadius: BorderRadius.circular(20),
                ),
                hintStyle: TextStyle(color: const Color.fromARGB(73, 0, 0, 0)),
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15),
            child: InkWell(
              onTap: () async {
                send();
              },
              child: RoundedBorderWithIcon(icon: Icons.arrow_forward),
            ),
          ),
        ],
      ),
    );
  }
}
