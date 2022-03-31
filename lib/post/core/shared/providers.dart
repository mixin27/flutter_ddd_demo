import 'package:demo/post/application/post_notifier.dart';
import 'package:demo/post/infrastructure/post_remote_service.dart';
import 'package:demo/post/infrastructure/post_repository.dart';
import 'package:dio/dio.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final dioProvider = Provider(
  (ref) => Dio(),
);

final postRemoteServiceProvider = Provider(
  (ref) => PostRemoteService(
    ref.watch(dioProvider),
  ),
);

final postRepository = Provider<PostRepository>(
  (ref) => PostRepositoryImpl(
    ref.watch(postRemoteServiceProvider),
  ),
);

final postNotifierProvider = StateNotifierProvider<PostNotifier, PostState>(
  (ref) => PostNotifier(
    ref.watch(
      postRepository,
    ),
  ),
);
