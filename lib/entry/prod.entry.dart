import 'package:e_commerce/firebase_options.dart';
import 'package:e_commerce/main.dart' as entry;
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  await dotenv.load(fileName: 'assets/env/.env');

  entry.main(
    dotenv.env['FLAVOR'],
    DefaultFirebaseOptions.currentPlatform,
  );
}
