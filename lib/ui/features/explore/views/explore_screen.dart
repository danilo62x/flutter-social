import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../core/format.dart';
import '../../../../domain/models/explore_tile.dart';
import '../../../core/widgets/social_bottom_nav.dart';
import '../view_models/explore_view_model.dart';

/// Discovery grid with a search field, category chips, a featured trending
/// card and a varied grid of gradient tiles (photos, reels and carousels).
class ExploreScreen extends StatelessWidget {
  const ExploreScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Scaffold(
      bottomNavigationBar: const SocialBottomNav(currentIndex: 1),
      body: SafeArea(
        bottom: false,
        child: Consumer<ExploreViewModel>(
          builder: (context, vm, _) {
            final tiles = vm.tiles;
            return LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 700;
                final crossAxisCount = wide ? 4 : 3;
                final maxWidth = wide ? 900.0 : double.infinity;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
                            child: TextField(
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Buscar',
                                prefixIcon: Icon(Icons.search),
                                isDense: true,
                              ),
                            ),
                          ),
                        ),
                        SliverToBoxAdapter(child: _Categories(vm: vm)),
                        SliverToBoxAdapter(child: _FeaturedCard(scheme: scheme)),
                        SliverToBoxAdapter(
                          child: Padding(
                            padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                            child: Text(
                              'Em alta para você',
                              style: theme.textTheme.titleSmall?.copyWith(
                                fontWeight: FontWeight.w700,
                              ),
                            ),
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.symmetric(horizontal: 2),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _TileView(tile: tiles[index]),
                              childCount: tiles.length,
                            ),
                          ),
                        ),
                        const SliverToBoxAdapter(child: SizedBox(height: 12)),
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class _Categories extends StatelessWidget {
  const _Categories({required this.vm});

  final ExploreViewModel vm;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 44,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        itemCount: ExploreViewModel.categories.length,
        separatorBuilder: (_, _) => const SizedBox(width: 8),
        itemBuilder: (context, index) {
          final selected = index == vm.selectedCategory;
          return ChoiceChip(
            label: Text(ExploreViewModel.categories[index]),
            selected: selected,
            onSelected: (_) => vm.selectCategory(index),
            labelStyle: TextStyle(
              fontFamily: 'Roboto',
              fontSize: 13,
              fontWeight: FontWeight.w600,
              color: selected
                  ? Theme.of(context).colorScheme.onPrimary
                  : Theme.of(context).colorScheme.onSurface,
            ),
            selectedColor: Theme.of(context).colorScheme.primary,
            showCheckmark: false,
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(20),
            ),
          );
        },
      ),
    );
  }
}

class _FeaturedCard extends StatelessWidget {
  const _FeaturedCard({required this.scheme});

  final ColorScheme scheme;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Container(
        height: 120,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: const LinearGradient(
            colors: <Color>[Color(0xFF7B2FF7), Color(0xFFE1306C), Color(0xFFF77737)],
            begin: Alignment.centerLeft,
            end: Alignment.centerRight,
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(18),
          child: Row(
            children: [
              Expanded(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Tendências da semana',
                      style: theme.textTheme.titleMedium?.copyWith(
                        color: Colors.white,
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(height: 4),
                    Text(
                      'Descubra criadores em alta perto de você',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: Colors.white.withValues(alpha: 0.9),
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                width: 52,
                height: 52,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withValues(alpha: 0.2),
                ),
                child: const Icon(Icons.trending_up,
                    color: Colors.white, size: 28),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _TileView extends StatelessWidget {
  const _TileView({required this.tile});

  final ExploreTile tile;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: tile.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              tile.icon,
              size: 34,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          if (tile.kind == TileKind.carousel)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.collections_outlined,
                  size: 16, color: Colors.white),
            ),
          if (tile.kind == TileKind.reel) ...[
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.slideshow_outlined,
                  size: 16, color: Colors.white),
            ),
            Positioned(
              left: 6,
              bottom: 6,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.play_arrow, size: 14, color: Colors.white),
                  const SizedBox(width: 2),
                  Text(
                    compact(tile.views),
                    style: const TextStyle(
                      fontFamily: 'Roboto',
                      color: Colors.white,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ],
      ),
    );
  }
}
