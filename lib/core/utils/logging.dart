import 'package:logger/logger.dart';

enum LogType { trace, debug, info, warning, error }

Logger loggerDetail = Logger(printer: PrettyPrinter(printTime: true));
Logger loggerBrief = Logger(
  printer: PrettyPrinter(methodCount: 0, printTime: true),
);

void logging<T>(
  T messages, {
  LogType logType = LogType.debug,
  Object? error,
  StackTrace? stackTrace,
}) {
  final time = DateTime.now();
  String message;
  if (messages is List) {
    message = messages.map((message) => message.toString()).join('\n');
  } else {
    message = messages.toString();
  }

  switch (logType) {
    case LogType.trace:
      loggerDetail.t(message, time: time);
      break;
    case LogType.debug:
      loggerBrief.d(message, time: time);
      break;
    case LogType.info:
      loggerDetail.i(message, time: time);
      break;
    case LogType.warning:
      loggerDetail.w(message, time: time);
      break;
    case LogType.error:
      loggerDetail.e(message, time: time, error: error, stackTrace: stackTrace);
      break;
  }
}

extension LoggerExtension on String {
  void log({String tag = 'fastLog'}) {
    loggerDetail.d('$tag : $this');
  }
}
