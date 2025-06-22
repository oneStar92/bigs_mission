part of '../entity.dart';

@Freezed(fromJson: false, toJson: false)
abstract class Token with _$Token {
  const factory Token({
    required String accessToken,
    required String refreshToken,
  }) = _Token;
}