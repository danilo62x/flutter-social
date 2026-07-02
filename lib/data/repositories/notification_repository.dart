import 'package:flutter/material.dart';

import '../../domain/models/notification_item.dart';

/// Synchronous seed of activity notifications, pre-bucketed into sections.
class NotificationRepository {
  List<NotificationItem> seed() {
    return const <NotificationItem>[
      NotificationItem(
        id: 'n1',
        username: 'lucas.dev',
        kind: NotificationKind.like,
        timeAgo: '2h',
        section: 'Hoje',
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        postGradient: <Color>[Color(0xFFE1306C), Color(0xFFF77737)],
        postIcon: Icons.wb_twilight,
      ),
      NotificationItem(
        id: 'n2',
        username: 'marina.art',
        kind: NotificationKind.comment,
        timeAgo: '4h',
        section: 'Hoje',
        text: 'A paleta de cores ficou perfeita!',
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
        postGradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
        postIcon: Icons.palette_outlined,
      ),
      NotificationItem(
        id: 'n3',
        username: 'pedro.foto',
        kind: NotificationKind.follow,
        timeAgo: '6h',
        section: 'Hoje',
        gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
        isFollowing: false,
      ),
      NotificationItem(
        id: 'n4',
        username: 'bia.lima',
        kind: NotificationKind.mention,
        timeAgo: '9h',
        section: 'Hoje',
        text: 'mencionou você em um comentário.',
        gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
        postGradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        postIcon: Icons.desktop_windows_outlined,
      ),
      NotificationItem(
        id: 'n5',
        username: 'rafa.trip',
        kind: NotificationKind.follow,
        timeAgo: '1d',
        section: 'Esta semana',
        gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
        isFollowing: true,
      ),
      NotificationItem(
        id: 'n6',
        username: 'julia.mkt',
        kind: NotificationKind.like,
        timeAgo: '2d',
        section: 'Esta semana',
        gradient: <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
        postGradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
        postIcon: Icons.desktop_windows_outlined,
      ),
      NotificationItem(
        id: 'n7',
        username: 'thiago.run',
        kind: NotificationKind.tag,
        timeAgo: '3d',
        section: 'Esta semana',
        text: 'marcou você em uma foto.',
        gradient: <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
        postGradient: <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
        postIcon: Icons.park_outlined,
      ),
      NotificationItem(
        id: 'n8',
        username: 'camila.vlog',
        kind: NotificationKind.comment,
        timeAgo: '4d',
        section: 'Esta semana',
        text: 'Que viagem dos sonhos!',
        gradient: <Color>[Color(0xFF00C6FB), Color(0xFF005BEA)],
        postGradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
        postIcon: Icons.landscape_outlined,
      ),
    ];
  }
}
