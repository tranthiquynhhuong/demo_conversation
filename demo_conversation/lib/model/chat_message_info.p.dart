import 'package:flutter/material.dart';
import 'package:demo_conversation/utils/utils.dart';

class ChatMessageInfo extends ChangeNotifier {
  final String id;

  /// non-null
  final String roomId;
  final String senderId;
  final String receiveId;
  final int createDate;
  final String message;

  ChatMessageInfo({
    this.id,
    this.createDate,
    this.message,
    this.receiveId,
    @required this.roomId,
    this.senderId,
  }) : assert(roomId != null);

  factory ChatMessageInfo.test({String receiveId, String senderId, String msg, String roomId}) {
    return ChatMessageInfo(
      id: 'c' + '${getTimestampUTCNow().toString()}',
      createDate: getTimestampUTCNow(),
      receiveId: receiveId,
      senderId: senderId,
      message: msg,
      roomId: roomId,
    );
  }
}
