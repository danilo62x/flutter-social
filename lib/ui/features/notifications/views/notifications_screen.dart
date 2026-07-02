import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../../domain/models/notification_item.dart';
import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/social_bottom_nav.dart';
import '../view_models/notifications_view_model.dart';

/// Activity feed: likes, comments, follows, mentions and tags, grouped into
/// time sections with avatars, contextual text and trailing actions.
class NotificationsScreen extends StatelessWidget {
  const NotificationsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Notificações')),
      bottomNavigationBar: const SocialBottomNav(currentIndex: 3),
      body: Consumer<NotificationsViewModel>(
        builder: (context, vm, _) {
          final grouped = vm.grouped;
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
                      for (final entry in grouped.entries) ...[
                        _SectionHeader(title: entry.key),
                        for (final item in entry.value)
                          _NotificationRow(item: item, vm: vm),
                      ],
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

class _SectionHeader extends StatelessWidget {
  const _SectionHeader({required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(16, 14, 16, 6),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleSmall?.copyWith(
              fontWeight: FontWeight.w800,
            ),
      ),
    );
  }
}

class _NotificationRow extends StatelessWidget {
  const _NotificationRow({required this.item, required this.vm});

  final NotificationItem item;
  final NotificationsViewModel vm;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final scheme = theme.colorScheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 7),
      child: Row(
        children: [
          GradientAvatar(
            gradient: item.gradient,
            initials: item.initials,
            size: 46,
          ),
          const SizedBox(width: 12),
          Expanded(
            child: Text.rich(
              TextSpan(
                children: [
                  TextSpan(
                    text: item.username,
                    style: theme.textTheme.bodyMedium?.copyWith(
                      fontWeight: FontWeight.w700,
                    ),
                  ),
                  TextSpan(
                    text: ' ${_message(item)} ',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextSpan(
                    text: item.timeAgo,
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: scheme.onSurfaceVariant,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(width: 10),
          _Trailing(item: item, vm: vm),
        ],
      ),
    );
  }

  String _message(NotificationItem item) {
    switch (item.kind) {
      case NotificationKind.like:
        return 'curtiu sua foto.';
      case NotificationKind.comment:
        return 'comentou: ${item.text}';
      case NotificationKind.follow:
        return 'começou a seguir você.';
      case NotificationKind.mention:
        return item.text;
      case NotificationKind.tag:
        return item.text;
    }
  }
}

class _Trailing extends StatelessWidget {
  const _Trailing({required this.item, required this.vm});

  final NotificationItem item;
  final NotificationsViewModel vm;

  @override
  Widget build(BuildContext context) {
    if (item.kind == NotificationKind.follow) {
      return item.isFollowing
          ? OutlinedButton(
              onPressed: () => vm.toggleFollow(item.id),
              style: OutlinedButton.styleFrom(
                minimumSize: const Size(96, 34),
                padding: const EdgeInsets.symmetric(horizontal: 12),
              ),
              child: const Text('Seguindo'),
            )
          : FilledButton(
              onPressed: () => vm.toggleFollow(item.id),
              style: FilledButton.styleFrom(
                minimumSize: const Size(88, 34),
                padding: const EdgeInsets.symmetric(horizontal: 16),
                textStyle: const TextStyle(
                  fontFamily: 'Roboto',
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
              child: const Text('Seguir'),
            );
    }

    if (item.postGradient != null) {
      return Container(
        width: 46,
        height: 46,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          gradient: LinearGradient(
            colors: item.postGradient!,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Icon(
          item.postIcon ?? Icons.image_outlined,
          size: 20,
          color: Colors.white.withValues(alpha: 0.5),
        ),
      );
    }

    return const SizedBox.shrink();
  }
}
