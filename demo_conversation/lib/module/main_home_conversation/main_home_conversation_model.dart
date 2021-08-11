part of main_home_conversation;

class _MainHomeConversationModel extends TTChangeNotifier<_MainHomeConversationView> {
  MeInfo get meInfo => userSrv.me;

  GlobalKey<AnimatedListState> listKey;
  ScrollController scrollController;

  final double itemSizeHeight = 100;
  Widget Function(BuildContext, RoomChatInfo, Animation) buildRoomItem;

  _MainHomeConversationModel() {
    listKey = GlobalKey<AnimatedListState>();
    scrollController = ScrollController();
    scrollToTopList();
  }

  void onAddRoomChatClick() {
    String friendIdRandom = 'f' + Random.secure().nextInt(10).toString();
    // friendIdRandom = 'f4';
    print('friendIdRandom: $friendIdRandom');

    if (chatSrv.checkRoomChatAvailable('${meInfo.id}' + friendIdRandom)) {
      enterRoomChat(roomChatInfo: chatSrv.getRoomChatById('${meInfo.id}' + friendIdRandom));
    } else {
      enterRoomChat(friendId: friendIdRandom);
    }
  }

  UserInfo getPartnerById(String id) {
    return userSrv.getFriendById(id);
  }

  ChatMessageInfo getChatMsgById(String id, String roomId) {
    return chatSrv.getChatMessageById(id, roomId);
  }

  void enterRoomChat({RoomChatInfo roomChatInfo, String friendId}) {
    if (roomChatInfo != null && roomChatInfo.isHaveNewMsg) {
      chatSrv.updateHashRoom(
        chatSrv.getNewRoomWithUpdateField(
          room: roomChatInfo,
          isHaveNewMsg: false,
        ),
      );
    }

    Navigator.of(context)
        .push(
      MaterialPageRoute(
        builder: (_) => createMainHomeConversationChat(
          friendId: friendId,
          roomChatInfo: roomChatInfo,
          createRoom: () {
            listKey.currentState.insertItem(0);
          },
          updateListRoomChat: (roomChatInfo) {
            // notifyListeners();
            updateRooms(roomChatInfo);
          },
        ),
      ),
    )
        .then((isNew) {
      if (isNew) {
        if (roomChatInfo != null) {
          chatSrv.hashRooms[roomChatInfo.id].isHaveNewMsg = true;
        } else if (meInfo != null) {
          chatSrv.hashRooms[meInfo.id + friendId].isHaveNewMsg = true;
        }
      }
      notifyListeners();
      scrollToTopList();
    });
  }

  void updateRooms(RoomChatInfo roomChatInfo) {
    final int index = chatSrv.getIndexRoomIdOfList(roomChatInfo);

    chatSrv.updateHashRoom(roomChatInfo);

    chatSrv.removeRoomInList(roomChatInfo, removeHashItem: false);
    listKey.currentState.removeItem(
      index,
      (context, animation) => buildRoomItem(
        context,
        roomChatInfo,
        animation,
      ),
    );

    chatSrv.insertRoomChatToList(0, roomChatInfo, addHashItem: false);
    listKey.currentState.insertItem(0);
  }

  void scrollToTopList() {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.maxScrollExtent);
      }
    });
  }

  String getTimeStr(ChatMessageInfo chatMsgInfo) {
    if (chatMsgInfo.createDate != null) {
      return convertDateTimeToString(convertTimestampToDateTime(chatMsgInfo.createDate));
    }
    return '';
  }

  void goBack() {
    Navigator.of(context).pop();
  }
}
