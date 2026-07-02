import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/social_bottom_nav.dart';
import '../view_models/feed_view_model.dart';

/// Instagram-style social feed: stories strip + a scrollable list of posts.
/// This is the home tab and the first screen captured by print_test.
class FeedScreen extends StatelessWidget {
  const FeedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: const BrandMark(text: 'Pulse'),
        actions: [
          IconButton(
            tooltip: 'Curtidas',
            onPressed: () {},
            icon: const Icon(Icons.favorite_border),
          ),
          IconButton(
            tooltip: 'Mensagens',
            onPressed: () => context.push('/messages'),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          const SizedBox(width: 4),
        ],
      ),
      bottomNavigationBar: const SocialBottomNav(currentIndex: 0),
      body: Consumer<FeedViewModel>(
        builder: (context, vm, _) {
          // Responsive: center and constrain width on wide screens.
          return LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth =
                  constraints.maxWidth >= 700 ? 520.0 : double.infinity;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: CustomScrollView(
                    slivers: [
                      // Stories strip
                      SliverToBoxAdapter(
                        child: StoriesBar(stories: vm.stories),
                      ),
                      SliverToBoxAdapter(
                        child: Divider(
                          height: 1,
                          thickness: 1,
                          color: scheme.outlineVariant.withValues(alpha: 0.5),
                        ),
                      ),
                      // Posts
                      SliverList.separated(
                        itemCount: vm.posts.length,
                        separatorBuilder: (_, _) => Divider(
                          height: 1,
                          thickness: 1,
                          color: scheme.outlineVariant.withValues(alpha: 0.4),
                        ),
                        itemBuilder: (context, index) {
                          final post = vm.posts[index];
                          return PostCard(
                            post: post,
                            onLike: () => vm.toggleLike(post.id),
                            onOpen: () => context.push('/post/${post.id}'),
                            onComments: () =>
                                context.push('/post/${post.id}/comments'),
                          );
                        },
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
    );
  }
}
