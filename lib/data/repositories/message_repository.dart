import 'package:flutter/material.dart';

import '../../domain/models/conversation.dart';

/// Synchronous seed for the direct-messages inbox and the "active now" row.
class MessageRepository {
  List<Conversation> seed() {
    return const <Conversation>[
      Conversation(
        id: 'd1',
        name: 'Lucas Dev',
        lastMessage: 'Bora fechar aquele projeto essa semana?',
        timeAgo: '2min',
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
        unread: 2,
        online: true,
      ),
      Conversation(
        id: 'd2',
        name: 'Marina Art',
        lastMessage: 'Amei a referência que você mandou!',
        timeAgo: '18min',
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
        unread: 1,
        online: true,
      ),
      Conversation(
        id: 'd3',
        name: 'Pedro Foto',
        lastMessage: 'Você: fechado, te aviso o horário',
        timeAgo: '1h',
        gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
        fromMe: true,
      ),
      Conversation(
        id: 'd4',
        name: 'Bia Lima',
        lastMessage: 'kkkk perfeito, muito bom',
        timeAgo: '3h',
        gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
      ),
      Conversation(
        id: 'd5',
        name: 'Rafa Trip',
        lastMessage: 'Reagiu à sua mensagem',
        timeAgo: '5h',
        gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
        online: true,
      ),
      Conversation(
        id: 'd6',
        name: 'Julia Mkt',
        lastMessage: 'Você: te mando o briefing amanhã',
        timeAgo: '1d',
        gradient: <Color>[Color(0xFFB24592), Color(0xFFF15F79)],
        fromMe: true,
      ),
      Conversation(
        id: 'd7',
        name: 'Thiago Run',
        lastMessage: 'Vamos correr no parque sábado?',
        timeAgo: '2d',
        gradient: <Color>[Color(0xFF56AB2F), Color(0xFFA8E063)],
      ),
      Conversation(
        id: 'd8',
        name: 'Camila Vlog',
        lastMessage: 'Adorei o vídeo novo!',
        timeAgo: '3d',
        gradient: <Color>[Color(0xFF00C6FB), Color(0xFF005BEA)],
      ),
    ];
  }

  /// Friends currently online, shown in the horizontal "active now" carousel.
  List<ActiveFriend> seedActive() {
    return const <ActiveFriend>[
      ActiveFriend(
        name: 'Sua nota',
        gradient: <Color>[Color(0xFF9E9E9E), Color(0xFF616161)],
        isSelf: true,
      ),
      ActiveFriend(
        name: 'Lucas',
        gradient: <Color>[Color(0xFF7B2FF7), Color(0xFF2F80ED)],
      ),
      ActiveFriend(
        name: 'Marina',
        gradient: <Color>[Color(0xFF11998E), Color(0xFF38EF7D)],
      ),
      ActiveFriend(
        name: 'Rafa',
        gradient: <Color>[Color(0xFFF7971E), Color(0xFFFFD200)],
      ),
      ActiveFriend(
        name: 'Bia',
        gradient: <Color>[Color(0xFF396AFC), Color(0xFF2948FF)],
      ),
      ActiveFriend(
        name: 'Pedro',
        gradient: <Color>[Color(0xFFFF512F), Color(0xFFDD2476)],
      ),
    ];
  }
}
