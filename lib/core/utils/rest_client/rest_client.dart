import 'package:dio/dio.dart';

/// - RestClient 클래스가 처음 호출될 때, _instance 필드가 초기화됩니다.
/// - factory RestClient() 생성자는 항상 _instance를 반환하므로, 클래스의 인스턴스는 하나만 존재하게 됩니다.
/// - _internal 생성자는 외부에서 호출할 수 없으므로, 추가적인 인스턴스 생성을 방지합니다.
/// - _dio는 Dio 클래스의 인스턴스로 HTTP 요청을 처리하는데 사용됩니다.
/// - getDio 게터를 통해 Dio 인스턴스에 접근할 수 있습니다.
class RestClient {
  factory RestClient() => _instance;

  RestClient._internal();

  static final RestClient _instance = RestClient._internal();

  final Dio _dio = Dio();

  Dio get getDio => _dio;
}
