import 'package:dio/dio.dart';
import 'package:e_commerce/data/dto/common/response_wrapper/response_wrapper.dart';
import 'package:retrofit/retrofit.dart';

part 'user.api.g.dart';

const String _baseUrl = 'https://createcustomtoken-y75fk6y4uq-uc.a.run.app';

@RestApi(baseUrl: _baseUrl)
abstract class UserApi {
  factory UserApi(Dio dio) = _UserApi;

  @POST('/')
  Future<ResponseWrapper<String>> getCustomToken({
    @Body() required Map<String, dynamic> params,
  });
}
