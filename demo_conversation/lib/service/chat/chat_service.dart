import 'package:demo_conversation/model/model.dart';
import 'package:flutter/material.dart';

ChatService get chatSrv => ChatService.shared();

class ChatService extends ChangeNotifier {
  static ChatService _sInstance;

  final Map<String, List<ChatMessageInfo>> hashChatMsgs = {};
  final Map<String, RoomChatInfo> hashRooms = {};
  final List<String> roomIds = [];

  ChatService._();

  factory ChatService.shared() {
    if (_sInstance == null) {
      _sInstance = ChatService._();
    }
    return _sInstance;
  }

  // CHAT MSG
  void addChatMsgToList(ChatMessageInfo chat) {
    final List<ChatMessageInfo> lstChat = hashChatMsgs[chat.roomId] ?? [];
    lstChat.insert(0, chat);
    hashChatMsgs[chat.roomId] = lstChat;
    notifyListeners();
  }

  ChatMessageInfo getChatMessageById(
    String id,
    String roomId,
  ) {
    return getListMsgByRoomId(roomId).firstWhere((msg) => msg.id == id, orElse: () => null);
  }

  List<ChatMessageInfo> getListMsgByRoomId(String roomId) {
    return hashChatMsgs[roomId];
  }

  int getIndexOfChatInList(ChatMessageInfo chat) {
    assert(chat != null);
    if (hashChatMsgs[chat.roomId] == null) {
      return -1;
    }
    return hashChatMsgs[chat.roomId].indexOf(chat);
  }

  // ROOM CHAT
  List<RoomChatInfo> getListRoomChat() {
    return roomIds.map((id) => getRoomChatById(id)).toList();
  }

  RoomChatInfo getRoomChatById(String id) {
    return hashRooms[id];
  }

  bool checkRoomChatAvailable(String id) {
    return hashRooms[id] != null;
  }

  RoomChatInfo createRoomChatInfo({
    @required String myId,
    @required String partnerId,
  }) {
    RoomChatInfo room = RoomChatInfo.test(myId, partnerId);
    roomIds.insert(0, room.id);
    hashRooms[room.id] = room;

    notifyListeners();
    return room;
  }

  RoomChatInfo getNewRoomWithUpdateField({
    @required RoomChatInfo room,
    String id,
    String lastMsgId,
    int createDate,
    String partnerId,
    bool isHaveNewMsg,
  }) =>
      RoomChatInfo(
        id: id ?? room.id,
        lastMsgId: lastMsgId ?? room.lastMsgId,
        createDate: createDate ?? room.createDate,
        partnerId: partnerId ?? room.partnerId,
        isHaveNewMsg: isHaveNewMsg ?? room.isHaveNewMsg,
      );

  void updateHashRoom(RoomChatInfo room) {
    hashRooms.update(room.id, (value) => room);
    notifyListeners();
  }

  void removeRoomInList(RoomChatInfo roomChatInfo, {bool removeHashItem = true}) {
    final int index = getIndexRoomIdOfList(roomChatInfo);
    roomIds.removeAt(index);
    notifyListeners();
  }

  void insertRoomChatToList(int index, RoomChatInfo roomChatInfo, {bool addHashItem = true}) {
    if (addHashItem) {
      hashRooms[roomChatInfo.id] = roomChatInfo;
    }

    roomIds.insert(index, roomChatInfo.id);
    notifyListeners();
  }

  int getIndexRoomIdOfList(RoomChatInfo roomChatInfo) {
    return roomIds.indexWhere((id) => id == roomChatInfo.id);
  }
}
