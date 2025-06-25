part of '../core.dart';

final class TokenStorage extends ChangeNotifier {
  TokenStorage._();

  static final TokenStorage _instance = TokenStorage._();

  static TokenStorage get instance => _instance;

  factory TokenStorage() => instance;

  final _storage = const FlutterSecureStorage();

  TokenEntity? _tokenEntity;

  String? get accessToken => _tokenEntity?.accessToken;

  String? get refreshToken => _tokenEntity?.refreshToken;

  bool get hasToken => _tokenEntity != null;

  load() async {
    final access = await _storage.read(key: 'access');
    final refresh = await _storage.read(key: 'refresh');

    if (access != null && refresh != null) {
      _tokenEntity = TokenEntity(accessToken: access, refreshToken: refresh);
    }
  }

  Future<void> saveToken(TokenEntity token) async {
    await Future.wait([
      _storage.write(key: 'access', value: token.accessToken),
      _storage.write(key: 'refresh', value: token.refreshToken),
    ]);
    _tokenEntity = token.copyWith();
    notifyListeners();
  }

  Future<void> deleteToken() async {
    await _storage.deleteAll();
    _tokenEntity = null;
    notifyListeners();
  }
}