// ignore_for_file: prefer_const_literals_to_create_immutables
import 'package:flutter/material.dart';
class MyDivider extends StatelessWidget {
  const MyDivider({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(width: 70),
        SizedBox(
          width: 80,
          child: Divider(
            thickness: 1.25,
            color: Theme.of(context).colorScheme.secondary,
          ),
        ),
        Padding(
          padding: EdgeInsets.symmetric(
              horizontal: 8.0),
          child: Text("Ya da",style: TextStyle(color:Theme.of(context).colorScheme.secondary,fontSize: 15,fontWeight: FontWeight.bold),),
        ),
        SizedBox(
          width: 80,
          child: Divider(
            thickness: 1.25,
            color:Theme.of(context).colorScheme.secondary,
          ),
        ),
      ],
    );
  }
}