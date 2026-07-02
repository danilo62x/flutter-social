import 'package:flutter/material.dart';

import '../../domain/models/comment.dart';
import '../services/comment_api_service.dart';

/// Exposes a SYNCHRONOUS seed (so threads render on the first frame) plus a
/// real async [fetch] backed by [CommentApiService].
class CommentRepository {
  CommentRepository({CommentApiService? service})
      : _service = service ?? CommentApiService();

  final CommentApiService _service;

  /// Full comment thread for a post, including a couple of nested replies.
  List<Comment> seed() {
    return const <Comment>[
      Comment(
        id: 'c1',
        username: 'lucas.dev',
        text: 'Que luz incrível! Qual câmera você usou nessa?',
        timeAgo: '2h',
        likes: 24,
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        replies: <Comment>[
          Comment(
            id: 'c1r1',
            username: 'ana.souza',
            text: 'Obrigada! Foi só o celular mesmo, no fim de tarde.',
            timeAgo: '1h',
            likes: 8,
            gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
            isAuthor: true,
          ),
        ],
      ),
      Comment(
        id: 'c2',
        username: 'marina.art',
        text: 'A paleta de cores dessa foto está perfeita, salvei pra referência.',
        timeAgo: '3h',
        likes: 56,
        liked: true,
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
      ),
      Comment(
        id: 'c3',
        username: 'pedro.foto',
        text: 'Composição impecável. Bora marcar aquela sessão na praia?',
        timeAgo: '4h',
        likes: 12,
        gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
        replies: <Comment>[
          Comment(
            id: 'c3r1',
            username: 'bia.lima',
            text: 'Também quero ir!',
            timeAgo: '3h',
            likes: 3,
            gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
          ),
        ],
      ),
      Comment(
        id: 'c4',
        username: 'rafa.trip',
        text: 'Esse lugar entrou pra minha lista de viagens agora.',
        timeAgo: '6h',
        likes: 9,
        gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
      ),
      Comment(
        id: 'c5',
        username: 'julia.mkt',
        text: 'Conteúdo sempre impecável, parabéns pelo trabalho!',
        timeAgo: '8h',
        likes: 17,
        gradient: <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
      ),
    ];
  }

  /// The first two comments, used as a preview on the feed and post detail.
  List<Comment> seedPreview() => seed().take(2).toList(growable: false);

  /// Real async path backed by the API service.
  Future<List<Comment>> fetch(String postId) async {
    final apiModels = await _service.fetchComments(postId);
    return apiModels.map((m) => m.toDomain()).toList(growable: false);
  }
}
