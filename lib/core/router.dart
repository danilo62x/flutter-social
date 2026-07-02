import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../data/repositories/comment_repository.dart';
import '../data/repositories/message_repository.dart';
import '../data/repositories/notification_repository.dart';
import '../data/repositories/post_repository.dart';
import '../data/repositories/profile_repository.dart';
import '../domain/models/post.dart';
import '../ui/features/comments/view_models/comments_view_model.dart';
import '../ui/features/comments/views/comments_screen.dart';
import '../ui/features/create/view_models/create_post_view_model.dart';
import '../ui/features/create/views/create_post_screen.dart';
import '../ui/features/explore/view_models/explore_view_model.dart';
import '../ui/features/explore/views/explore_screen.dart';
import '../ui/features/feed/view_models/feed_view_model.dart';
import '../ui/features/feed/views/feed_screen.dart';
import '../ui/features/messages/view_models/messages_view_model.dart';
import '../ui/features/messages/views/messages_screen.dart';
import '../ui/features/notifications/view_models/notifications_view_model.dart';
import '../ui/features/notifications/views/notifications_screen.dart';
import '../ui/features/post/view_models/post_detail_view_model.dart';
import '../ui/features/post/views/post_detail_screen.dart';
import '../ui/features/profile/view_models/profile_view_model.dart';
import '../ui/features/profile/views/profile_screen.dart';

/// Declarative routing with go_router. Five primary destinations sit at the
/// top level (driven by the bottom nav) and detail screens are pushed on top.
class AppRouter {
  static GoRouter build(PostRepository postRepository) {
    final commentRepository = CommentRepository();
    final profileRepository = ProfileRepository();
    final notificationRepository = NotificationRepository();
    final messageRepository = MessageRepository();

    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => FeedViewModel(postRepository),
            child: const FeedScreen(),
          ),
        ),
        GoRoute(
          path: '/explore',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => ExploreViewModel(postRepository),
            child: const ExploreScreen(),
          ),
        ),
        GoRoute(
          path: '/create',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => CreatePostViewModel(),
            child: const CreatePostScreen(),
          ),
        ),
        GoRoute(
          path: '/notifications',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => NotificationsViewModel(notificationRepository),
            child: const NotificationsScreen(),
          ),
        ),
        GoRoute(
          path: '/profile',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) =>
                ProfileViewModel(profileRepository, postRepository),
            child: const ProfileScreen(),
          ),
        ),
        GoRoute(
          path: '/messages',
          builder: (context, state) => ChangeNotifierProvider(
            create: (_) => MessagesViewModel(messageRepository),
            child: const MessagesScreen(),
          ),
        ),
        GoRoute(
          path: '/post/:id',
          builder: (context, state) {
            final id = state.pathParameters['id'] ?? '';
            final post = state.extra as Post? ?? postRepository.postById(id);
            return ChangeNotifierProvider(
              create: (_) => PostDetailViewModel(post, commentRepository),
              child: const PostDetailScreen(),
            );
          },
          routes: [
            GoRoute(
              path: 'comments',
              builder: (context, state) => ChangeNotifierProvider(
                create: (_) => CommentsViewModel(commentRepository),
                child: const CommentsScreen(),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
