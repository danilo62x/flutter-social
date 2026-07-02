import 'dart:convert';

import 'package:http/http.dart' as http;

import '../models/post_api_model.dart';

/// Talks to a remote REST endpoint using package:http.
///
/// This demonstrates the real network path. The UI/print flow relies on the
/// synchronous repository seed, so a network failure here is non-fatal.
class PostApiService {
  PostApiService({http.Client? client, Uri? endpoint})
      : _client = client ?? http.Client(),
        _endpoint =
            endpoint ?? Uri.parse('https://jsonplaceholder.typicode.com/posts');

  final http.Client _client;
  final Uri _endpoint;

  /// GET a list of posts from the demo endpoint.
  Future<List<PostApiModel>> fetchPosts() async {
    final response = await _client.get(
      _endpoint,
      headers: const {'Accept': 'application/json'},
    );

    if (response.statusCode != 200) {
      throw Exception('Failed to load posts (HTTP ${response.statusCode})');
    }

    final decoded = json.decode(response.body) as List<dynamic>;
    return decoded
        .whereType<Map<String, dynamic>>()
        .map(PostApiModel.fromJson)
        .toList(growable: false);
  }

  void dispose() => _client.close();
}
