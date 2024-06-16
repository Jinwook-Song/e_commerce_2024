import 'dart:convert';
import 'dart:io';
import 'dart:math';

import 'package:shelf/shelf.dart';
import 'package:shelf/shelf_io.dart';
import 'package:shelf_router/shelf_router.dart';
import 'package:shelf_swagger_ui/shelf_swagger_ui.dart';

import 'dto/product_info.dto.dart';
import 'dto/view_module.dto.dart';

part 'data.dart';
part 'request.dart';

// Configure routes.
final _router = Router()
  ..get('/api/menus/<mallType>', menuHandler)
  ..get('/api/view-modules/<tabId>/<page>', viewModuleHandler);

void main(List<String> args) async {
  final ip = InternetAddress.anyIPv4;

  // Swagger handler
  final swagger = SwaggerUI('specs/swagger.yaml', title: 'Swagger');

  // Combine Swagger and other routes
  final handler =
      Pipeline().addMiddleware(logRequests()).addHandler(_router.call);

  // Combine the two handlers
  final cascade = Cascade().add(handler).add(swagger.call).handler;

  final port = int.parse(Platform.environment['PORT'] ?? '8080');
  final server = await serve(cascade, ip, port);

  print('✅ Server listening on http://localhost:${server.port}');
}
