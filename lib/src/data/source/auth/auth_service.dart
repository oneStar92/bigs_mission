part of '../source.dart';

@RestApi()
abstract class AuthService {
  factory AuthService(Dio dio, {String baseUrl}) = _AuthService;

  @POST('auth/signup')
  Future<void> signup({@Body() required Map<String, dynamic> body});

  @POST('auth/signin')
  Future<TokenDTO> login({@Body() required Map<String, dynamic> body});

  @POST('auth/refresh')
  Future<TokenDTO> refresh({@Body() required Map<String, dynamic> body});
}
