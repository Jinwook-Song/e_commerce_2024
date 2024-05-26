import 'dart:io';

import 'package:e_commerce/core/utils/error/error_response.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class CommonDialog {
  const CommonDialog();

  static Future<bool?> errorDialog(
    BuildContext context,
    ErrorResponse error,
  ) {
    return showDialog<bool>(
      context: context,
      builder: (_) {
        return AlertDialog(
          content: SizedBox(
            height: 70,
            child: Column(
              children: [
                Text(error.message ?? '', textAlign: TextAlign.center),
                Text('[${error.code ?? ''}]'),
              ],
            ),
          ),
          contentPadding: const EdgeInsets.only(top: 20),
          actions: [
            ElevatedButton(
              onPressed: () => context.pop(true),
              child: const Text('다시 시도'),
            ),
            ElevatedButton(onPressed: () => exit(0), child: const Text('종료')),
          ],
          actionsPadding: EdgeInsets.zero,
          actionsAlignment: MainAxisAlignment.center,
          alignment: Alignment.center,
        );
      },
      barrierDismissible: false,
    );
  }
}
