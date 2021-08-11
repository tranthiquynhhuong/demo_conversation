import 'package:flutter/material.dart';
import 'package:demo_conversation/utils/utils.dart';

class RoomChatInfo extends ChangeNotifier {
  final String id;
  final String lastMsgId;
  final int createDate;
  final String partnerId;
  bool isHaveNewMsg;

  RoomChatInfo({
    this.id,
    this.lastMsgId,
    this.createDate,
    this.partnerId,
    this.isHaveNewMsg = false,
  });

  factory RoomChatInfo.test(String myId, String partnerId) {
    return RoomChatInfo(
      createDate: getTimestampUTCNow(),
      id: myId + partnerId,
      partnerId: partnerId,
      isHaveNewMsg: false,
    );
  }
}
