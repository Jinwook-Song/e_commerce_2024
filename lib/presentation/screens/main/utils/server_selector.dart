import 'package:e_commerce/core/utils/constants.dart';
import 'package:e_commerce/data/entity/target_api.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ServerSelector extends StatelessWidget {
  const ServerSelector({super.key});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: Hive.box<TargetApi>(Constants.targetApiKey).listenable(),
      builder: (context, box, widget) {
        var source = box.get(
          Constants.targetApiKey,
          defaultValue: TargetApi.REMOTE,
        );

        return AlertDialog(
          title: const Text('데이터 소스를 선택해주세요'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              RadioListTile<TargetApi>(
                value: TargetApi.REMOTE,
                groupValue: source,
                onChanged: (value) {
                  box.put(Constants.targetApiKey, value ?? TargetApi.REMOTE);
                },
                title: const Text('Remote Api'),
              ),
              RadioListTile<TargetApi>(
                value: TargetApi.MOCK,
                groupValue: source,
                onChanged: (value) {
                  box.put(Constants.targetApiKey, TargetApi.MOCK);
                },
                title: const Text('Mock Api'),
              ),
            ],
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('앱을 재실행 해주세요.'),
                  ),
                );
              },
              child: const Text('확인'),
            ),
          ],
        );
      },
    );
  }
}
