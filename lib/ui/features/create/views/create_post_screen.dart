import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../../core/widgets/app_widgets.dart';
import '../../../core/widgets/social_bottom_nav.dart';
import '../view_models/create_post_view_model.dart';

/// Composer for a new post: gradient preview, gradient picker, caption field
/// and toggles (location, comments, likes) with a publish button.
class CreatePostScreen extends StatefulWidget {
  const CreatePostScreen({super.key});

  @override
  State<CreatePostScreen> createState() => _CreatePostScreenState();
}

class _CreatePostScreenState extends State<CreatePostScreen> {
  late final TextEditingController _controller;

  @override
  void initState() {
    super.initState();
    final vm = context.read<CreatePostViewModel>();
    _controller = TextEditingController(text: vm.caption);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        leading: IconButton(onPressed: () {}, icon: const Icon(Icons.close)),
        title: const Text('Nova publicação'),
        actions: [
          TextButton(
            onPressed: () {},
            child: const Text('Avançar'),
          ),
        ],
      ),
      bottomNavigationBar: const SocialBottomNav(currentIndex: 2),
      body: Consumer<CreatePostViewModel>(
        builder: (context, vm, _) {
          return LayoutBuilder(
            builder: (context, constraints) {
              final maxWidth =
                  constraints.maxWidth >= 700 ? 560.0 : double.infinity;
              return Center(
                child: ConstrainedBox(
                  constraints: BoxConstraints(maxWidth: maxWidth),
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
                    children: [
                      _Preview(gradient: vm.gradient),
                      const SizedBox(height: 12),
                      _GradientPicker(vm: vm),
                      const SizedBox(height: 16),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          GradientAvatar(
                            gradient: vm.gradient,
                            icon: Icons.person,
                            size: 40,
                          ),
                          const SizedBox(width: 12),
                          Expanded(
                            child: TextField(
                              controller: _controller,
                              onChanged: vm.setCaption,
                              minLines: 2,
                              maxLines: 4,
                              decoration: const InputDecoration(
                                hintText: 'Escreva uma legenda...',
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 8),
                      const _NavRow(
                        icon: Icons.person_outline,
                        label: 'Marcar pessoas',
                      ),
                      const Divider(height: 1),
                      const _NavRow(
                        icon: Icons.music_note_outlined,
                        label: 'Adicionar música',
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(Icons.location_on_outlined),
                        title: const Text('Adicionar localização'),
                        subtitle: vm.locationOn
                            ? Text(
                                'Praia de Copacabana, Rio de Janeiro',
                                style: theme.textTheme.bodySmall?.copyWith(
                                  color: theme.colorScheme.onSurfaceVariant,
                                ),
                              )
                            : null,
                        value: vm.locationOn,
                        onChanged: vm.setLocation,
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(Icons.mode_comment_outlined),
                        title: const Text('Desativar comentários'),
                        value: vm.disableComments,
                        onChanged: vm.setDisableComments,
                      ),
                      const Divider(height: 1),
                      SwitchListTile(
                        contentPadding: EdgeInsets.zero,
                        secondary: const Icon(Icons.favorite_border),
                        title: const Text('Ocultar contagem de curtidas'),
                        value: vm.hideLikes,
                        onChanged: vm.setHideLikes,
                      ),
                      const SizedBox(height: 16),
                      FilledButton(
                        onPressed: vm.canPublish ? () {} : null,
                        child: const Text('Compartilhar'),
                      ),
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

class _Preview extends StatelessWidget {
  const _Preview({required this.gradient});

  final List<Color> gradient;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return AspectRatio(
      aspectRatio: 1.4,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          gradient: LinearGradient(
            colors: gradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        clipBehavior: Clip.antiAlias,
        child: Stack(
          children: [
            Center(
              child: Icon(
                Icons.image_outlined,
                size: 72,
                color: Colors.white.withValues(alpha: 0.4),
              ),
            ),
            Positioned(
              right: 12,
              bottom: 12,
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                decoration: BoxDecoration(
                  color: Colors.black.withValues(alpha: 0.35),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const Icon(Icons.tune, size: 16, color: Colors.white),
                    const SizedBox(width: 6),
                    Text(
                      'Editar',
                      style: theme.textTheme.labelLarge?.copyWith(
                        color: Colors.white,
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

class _GradientPicker extends StatelessWidget {
  const _GradientPicker({required this.vm});

  final CreatePostViewModel vm;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return SizedBox(
      height: 64,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: CreatePostViewModel.gradients.length,
        separatorBuilder: (_, _) => const SizedBox(width: 10),
        itemBuilder: (context, index) {
          final selected = index == vm.selectedGradient;
          return GestureDetector(
            onTap: () => vm.selectGradient(index),
            child: Container(
              width: 56,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(14),
                gradient: LinearGradient(
                  colors: CreatePostViewModel.gradients[index],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                border: Border.all(
                  color: selected ? scheme.primary : Colors.transparent,
                  width: 2.5,
                ),
              ),
              child: selected
                  ? const Icon(Icons.check, color: Colors.white, size: 22)
                  : null,
            ),
          );
        },
      ),
    );
  }
}

class _NavRow extends StatelessWidget {
  const _NavRow({required this.icon, required this.label});

  final IconData icon;
  final String label;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon),
      title: Text(label),
      trailing: Icon(Icons.chevron_right, color: scheme.onSurfaceVariant),
      onTap: () {},
    );
  }
}
