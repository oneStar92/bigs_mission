part of '../mapper.dart';

extension TokenEntityMapper on TokenDTO {
  TokenEntity toEntity() {
    return TokenEntity(accessToken: accessToken, refreshToken: refreshToken);
  }
}
