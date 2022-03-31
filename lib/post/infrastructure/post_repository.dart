import 'package:dartz/dartz.dart';
import 'package:demo/core/infrastructure/network_exception.dart';
import 'package:demo/post/domain/post.dart';
import 'package:demo/post/domain/post_failure.dart';
import 'package:demo/post/infrastructure/post_remote_service.dart';

import './extensions.dart';

abstract class PostRepository {
  Future<Either<PostFailure, List<Post>>> getAllPosts();
}

class PostRepositoryImpl implements PostRepository {
  // data sources
  // remote or local
  final PostRemoteService _remoteService;
  // todo: add PostLocalService

  PostRepositoryImpl(this._remoteService);

  @override
  Future<Either<PostFailure, List<Post>>> getAllPosts() async {
    try {
      final remoteItems = await _remoteService.getAllPosts();

      return right(
        await remoteItems.when(
          noConnection: () => [],
          withData: (posts) => posts.toDomain(),
        ),
      );
    } on NetworkException catch (e) {
      return left(PostFailure.api(e.errorCode));
    }
  }
}
