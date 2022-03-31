import 'package:demo/post/domain/post.dart';
import 'package:demo/post/infrastructure/post_dto.dart';

extension DtoListToDomainList on List<PostDto> {
  List<Post> toDomain() => map((e) => e.toDomain()).toList();
}
