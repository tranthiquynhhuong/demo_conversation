part of main_home_conversation;

class _MainHomeConversationViewState extends TTState<_MainHomeConversationModel, _MainHomeConversationView> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget buildWithModel(BuildContext context, _MainHomeConversationModel model) {
    if (model.buildRoomItem == null) {
      model.buildRoomItem = this.buildRoomItem;
    }

    return Scaffold(
      backgroundColor: Cl.white,
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42.0),
        child: AppBar(
          backgroundColor: Cl.white,
          elevation: 0.0,
          leading: IconButton(
            onPressed: model.goBack,
            icon: Icon(Icons.arrow_back),
            color: Cl.slate,
          ),
          title: TText(
            'Conversation',
            style: St.poppins_medium.copyWith(
              fontSize: 15,
              color: Cl.slate,
            ),
          ),
          actions: [
            IconButton(
              onPressed: model.onAddRoomChatClick,
              icon: Icon(Icons.add_comment_sharp),
              color: Cl.slate,
            ),
          ],
        ),
      ),
      body: SafeArea(
        child: AnimatedList(
          controller: model.scrollController,
          key: model.listKey,
          initialItemCount: chatSrv.roomIds.length,
          itemBuilder: (context, index, animation) {
            final List<RoomChatInfo> rooms = chatSrv.getListRoomChat();
            final info = rooms[index];

            return Column(
              children: [
                Consum<RoomChatInfo>(
                    value: info,
                    builder: (context, info) {
                      return buildRoomItem(
                        context,
                        info,
                        animation,
                      );
                    }),
                Padding(
                  padding: const EdgeInsets.only(left: 92),
                  child: Divider(
                    height: 1,
                    color: Colors.grey,
                  ),
                ),
              ],
            ); // Refer step 3
          },
        ),
      ),
    );
  }

  Widget buildRoomItem(BuildContext context, RoomChatInfo roomChatInfo, animation) {
    return SlideTransition(
      position: Tween<Offset>(
        begin: const Offset(-1, 0),
        end: Offset(0, 0),
      ).animate(
        CurvedAnimation(
          parent: animation,
          curve: Curves.easeOut,
          reverseCurve: Curves.bounceOut,
        ),
      ),
      child: InkWell(
        onTap: () => model.enterRoomChat(roomChatInfo: roomChatInfo),
        child: SizedBox(
          height: model.itemSizeHeight,
          child: Container(
            child: Center(
              child: ListTile(
                enabled: false,
                leading: Container(
                  width: 60,
                  height: 60,
                  child: CircleAvatar(
                    radius: 40,
                    child: ClipOval(
                      child: Image.network(
                        '${model.getPartnerById(roomChatInfo.partnerId).avatar}',
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
                title: TText(
                  '${model.getPartnerById(roomChatInfo.partnerId).username}',
                  style: St.poppin_medium_page_title,
                ),
                subtitle: TText(
                  '${model.getChatMsgById(roomChatInfo.lastMsgId, roomChatInfo.id).message ?? 'Don\'t have any message yet'}',
                  style: St.poppins_regular_slate.copyWith(fontSize: 13, color: Colors.grey),
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
                trailing: Container(
                  height: double.infinity,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.end,
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      TText(
                        '${model.getTimeStr(model.getChatMsgById(roomChatInfo.lastMsgId, roomChatInfo.id)) ?? ''}',
                        style: St.poppins_regular_slate.copyWith(
                          fontSize: 13,
                          color: Cl.brownGrey,
                        ),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                      ),
                      roomChatInfo.isHaveNewMsg ? buildNewConversationIcon() : SizedBox(),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget buildNewConversationIcon() {
    return Container(
      width: 35,
      height: 25,
      decoration: BoxDecoration(
        color: Colors.redAccent,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Center(
        child: TText(
          'N',
          style: St.poppins_regular_slate.copyWith(
            fontSize: 13,
            color: Colors.white,
          ),
        ),
      ),
    );
  }
}
