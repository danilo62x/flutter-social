import 'package:flutter/material.dart';

import '../../domain/models/profile.dart';

/// Provides the current user's profile as a synchronous seed so the profile
/// screen renders immediately.
class ProfileRepository {
  Profile seed() {
    return const Profile(
      name: 'Ana Souza',
      username: 'ana.souza',
      bio: 'Fotógrafa de viagens e luz natural.\nCapturando o mundo um pôr do sol por vez.',
      posts: 248,
      followers: 18400,
      following: 312,
      gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
      category: 'Criadora de conteúdo digital',
      link: 'anasouza.com/portfolio',
      isVerified: true,
      isFollowing: false,
      highlights: <ProfileHighlight>[
        ProfileHighlight(
          label: 'Viagens',
          gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
          icon: Icons.flight_takeoff_outlined,
        ),
        ProfileHighlight(
          label: 'Praias',
          gradient: <Color>[Color(0xFF00C6FB), Color(0xFF005BEA)],
          icon: Icons.beach_access_outlined,
        ),
        ProfileHighlight(
          label: 'Cafés',
          gradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
          icon: Icons.local_cafe_outlined,
        ),
        ProfileHighlight(
          label: 'Arte',
          gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
          icon: Icons.palette_outlined,
        ),
        ProfileHighlight(
          label: 'Setup',
          gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
          icon: Icons.camera_alt_outlined,
        ),
      ],
    );
  }
}
