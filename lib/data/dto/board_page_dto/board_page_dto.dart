part of '../dto.dart';

@immutable
@JsonSerializable(createToJson: false)
final class BoardItemDTO {
  @JsonKey() final int id;
  @JsonKey() final String title;
  @JsonKey() final String category;
  @JsonKey() final String createdAt;

  factory BoardItemDTO.fromJson(Map<String, dynamic> json) => _$BoardItemDTOFromJson(json);

  const BoardItemDTO({
    required this.id,
    required this.title,
    required this.category,
    required this.createdAt,
  });
}

@immutable
@JsonSerializable(createToJson: false)
final class PageableDTO {
  @JsonKey() final int pageNumber;
  @JsonKey() final int pageSize;
  @JsonKey() final SortDTO sort;
  @JsonKey() final int offset;
  @JsonKey() final bool unpaged;
  @JsonKey() final bool paged;

  factory PageableDTO.fromJson(Map<String, dynamic> json) => _$PageableDTOFromJson(json);

  const PageableDTO({
    required this.pageNumber,
    required this.pageSize,
    required this.sort,
    required this.offset,
    required this.unpaged,
    required this.paged,
  });
}

@immutable
@JsonSerializable(createToJson: false)
final class SortDTO {
  @JsonKey() final bool unsorted;
  @JsonKey() final bool sorted;
  @JsonKey() final bool empty;

  factory SortDTO.fromJson(Map<String, dynamic> json) => _$SortDTOFromJson(json);

  const SortDTO({
    required this.unsorted,
    required this.sorted,
    required this.empty,
  });
}

@immutable
@JsonSerializable(createToJson: false)
final class BoardsPageDTO {
  @JsonKey() final List<BoardItemDTO> content;
  @JsonKey() final PageableDTO pageable;
  @JsonKey() final int totalPages;
  @JsonKey() final int totalElements;
  @JsonKey() final int numberOfElements;
  @JsonKey() final int size;
  @JsonKey() final int number;
  @JsonKey() final bool sort;
  @JsonKey() final bool first;
  @JsonKey() final bool last;
  @JsonKey() final bool empty;

  factory BoardsPageDTO.fromJson(Map<String, dynamic> json) => _$BoardsPageDTOFromJson(json);

  const BoardsPageDTO({
    required this.content,
    required this.pageable,
    required this.totalPages,
    required this.totalElements,
    required this.numberOfElements,
    required this.size,
    required this.number,
    required this.sort,
    required this.first,
    required this.last,
    required this.empty,
  });
}