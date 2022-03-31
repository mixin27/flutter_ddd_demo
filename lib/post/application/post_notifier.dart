import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

import '../domain/post.dart';
import '../domain/post_failure.dart';
import '../infrastructure/post_repository.dart';

part 'post_notifier.freezed.dart';

@freezed
class PostState with _$PostState {
  const factory PostState.initial(List<Post> posts) = _Initial;
  const factory PostState.loadInProgress() = _LoadInProgress;
  const factory PostState.loadSucces(List<Post> posts) = _LoadSucces;
  const factory PostState.loadFailure(PostFailure failure) = _LoadFailure;
}

class PostNotifier extends StateNotifier<PostState> {
  PostNotifier(this._repository) : super(const PostState.initial([]));

  final PostRepository _repository;

  // get all posts
  Future<void> getAllPosts() async {
    state = const PostState.loadInProgress();

    final failureOrSuccess = await _repository.getAllPosts();
    state = failureOrSuccess.fold(
      (f) => PostState.loadFailure(f),
      (posts) => PostState.loadSucces(posts),
    );
  }
}
