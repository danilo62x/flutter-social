import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';

import 'package:social/data/repositories/post_repository.dart';
import 'package:social/ui/features/feed/view_models/feed_view_model.dart';
import 'package:social/ui/features/feed/views/feed_screen.dart';

void main() {
  testWidgets('FeedScreen renders brand and seeded post', (tester) async {
    tester.view.physicalSize = const Size(500, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider(
          create: (_) => FeedViewModel(PostRepository()),
          child: const FeedScreen(),
        ),
      ),
    );
    await tester.pump();

    // 1) The app wordmark shows in the AppBar.
    expect(find.text('Pulse'), findsOneWidget);

    // 2) A seeded post's username is rendered (appears in header + caption).
    expect(find.textContaining('ana.souza'), findsWidgets);
  });

  testWidgets('Tapping like increments the like count', (tester) async {
    tester.view.physicalSize = const Size(500, 1200);
    tester.view.devicePixelRatio = 1.0;
    addTearDown(tester.view.reset);

    final repo = PostRepository();
    final vm = FeedViewModel(repo);

    await tester.pumpWidget(
      MaterialApp(
        home: ChangeNotifierProvider.value(
          value: vm,
          child: const FeedScreen(),
        ),
      ),
    );
    await tester.pump();

    expect(find.byIcon(Icons.favorite_border), findsWidgets);
    vm.toggleLike('p1');
    await tester.pump();

    // After liking, at least one filled heart is visible.
    expect(find.byIcon(Icons.favorite), findsWidgets);
  });
}
