import 'package:flutter/material.dart';

import '../../domain/models/explore_tile.dart';
import '../../domain/models/post.dart';
import '../services/post_api_service.dart';

/// A story bubble shown in the horizontal strip at the top of the feed.
class Story {
  const Story({
    required this.name,
    required this.gradient,
    this.isSelf = false,
  });

  final String name;
  final List<Color> gradient;
  final bool isSelf;

  String get initials {
    final parts = name.trim().split(RegExp(r'\s+'));
    final buffer = StringBuffer();
    for (final part in parts.take(2)) {
      if (part.isNotEmpty) buffer.write(part[0].toUpperCase());
    }
    final result = buffer.toString();
    return result.isEmpty ? '?' : result;
  }
}

/// Repository that exposes a SYNCHRONOUS seed (so the first frame has content)
/// plus a real async [fetch] backed by the API service.
class PostRepository {
  PostRepository({PostApiService? service})
      : _service = service ?? PostApiService();

  final PostApiService _service;

  /// Synchronous, deterministic data used to render the very first frame.
  List<Post> seed() {
    return const <Post>[
      Post(
        id: 'p1',
        username: 'ana.souza',
        timeAgo: '2h',
        caption: 'Fim de tarde perfeito na orla, luz dourada demais.',
        likes: 1234,
        comments: 42,
        gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
        mediaIcon: Icons.wb_twilight,
      ),
      Post(
        id: 'p2',
        username: 'lucas.dev',
        timeAgo: '5h',
        caption: 'Novo setup pronto pra semana de foco total.',
        likes: 872,
        comments: 63,
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        mediaIcon: Icons.desktop_windows_outlined,
      ),
      Post(
        id: 'p3',
        username: 'marina.art',
        timeAgo: '1d',
        caption: 'Estudo de cores da semana, gostei do resultado.',
        likes: 2540,
        comments: 128,
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
        mediaIcon: Icons.palette_outlined,
      ),
    ];
  }

  /// Story bubbles for the top strip (synchronous seed).
  List<Story> seedStories() {
    return const <Story>[
      Story(
        name: 'Você',
        gradient: <Color>[Color(0xFF9E9E9E), Color(0xFF616161)],
        isSelf: true,
      ),
      Story(name: 'Ana', gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)]),
      Story(name: 'Lucas', gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)]),
      Story(name: 'Marina', gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)]),
      Story(name: 'Pedro', gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)]),
      Story(name: 'Bia', gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)]),
      Story(name: 'Rafa', gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)]),
    ];
  }

  /// Looks up a single seeded post by id (falls back to the first post so a
  /// deep link never lands on an empty detail screen).
  Post postById(String id) {
    final posts = seed();
    return posts.firstWhere(
      (p) => p.id == id,
      orElse: () => posts.first,
    );
  }

  /// Discovery tiles for the Explore grid (synchronous seed). A deliberately
  /// varied mix of photos, reels and carousels with a featured tall tile.
  List<ExploreTile> seedExplore() {
    return const <ExploreTile>[
      ExploreTile(
        id: 'e1',
        gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
        icon: Icons.landscape_outlined,
        kind: TileKind.carousel,
        tall: true,
      ),
      ExploreTile(
        id: 'e2',
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        icon: Icons.play_arrow_rounded,
        kind: TileKind.reel,
        views: 128000,
      ),
      ExploreTile(
        id: 'e3',
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
        icon: Icons.restaurant_outlined,
      ),
      ExploreTile(
        id: 'e4',
        gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
        icon: Icons.palette_outlined,
      ),
      ExploreTile(
        id: 'e5',
        gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
        icon: Icons.flight_takeoff_outlined,
        kind: TileKind.reel,
        views: 54200,
      ),
      ExploreTile(
        id: 'e6',
        gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
        icon: Icons.local_cafe_outlined,
      ),
      ExploreTile(
        id: 'e7',
        gradient: <Color>[Color(0xFF00C6FB), Color(0xFF005BEA)],
        icon: Icons.waves_outlined,
        kind: TileKind.carousel,
      ),
      ExploreTile(
        id: 'e8',
        gradient: <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
        icon: Icons.music_note_outlined,
        kind: TileKind.reel,
        views: 312000,
      ),
      ExploreTile(
        id: 'e9',
        gradient: <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
        icon: Icons.park_outlined,
      ),
      ExploreTile(
        id: 'e10',
        gradient: <Color>[Color(0xFFDA22FF), Color(0xFF9733EE)],
        icon: Icons.camera_alt_outlined,
      ),
      ExploreTile(
        id: 'e11',
        gradient: <Color>[Color(0xFFFF9966), Color(0xFFFF5E62)],
        icon: Icons.pets_outlined,
        kind: TileKind.carousel,
      ),
      ExploreTile(
        id: 'e12',
        gradient: <Color>[Color(0xFF4776E6), Color(0xFF8E54E9)],
        icon: Icons.sports_basketball_outlined,
        kind: TileKind.reel,
        views: 88700,
      ),
      ExploreTile(
        id: 'e13',
        gradient: <Color>[Color(0xFFFFAFBD), Color(0xFFFFC3A0)],
        icon: Icons.cake_outlined,
      ),
      ExploreTile(
        id: 'e14',
        gradient: <Color>[Color(0xFF232526), Color(0xFF414345)],
        icon: Icons.nightlife_outlined,
      ),
      ExploreTile(
        id: 'e15',
        gradient: <Color>[Color(0xFF1D976C), Color(0xFF93F9B9)],
        icon: Icons.spa_outlined,
      ),
    ];
  }

  /// Grid of a user's own posts, used on the profile screen (synchronous seed).
  List<Post> seedProfilePosts() {
    const gradients = <List<Color>>[
      <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
      <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
      <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
      <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
      <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
      <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
      <Color>[Color(0xFF00C6FB), Color(0xFF005BEA)],
      <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
      <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
    ];
    const icons = <IconData>[
      Icons.wb_twilight,
      Icons.landscape_outlined,
      Icons.local_cafe_outlined,
      Icons.palette_outlined,
      Icons.flight_takeoff_outlined,
      Icons.restaurant_outlined,
      Icons.waves_outlined,
      Icons.camera_alt_outlined,
      Icons.park_outlined,
    ];
    return <Post>[
      for (var i = 0; i < gradients.length; i++)
        Post(
          id: 'g${i + 1}',
          username: 'ana.souza',
          timeAgo: '${i + 1}d',
          caption: '',
          likes: 420 + i * 137,
          comments: 12 + i * 5,
          gradient: gradients[i],
          mediaIcon: icons[i],
        ),
    ];
  }

  /// Real async path: fetches from the network and maps to domain models.
  Future<List<Post>> fetch() async {
    final apiModels = await _service.fetchPosts();
    return apiModels.map((m) => m.toDomain()).toList(growable: false);
  }
}
