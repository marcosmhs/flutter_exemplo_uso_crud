import 'package:flutter/material.dart';

class SnackBarMessage {
  final String messageText;
  final IconData iconImage;

  SnackBarMessage({
    required BuildContext context,
    required this.messageText,
    required this.iconImage,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Row(
          children: [
            Icon(iconImage, color: Colors.white),
            const SizedBox(width: 5),
            Text(messageText),
          ],
        ),
        duration: const Duration(seconds: 3),
        backgroundColor: Theme.of(context).colorScheme.primary,
      ),
    );
  }
}
