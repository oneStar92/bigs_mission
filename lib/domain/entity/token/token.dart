part of '../entity.dart';

@Freezed(fromJson: false, toJson: false)
abstract class TokenEntity with _$TokenEntity {
  const factory TokenEntity({
    required String accessToken,
    required String refreshToken,
  }) = _TokenEntity;
}