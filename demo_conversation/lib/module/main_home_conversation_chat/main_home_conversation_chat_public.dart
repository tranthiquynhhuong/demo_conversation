library main_home_conversation_chat;

import 'dart:async';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:demo_conversation/model/chat_message_info.p.dart';
import 'package:demo_conversation/model/model.dart';
import 'package:demo_conversation/model/room_chat_info.p.dart';
import 'package:demo_conversation/res/color.p.dart';
import 'package:demo_conversation/res/style.p.dart';
import 'package:demo_conversation/service/chat/chat_service.dart';
import 'package:demo_conversation/service/user/user_service.dart';
import 'package:demo_conversation/utils/utils.dart';
import 'package:provider/provider.dart';
import 'package:demo_conversation/widget/widget.dart';

part 'main_home_conversation_chat_view.dart';
part 'main_home_conversation_chat_model.dart';
part 'main_home_conversation_chat_state.dart';

ChangeNotifierProvider<_MainHomeConversationChatModel> createMainHomeConversationChat({
  @required RoomChatInfo roomChatInfo,
  Function(RoomChatInfo roomChatInfo) updateListRoomChat,
  String friendId,
  Function createRoom,
}) {
  return ChangeNotifierProvider<_MainHomeConversationChatModel>(
    create: (_) => _MainHomeConversationChatModel(
      friendId: friendId,
      roomChatInfo: roomChatInfo,
      createRoom: createRoom,
      updateListRoomChat: (room) {
        updateListRoomChat(room);
      },
    ),
    child: _MainHomeConversationChatView(),
  );
}
