import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/comment_api_model.dart';

/// Fetches a post's comments from a remote REST endpoint using package:http.
///
/// Like [PostApiService], this demonstrates the real network path; the UI/print
/// flow relies on the synchronous repository seed, so failures here are benign.
class CommentApiService {
  CommentApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint = endpoint ??
            Uri.parse('https://jsonplaceholder.typicode.com/comments');

  final http.Client _client;
  final Uri _endpoint;

  /// GET the comments for a given post id.
  Future<List<CommentApiModel>> fetchComments(String postId) async {
    final response = await _client.get(
      _endpoint.replace(queryParameters: {'postId': postId}),
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load comments (HTTP ${response.statusCode})');
    }

    final decoded = json.decode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(CommentApiModel.fromJson)
        .toList(growable: false);
  }

  void dispose() => _client.close();
}
