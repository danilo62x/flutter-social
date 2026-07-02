import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/comment.dart';
import '../../../core/widgets/app_widgets.dart';
import '../view_models/comments_view_model.dart';

/// Comment thread for a post: each comment shows avatar, author, text, likes
/// and a "Responder" action, with nested replies rendered indented below.
class CommentsScreen extends StatelessWidget {
  const CommentsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            if (context.canPop()) context.pop();
          },
        ),
        title: const Text('Comentários'),
      ),
      bottomNavigationBar: const _CommentInput(),
      body: Consumer<CommentsViewModel>(
        builder: (context, vm, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth =
                  constraints.maxWidth >= 700 ? 560.0 : double.infinity;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ListView(
                    padding: const EdgeInsets.only(top: 4, bottom: 12),
                    children: [
                      for (final comment in vm.comments)
                        _CommentTile(comment: comment, vm: vm),
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

class _CommentTile extends StatelessWidget {
  const _CommentTile({required this.comment, required this.vm});

  final Comment comment;
  final CommentsViewModel vm;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _CommentBody(
          comment: comment,
          avatarSize: 40,
          onLike: () => vm.toggleLike(comment.id),
        ),
        for (final reply in comment.replies)
          Padding(
            padding: const EdgeInsets.only(left: 40),
            child: _CommentBody(
              comment: reply,
              avatarSize: 30,
              onLike: () {},
            ),
          ),
        if (comment.replies.isNotEmpty)
          Padding(
            padding: const EdgeInsets.fromLTRB(64, 0, 16, 8),
            child: Row(
              children: [
                Container(
                  width: 24,
                  height: 1,
                  color: Theme.of(context).colorScheme.outlineVariant,
                ),
                const SizedBox(width: 8),
                Text(
                  'Ver ${comment.replies.length} respostas',
                  style: Theme.of(context).textTheme.bodySmall?.copyWith(
                        color: Theme.of(context).colorScheme.onSurfaceVariant,
                        fontWeight: FontWeight.w600,
                      ),
                ),
              ],
            ),
          ),
      ],
    );
  }
}

class _CommentBody extends StatelessWidget {
  const _CommentBody({
    required this.comment,
    required this.avatarSize,
    required this.onLike,
  });

  final Comment comment;
  final double avatarSize;
  final VoidCallback onLike;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 8),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GradientAvatar(
            gradient: comment.gradient,
            initials: comment.initials,
            size: avatarSize,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text(
                      comment.username,
                      style: theme.textTheme.bodyMedium?.copyWith(
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                    if (comment.isAuthor) ...[
                      const SizedBox(width: 6),
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 6, vertical: 1),
                        decoration: BoxDecoration(
                          color: scheme.primary.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(
                          'Autor',
                          style: theme.textTheme.labelSmall?.copyWith(
                            color: scheme.primary,
                            fontWeight: FontWeight.w700,
                          ),
                        ),
                      ),
                    ],
                    const Spacer(),
                    Text(
                      comment.timeAgo,
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 2),
                Text(comment.text, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 6),
                Row(
                  children: [
                    if (comment.likes > 0)
                      Padding(
                        padding: const EdgeInsets.only(right: 16),
                        child: Text(
                          '${comment.likes} curtidas',
                          style: theme.textTheme.bodySmall?.copyWith(
                            color: scheme.onSurfaceVariant,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ),
                    Text(
                      'Responder',
                      style: theme.textTheme.bodySmall?.copyWith(
                        color: scheme.onSurfaceVariant,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const SizedBox(width: 8),
          Column(
            children: [
              IconButton(
                onPressed: onLike,
                visualDensity: VisualDensity.compact,
                iconSize: 18,
                icon: Icon(
                  comment.liked ? Icons.favorite : Icons.favorite_border,
                  color: comment.liked
                      ? const Color(0xFFE1306C)
                      : scheme.onSurfaceVariant,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _CommentInput extends StatelessWidget {
  const _CommentInput();

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return SafeArea(
      top: false,
      child: Container(
        padding: const EdgeInsets.fromLTRB(12, 8, 12, 8),
        decoration: BoxDecoration(
          border: Border(
            top: BorderSide(
              color: scheme.outlineVariant.withValues(alpha: 0.4),
            ),
          ),
        ),
        child: Row(
          children: [
            GradientAvatar(
              gradient: const [Color(0xFFE1306C), Color(0xFFF77737)],
              initials: 'AS',
              size: 36,
            ),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                readOnly: true,
                decoration: InputDecoration(
                  isDense: true,
                  hintText: 'Adicione um comentário...',
                  fillColor: scheme.surfaceContainerHighest,
                  suffixIcon: Icon(
                    Icons.emoji_emotions_outlined,
                    color: scheme.onSurfaceVariant,
                  ),
                ),
              ),
            ),
            const SizedBox(width: 6),
            Text(
              'Publicar',
              style: theme.textTheme.bodyMedium?.copyWith(
                color: scheme.primary.withValues(alpha: 0.5),
                fontWeight: FontWeight.w700,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
