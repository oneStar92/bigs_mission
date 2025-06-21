part of '../dto.dart';

@immutable
@JsonSerializable(createToJson: false)
final class TokenDTO {
  @JsonKey() final String accessToken;
  @JsonKey() final String refreshToken;

  factory TokenDTO.fromJson(Map<String, dynamic> json) => _$TokenDTOFromJson(json);

  const TokenDTO({
    required this.accessToken,
    required this.refreshToken,
  });
}