import 'package:demo/core/infrastructure/dio_extensions.dart';
import 'package:demo/core/infrastructure/network_exception.dart';
import 'package:demo/core/infrastructure/remote_response.dart';
import 'package:demo/post/infrastructure/post_dto.dart';
import 'package:dio/dio.dart';

class PostRemoteService {
  final Dio _dio;

  PostRemoteService(this._dio);

  // get all posts
  Future<RemoteResponse<List<PostDto>>> getAllPosts() async {
    try {
      final response =
          await _dio.get('https://jsonplaceholder.typicode.com/posts');

      if (response.statusCode == 200) {
        // We dont't need to decode json
        final convertedData = response.data as List<dynamic>;
        final posts = convertedData
            .map((postJson) =>
                PostDto.fromJson(postJson as Map<String, dynamic>))
            .toList();

        // todos: save data to local storage, etc.

        return RemoteResponse.withData(posts);
      } else {
        throw NetworkException(response.statusCode);
      }
    } on DioError catch (e) {
      if (e.isNoConnectionError) {
        return const RemoteResponse.noConnection();
      } else if (e.error != null) {
        throw NetworkException(e.response?.statusCode);
      } else {
        rethrow;
      }
    }
  }
}
