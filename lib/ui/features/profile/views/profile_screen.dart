import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/post.dart';
import '../../../../domain/models/profile.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/social_bottom_nav.dart';
import '../view_models/profile_view_model.dart';

/// User profile: avatar + stats header, bio, follow/message actions, story
/// highlights, a tab bar and a grid of the user's posts (gradient tiles).
class ProfileScreen extends StatelessWidget {
  const ProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ProfileViewModel>(
      builder: (context, vm, _) {
        final profile = vm.profile;
        return DefaultTabController(
          length: 3,
          child: Scaffold(
            appBar: AppBar(
              title: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.lock_outline, size: 18),
                  const SizedBox(width: 6),
                  Text(profile.username),
                  const Icon(Icons.keyboard_arrow_down, size: 22),
                ],
              ),
              actions: [
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.add_box_outlined),
                ),
                IconButton(
                  onPressed: () {},
                  icon: const Icon(Icons.menu),
                ),
              ],
            ),
            bottomNavigationBar: const SocialBottomNav(currentIndex: 4),
            body: LayoutBuilder(
              builder: (context, constraints) {
                final wide = constraints.maxWidth >= 700;
                final crossAxisCount = wide ? 4 : 3;
                final maxWidth = wide ? 720.0 : double.infinity;
                return Center(
                  child: ConstrainedBox(
                    constraints: BoxConstraints(maxWidth: maxWidth),
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(child: _Header(profile: profile)),
                        SliverToBoxAdapter(child: _Actions(vm: vm)),
                        SliverToBoxAdapter(
                          child: _Highlights(profile: profile),
                        ),
                        SliverToBoxAdapter(
                          child: TabBar(
                            tabs: const [
                              Tab(icon: Icon(Icons.grid_on)),
                              Tab(icon: Icon(Icons.play_circle_outline)),
                              Tab(icon: Icon(Icons.person_pin_outlined)),
                            ],
                          ),
                        ),
                        SliverPadding(
                          padding: const EdgeInsets.all(2),
                          sliver: SliverGrid(
                            gridDelegate:
                                SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: crossAxisCount,
                              mainAxisSpacing: 2,
                              crossAxisSpacing: 2,
                            ),
                            delegate: SliverChildBuilderDelegate(
                              (context, index) =>
                                  _GridTile(post: vm.posts[index], index: index),
                              childCount: vm.posts.length,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        );
      },
    );
  }
}

class _Header extends StatelessWidget {
  const _Header({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Container(
                padding: const EdgeInsets.all(3),
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  gradient: LinearGradient(
                    colors: profile.gradient,
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                ),
                child: Container(
                  padding: const EdgeInsets.all(3),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    color: scheme.surface,
                  ),
                  child: GradientAvatar(
                    gradient: profile.gradient,
                    initials: profile.initials,
                    size: 82,
                  ),
                ),
              ),
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    StatColumn(value: profile.posts, label: 'Publicações'),
                    StatColumn(value: profile.followers, label: 'Seguidores'),
                    StatColumn(value: profile.following, label: 'Seguindo'),
                  ],
                ),
              ),
            ],
          ),
          const SizedBox(height: 12),
          Row(
            children: [
              Text(
                profile.name,
                style: theme.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700,
                ),
              ),
              if (profile.isVerified) ...[
                const SizedBox(width: 4),
                Icon(Icons.verified, size: 16, color: scheme.primary),
              ],
            ],
          ),
          if (profile.category.isNotEmpty)
            Text(
              profile.category,
              style: theme.textTheme.bodySmall?.copyWith(
                color: scheme.onSurfaceVariant,
              ),
            ),
          const SizedBox(height: 4),
          Text(profile.bio, style: theme.textTheme.bodyMedium),
          if (profile.link.isNotEmpty) ...[
            const SizedBox(height: 4),
            Row(
              children: [
                Icon(Icons.link, size: 16, color: scheme.primary),
                const SizedBox(width: 4),
                Text(
                  profile.link,
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: scheme.primary,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.vm});

  final ProfileViewModel vm;

  @override
  Widget build(BuildContext context) {
    final following = vm.profile.isFollowing;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 12, 16, 4),
      child: Row(
        children: [
          Expanded(
            child: following
                ? OutlinedButton(
                    onPressed: vm.toggleFollow,
                    child: const Text('Seguindo'),
                  )
                : FilledButton(
                    onPressed: vm.toggleFollow,
                    style: FilledButton.styleFrom(
                      minimumSize: const Size.fromHeight(38),
                      textStyle: const TextStyle(
                        fontFamily: 'Roboto',
                        fontSize: 14,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                    child: const Text('Seguir'),
                  ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: OutlinedButton(
              onPressed: () {},
              child: const Text('Mensagem'),
            ),
          ),
          const SizedBox(width: 8),
          OutlinedButton(
            onPressed: () {},
            style: OutlinedButton.styleFrom(
              minimumSize: const Size(44, 38),
              padding: EdgeInsets.zero,
            ),
            child: const Icon(Icons.person_add_alt, size: 18),
          ),
        ],
      ),
    );
  }
}

class _Highlights extends StatelessWidget {
  const _Highlights({required this.profile});

  final Profile profile;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SizedBox(
      height: 108,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
        itemCount: profile.highlights.length,
        separatorBuilder: (_, _) => const SizedBox(width: 16),
        itemBuilder: (context, index) {
          final h = profile.highlights[index];
          return SizedBox(
            width: 64,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  padding: const EdgeInsets.all(2),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    border: Border.all(
                      color: theme.colorScheme.outlineVariant,
                    ),
                  ),
                  child: GradientAvatar(
                    gradient: h.gradient,
                    icon: h.icon,
                    size: 56,
                  ),
                ),
                const SizedBox(height: 4),
                Text(
                  h.label,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                  style: theme.textTheme.bodySmall,
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}

class _GridTile extends StatelessWidget {
  const _GridTile({required this.post, required this.index});

  final Post post;
  final int index;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: post.gradient,
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Stack(
        children: [
          Center(
            child: Icon(
              post.mediaIcon,
              size: 34,
              color: Colors.white.withValues(alpha: 0.4),
            ),
          ),
          if (index % 3 == 1)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.collections_outlined,
                  size: 16, color: Colors.white),
            ),
          if (index % 4 == 2)
            const Positioned(
              top: 6,
              right: 6,
              child: Icon(Icons.play_arrow, size: 18, color: Colors.white),
            ),
        ],
      ),
    );
  }
}
