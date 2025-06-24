part of '../dto.dart';

@immutable
@JsonSerializable(createToJson: false)
final class BoardDTO {
  @JsonKey()
  final int id;
  @JsonKey()
  final String title;
  @JsonKey()
  final String content;
  @JsonKey(name: 'boardCategory')
  final String category;
  @JsonKey()
  final String createdAt;
  @JsonKey()
  final String? imageUrl;

  factory BoardDTO.fromJson(Map<String, dynamic> json) => _$BoardDTOFromJson(json);

  const BoardDTO({
    required this.id,
    required this.title,
    required this.content,
    required this.category,
    required this.createdAt,
    this.imageUrl,
  });
}
