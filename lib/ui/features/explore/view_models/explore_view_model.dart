import 'package:flutter/foundation.dart';

import '../../../../data/repositories/post_repository.dart';
import '../../../../domain/models/explore_tile.dart';

/// Drives the Explore screen: a synchronous seed of discovery tiles plus the
/// category filter state.
class ExploreViewModel extends ChangeNotifier {
  ExploreViewModel(PostRepository postRepository)
      : _tiles = postRepository.seedExplore();

  final List<ExploreTile> _tiles;
  int _selectedCategory = 0;

  static const List<String> categories = <String>[
    'Para você',
    'Reels',
    'Viagem',
    'Comida',
    'Arte',
    'Música',
    'Estilo',
  ];

  List<ExploreTile> get tiles => List.unmodifiable(_tiles);
  int get selectedCategory => _selectedCategory;

  void selectCategory(int index) {
    if (index == _selectedCategory) return;
    _selectedCategory = index;
    notifyListeners();
  }
}
