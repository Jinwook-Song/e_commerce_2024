class RouteModel {
  const RouteModel({
    required this.path,
    required this.name,
  });

  final String path;
  final String name;
}

class Routes {
  static const splash = RouteModel(path: '/splash', name: 'Splash');

  static const main = RouteModel(path: '/', name: 'Main');
}
