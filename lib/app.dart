import 'package:flutter/material.dart';

import 'core/router.dart';
import 'core/theme.dart';
import 'data/repositories/post_repository.dart';

class SocialApp extends StatefulWidget {
  const SocialApp({super.key});

  @override
  State<SocialApp> createState() => _SocialAppState();
}

class _SocialAppState extends State<SocialApp> {
  late final PostRepository _repository = PostRepository();
  late final _router = AppRouter.build(_repository);

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Pulse',
      debugShowCheckedModeBanner: false,
      theme: AppTheme.light(),
      darkTheme: AppTheme.dark(),
      routerConfig: _router,
    );
  }
}
