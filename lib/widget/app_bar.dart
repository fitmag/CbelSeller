
import 'package:cbel/widget/icon.dart';
import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  const CustomAppBar({
    Key? key,
    required this.messageStream,
    required this.notificationStream,
  }) : super(key: key);

  final dynamic messageStream;
  final dynamic notificationStream;

  @override
  Widget build(BuildContext context) {
    
    return SizedBox(
      height: 56.0,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8.0),
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconWithBadge(
                  stream: messageStream,
                  icon: "assets/icons/msg.svg",
                  press: () => {}),
              
              IconWithBadge(
                  stream: notificationStream,
                  icon: "assets/icons/notif.svg",
                  press: () => {})
            ]),
      ),
    );
  }
}

