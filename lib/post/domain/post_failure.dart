import 'package:freezed_annotation/freezed_annotation.dart';

part 'post_failure.freezed.dart';

@freezed
class PostFailure with _$PostFailure {
  const factory PostFailure.api([
    int? errorCode,
    String? message,
  ]) = _PostFailure;
}
