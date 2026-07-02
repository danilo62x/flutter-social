import 'dart:io';
import 'dart:ui' as ui;

import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:social/core/theme.dart';
import 'package:social/data/repositories/comment_repository.dart';
import 'package:social/data/repositories/message_repository.dart';
import 'package:social/data/repositories/notification_repository.dart';
import 'package:social/data/repositories/post_repository.dart';
import 'package:social/data/repositories/profile_repository.dart';
import 'package:social/ui/features/comments/view_models/comments_view_model.dart';
import 'package:social/ui/features/comments/views/comments_screen.dart';
import 'package:social/ui/features/create/view_models/create_post_view_model.dart';
import 'package:social/ui/features/create/views/create_post_screen.dart';
import 'package:social/ui/features/explore/view_models/explore_view_model.dart';
import 'package:social/ui/features/explore/views/explore_screen.dart';
import 'package:social/ui/features/feed/view_models/feed_view_model.dart';
import 'package:social/ui/features/feed/views/feed_screen.dart';
import 'package:social/ui/features/messages/view_models/messages_view_model.dart';
import 'package:social/ui/features/messages/views/messages_screen.dart';
import 'package:social/ui/features/notifications/view_models/notifications_view_model.dart';
import 'package:social/ui/features/notifications/views/notifications_screen.dart';
import 'package:social/ui/features/post/view_models/post_detail_view_model.dart';
import 'package:social/ui/features/post/views/post_detail_screen.dart';
import 'package:social/ui/features/profile/view_models/profile_view_model.dart';
import 'package:social/ui/features/profile/views/profile_screen.dart';

import 'golden_utils.dart';

typedef PageBuilder = Widget Function();

void main() {
  final postRepository = PostRepository();
  final commentRepository = CommentRepository();
  final profileRepository = ProfileRepository();
  final notificationRepository = NotificationRepository();
  final messageRepository = MessageRepository();

  // Gallery order (light first, then the same screens in dark).
  final pages = <(String, PageBuilder)>[
    (
      'Feed',
      () => ChangeNotifierProvider(
            create: (_) => FeedViewModel(postRepository),
            child: const FeedScreen(),
          ),
    ),
    (
      'Post',
      () => ChangeNotifierProvider(
            create: (_) => PostDetailViewModel(
              postRepository.seed().first,
              commentRepository,
            ),
            child: const PostDetailScreen(),
          ),
    ),
    (
      'Perfil',
      () => ChangeNotifierProvider(
            create: (_) =>
                ProfileViewModel(profileRepository, postRepository),
            child: const ProfileScreen(),
          ),
    ),
    (
      'Explorar',
      () => ChangeNotifierProvider(
            create: (_) => ExploreViewModel(postRepository),
            child: const ExploreScreen(),
          ),
    ),
    (
      'Criar post',
      () => ChangeNotifierProvider(
            create: (_) => CreatePostViewModel(),
            child: const CreatePostScreen(),
          ),
    ),
    (
      'Notificacoes',
      () => ChangeNotifierProvider(
            create: (_) => NotificationsViewModel(notificationRepository),
            child: const NotificationsScreen(),
          ),
    ),
    (
      'Mensagens',
      () => ChangeNotifierProvider(
            create: (_) => MessagesViewModel(messageRepository),
            child: const MessagesScreen(),
          ),
    ),
    (
      'Comentarios',
      () => ChangeNotifierProvider(
            create: (_) => CommentsViewModel(commentRepository),
            child: const CommentsScreen(),
          ),
    ),
  ];

  testWidgets('social screenshots (claro+escuro)', (tester) async {
    await loadGoldenFonts();
    tester.binding.focusManager.highlightStrategy =
        FocusHighlightStrategy.alwaysTouch;
    tester.view.devicePixelRatio = 1.0;
    tester.view.physicalSize = const Size(390, 844);
    addTearDown(tester.view.reset);

    var idx = 0; // 0 -> social.png, 1 -> social-2.png, ...
    for (final theme in <ThemeData>[AppTheme.light(), AppTheme.dark()]) {
      for (final page in pages) {
        final key = GlobalKey();
        await tester.pumpWidget(
          RepaintBoundary(
            key: key,
            child: MaterialApp(
              debugShowCheckedModeBanner: false,
              theme: theme,
              home: page.$2(),
            ),
          ),
        );
        await tester.pump(const Duration(milliseconds: 600));

        await tester.runAsync(() async {
          final boundary =
              key.currentContext!.findRenderObject()! as RenderRepaintBoundary;
          final image = await boundary.toImage(pixelRatio: 3.0);
          final bytes = await image.toByteData(format: ui.ImageByteFormat.png);
          final suffix = idx == 0 ? '' : '-${idx + 1}';
          final file = File('screenshots/social$suffix.png');
          await file.create(recursive: true);
          await file.writeAsBytes(bytes!.buffer.asUint8List());
        });
        idx++;
      }
    }
  });
}
