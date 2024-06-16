part of 'server.dart';

Response menuHandler(Request req, String mallType) {
  List<Map<String, Object>> data;
  if (mallType == 'market') {
    data = marketStore;
  } else {
    data = beautyStore;
  }

  Map<String, dynamic> result = {
    'status': 'SUCCESS',
    'code': '0000',
    'message': '성공',
    'data': data
  };

  return Response.ok(
    jsonEncode(result),
    headers: {'Content-Type': 'application/json'},
  );
}

Response viewModuleHandler(Request req, String tabId, String page) {
  Map<String, dynamic> result = {
    'status': 'SUCCESS',
    'code': '0000',
    'message': '성공',
  };

  if (int.parse(page) >= 5) {
    result['data'] = [];
  } else {
    result['data'] =
        viewModules(tabId.startsWith('1', 0) ? 'market' : 'beauty');
  }

  return Response.ok(
    jsonEncode(result),
    headers: {'Content-Type': 'application/json'},
  );
}
