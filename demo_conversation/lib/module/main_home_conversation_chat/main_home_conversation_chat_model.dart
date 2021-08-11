part of main_home_conversation_chat;

class _MainHomeConversationChatModel extends TTChangeNotifier<_MainHomeConversationChatView> {
  static const int LIMIT_LIST_CHAT = 20;

  GlobalKey<AnimatedListState> listKey;
  ScrollController scrollController;
  TextEditingController msgTextController;
  FocusNode focusNode;

  bool enableSend = false;
  bool isScrollBottom = false;
  bool isHaveNewMsg = false;
  bool isDestroy = false;
  bool isInit = false;
  bool isNewRoom;

  double maxWidthOfItem = 0.0;
  int counter = 0;

  RoomChatInfo roomChatInfo;
  final Function(RoomChatInfo roomChatInfo) updateListRoomChat;
  final Function createRoom;
  Widget Function(BuildContext, ChatMessageInfo, Animation) buildChatItem;

  List<ChatMessageInfo> newChats = [];
  List<ChatMessageInfo> chatsHistory = [];
  List<ChatMessageInfo> fullList = [];
  List<ChatMessageInfo> newChatsBackup = [];

  MeInfo meInfo;

  final String friendId;
  UserInfo friendInfo;

  _MainHomeConversationChatModel(
      {this.roomChatInfo, this.friendId, this.updateListRoomChat, this.createRoom}) {
    focusNode = FocusNode();
    msgTextController = TextEditingController();
    listKey = GlobalKey<AnimatedListState>();
    scrollController = ScrollController();

    initData();
  }

  void dispose() {
    isDestroy = true;
    scrollController?.dispose();
    msgTextController?.dispose();
    focusNode?.dispose();
    super.dispose();
  }

  void initData() {
    newChats.clear();
    chatsHistory.clear();
    fullList.clear();

    isNewRoom = friendId != null;
    meInfo = userSrv.me;
    friendInfo = userSrv.getFriendById(friendId ?? roomChatInfo.partnerId);

    fullList = roomChatInfo != null ? chatSrv.getListMsgByRoomId(roomChatInfo.id) : [];
    newChats = [];
    chatsHistory = roomChatInfo != null ? getListChat(firstLoad: true, limit: LIMIT_LIST_CHAT) : [];
    newChatsBackup = [];

    if (!isDestroy) {
      notifyListeners();
    }
  }

  List<ChatMessageInfo> getListChat({bool firstLoad = false, @required int limit}) {
    int offset = chatsHistory.isNotEmpty
        ? chatSrv.getIndexOfChatInList(chatsHistory.last) + 1
        : firstLoad
            ? 0
            : -1;

    if (offset != -1 && fullList != null && fullList.isNotEmpty && offset != fullList.length) {
      if (offset + limit > fullList.length - 1) {
        return fullList.sublist(offset);
      } else {
        return fullList.sublist(offset, offset + limit);
      }
    } else {
      return null;
    }
  }

  bool checkIsMe(String id) {
    return id == meInfo.id;
  }

  void scrollListener() {
    if (scrollController.offset == scrollController.position.maxScrollExtent) {
      loadMoreChat();
    } else if (scrollController.offset > scrollController.position.minScrollExtent + 300 &&
        !scrollController.position.outOfRange) {
      isScrollBottom = true;
    } else if (scrollController.offset == scrollController.position.minScrollExtent) {
      updateNewChats();
      isHaveNewMsg = false;
      isScrollBottom = false;
    } else {
      isHaveNewMsg = false;
      isScrollBottom = false;
    }
    notifyListeners();
  }

  void updateNewChats() {
    print('newChatsBackup length: ${newChatsBackup.length}');
    if (newChatsBackup.length > 0) {
      for (int i = 0; i < newChatsBackup.length; i++) {
        newChats.insert(0, newChatsBackup[i]);

        if (i == newChatsBackup.length - 1) {
          newChatsBackup.clear();
          newChatsBackup = [];
        }
      }
      notifyListeners();
    }
  }

  void loadMoreChat() {
    List<ChatMessageInfo> lstReturn = getListChat(limit: LIMIT_LIST_CHAT);
    if (lstReturn != null) {
      for (var c in lstReturn) {
        chatsHistory.add(c);

        listKey.currentState.insertItem(
          chatsHistory.length + newChats.length - 1,
          duration: const Duration(milliseconds: 100),
        );
      }
      print('myListChat.length: ${chatsHistory.length + newChats.length}/${fullList.length}');
    }
  }

  ChatMessageInfo getItemChatByIndex(int index) {
    if (index < newChats.length) {
      return newChats[index];
    }

    if (index < newChats.length + chatsHistory.length) {
      return chatsHistory[index - newChats.length];
    }

    return null;
  }

  void addMsg({bool isMe = true}) {
    String message = msgTextController.text;
    if (enableSend) {
      if (isNewRoom) {
        roomChatInfo = chatSrv.createRoomChatInfo(myId: meInfo.id, partnerId: friendId);
        createRoom();
        isNewRoom = false;
      }

      insertMsgToList(isMe: true, msg: message);
      cleanTextFiled();
      onTextFieldChange(msgTextController.text);

      Future.delayed(Duration(seconds: Random.secure().nextInt(5))).then((value) {
        if (!isDestroy) {
          insertMsgToList(isMe: false, msg: message);
        }
      });
    }
  }

  void insertMsgToList({bool isMe, String msg}) {
    if (isMe) {
      scrollController.jumpTo(scrollController.position.minScrollExtent);
    } else {
      checkNewMsg();
      notifyListeners();
    }

    ChatMessageInfo newChat = ChatMessageInfo.test(
      msg: msg,
      receiveId: isMe ? roomChatInfo.partnerId : meInfo.id,
      senderId: isMe ? meInfo.id : roomChatInfo.partnerId,
      roomId: roomChatInfo.id,
    );
    chatSrv.addChatMsgToList(newChat);

    RoomChatInfo newRoom = chatSrv.getNewRoomWithUpdateField(
      room: this.roomChatInfo,
      createDate: getTimestampUTCNow(),
      lastMsgId: newChat.id,
    );
    updateListRoomChat(newRoom);

    if (scrollController.offset == scrollController.position.minScrollExtent) {
      newChats.insert(0, newChat);
      listKey.currentState.insertItem(0);
    } else {
      newChatsBackup.add(newChat);
    }

    notifyListeners();
  }

  void clearHistory() {
    if (chatsHistory.length > 20) {
      final item = chatsHistory.removeLast();
      listKey.currentState.removeItem(
        chatsHistory.length - 1,
        (context, animation) => buildChatItem(
          context,
          item,
          animation,
        ),
      );
    }
  }

  void checkNewMsg() {
    if (scrollController.hasClients &&
        scrollController.offset == scrollController.position.minScrollExtent &&
        !scrollController.position.outOfRange) {
      isHaveNewMsg = false;
    } else {
      isHaveNewMsg = true;
    }
  }

  void scrollToBottom() {
    if (isHaveNewMsg) {
      isHaveNewMsg = false;
      notifyListeners();
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (scrollController.hasClients) {
        scrollController.jumpTo(scrollController.position.minScrollExtent);
        clearHistory();
      }
    });
  }

  void cleanTextFiled() {
    msgTextController.clear();
  }

  void onTextFieldChange(String value) {
    enableSend = value != null && value.length > 0;
    notifyListeners();
  }

  void calculateMaxWidthOfItem({@required double maxWidth}) {
    maxWidthOfItem = maxWidth - maxWidth / 3;
  }

  void goBack() {
    Navigator.of(context).pop(isHaveNewMsg);
  }
}
