import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../core/format.dart';
import '../../../../domain/models/comment.dart';
import '../../../../domain/models/post.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/post_detail_view_model.dart';

/// Full-screen detail for a single post: large gradient media, author, actions
/// (like / comment / share / save), likes, caption and a comment preview.
class PostDetailScreen extends StatelessWidget {
  const PostDetailScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;

    return Consumer<PostDetailViewModel>(
      builder: (context, vm, _) {
        final post = vm.post;
        return Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: const Icon(Icons.arrow_back),
              onPressed: () {
                if (context.canPop()) context.pop();
              },
            ),
            title: Text(post.username),
            actions: [
              IconButton(onPressed: () {}, icon: const Icon(Icons.more_vert)),
            ],
          ),
          bottomNavigationBar: _AddCommentBar(gradient: post.gradient),
          body: LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth =
                  constraints.maxWidth >= 700 ? 560.0 : double.infinity;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ListView(
                    padding: EdgeInsets.zero,
                    children: [
                      _AuthorRow(post: post),
                      _Media(post: post),
                      _Actions(vm: vm),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          '${thousands(post.likes)} curtidas',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      const SizedBox(height: 6),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                text: '${post.username}  ',
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              TextSpan(
                                text: post.caption,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ],
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Wrap(
                          spacing: 8,
                          children: [
                            for (final tag in const [
                              '#pordosol',
                              '#viagem',
                              '#fotografia',
                            ])
                              Text(
                                tag,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  color: scheme.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 14),
                      Divider(
                        color: scheme.outlineVariant.withValues(alpha: 0.4),
                      ),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 8, 16, 6),
                        child: Text(
                          'Comentários',
                          style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                      for (final c in vm.preview) _CommentPreview(comment: c),
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 4, 16, 12),
                        child: GestureDetector(
                          onTap: () =>
                              context.push('/post/${post.id}/comments'),
                          child: Text(
                            'Ver todos os ${post.comments} comentários',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: scheme.onSurfaceVariant,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    );
  }
}

class _AuthorRow extends StatelessWidget {
  const _AuthorRow({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 6, 8, 6),
      child: Row(
        children: [
          GradientAvatar(
            gradient: post.gradient,
            initials: post.initials,
            size: 42,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  post.username,
                  style: theme.textTheme.titleSmall?.copyWith(
                    fontWeight: FontWeight.w700,
                  ),
                ),
                Text(
                  'Rio de Janeiro, Brasil',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.onSurfaceVariant,
                  ),
                ),
              ],
            ),
          ),
          FilledButton.tonal(
            onPressed: () {},
            style: FilledButton.styleFrom(
              minimumSize: const Size(92, 36),
              padding: const EdgeInsets.symmetric(horizontal: 16),
              textStyle: const TextStyle(
                fontFamily: 'Roboto',
                fontSize: 13,
                fontWeight: FontWeight.w600,
              ),
            ),
            child: const Text('Seguir'),
          ),
          const SizedBox(width: 4),
        ],
      ),
    );
  }
}

class _Media extends StatelessWidget {
  const _Media({required this.post});

  final Post post;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 1,
      child: Container(
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
                size: 108,
                color: Colors.white.withValues(alpha: 0.35),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: const [
                    Icon(Icons.collections_outlined,
                        size: 14, color: Colors.white),
                    SizedBox(width: 4),
                    Text(
                      '1/3',
                      style: TextStyle(
                        fontFamily: 'Roboto',
                        color: Colors.white,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Actions extends StatelessWidget {
  const _Actions({required this.vm});

  final PostDetailViewModel vm;

  @override
  Widget build(BuildContext context) {
    final post = vm.post;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
      child: Row(
        children: [
          IconButton(
            onPressed: vm.toggleLike,
            icon: Icon(
              post.liked ? Icons.favorite : Icons.favorite_border,
              color: post.liked ? const Color(0xFFE1306C) : null,
            ),
          ),
          IconButton(
            onPressed: () => context.push('/post/${post.id}/comments'),
            icon: const Icon(Icons.chat_bubble_outline),
          ),
          IconButton(
            onPressed: () {},
            icon: const Icon(Icons.send_outlined),
          ),
          const Spacer(),
          IconButton(
            onPressed: vm.toggleSave,
            icon: Icon(vm.saved ? Icons.bookmark : Icons.bookmark_border),
          ),
        ],
      ),
    );
  }
}

class _CommentPreview extends StatelessWidget {
  const _CommentPreview({required this.comment});

  final Comment comment;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 6, 16, 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientAvatar(
            gradient: comment.gradient,
            initials: comment.initials,
            size: 32,
          ),
          const SizedBox(width: 10),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: '${comment.username}  ',
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: comment.text,
                    style: theme.textTheme.bodyMedium,
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 8),
          Icon(
            comment.liked ? Icons.favorite : Icons.favorite_border,
            size: 16,
            color: comment.liked
                ? const Color(0xFFE1306C)
                : theme.colorScheme.onSurfaceVariant,
          ),
        ],
      ),
    );
  }
}

class _AddCommentBar extends StatelessWidget {
  const _AddCommentBar({required this.gradient});

  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: theme.colorScheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Row(
          children: [
            GradientAvatar(
              gradient: const [Color(0xFF9E9E9E), Color(0xFF616161)],
              icon: Icons.person,
              size: 34,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: Text(
                'Adicione um comentário...',
                style: theme.textTheme.bodyMedium?.copyWith(
                  color: theme.colorScheme.onSurfaceVariant,
                ),
              ),
            ),
            Text(
              'Publicar',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.primary.withValues(alpha: 0.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
