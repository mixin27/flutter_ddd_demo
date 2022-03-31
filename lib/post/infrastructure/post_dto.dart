import 'package:demo/post/domain/post.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_dto.freezed.dart';
part 'post_dto.g.dart';

String _stringFromJson(Object? json) {
  return (json as String?) ?? '';
}

@freezed
class PostDto with _$PostDto {
  const PostDto._();
  const factory PostDto({
    required int id,
    required int userId,
    @JsonKey(fromJson: _stringFromJson) required String title,
    @JsonKey(fromJson: _stringFromJson) required String body,
  }) = _PostDto;

  factory PostDto.fromJson(Map<String, dynamic> json) =>
      _$PostDtoFromJson(json);

  factory PostDto.fromDomain(Post _) => PostDto(
        id: _.id,
        userId: _.userId,
        title: _.title,
        body: _.body,
      );

  Post toDomain() {
    return Post(
      id: id,
      userId: userId,
      title: title,
      body: body,
    );
  }
}
