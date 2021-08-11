part of main_home_conversation_chat;

class _MainHomeConversationChatViewState
    extends TTState<_MainHomeConversationChatModel, _MainHomeConversationChatView> {
  @override
  void initState() {
    super.initState();

    model.scrollController.addListener(() {
      model.scrollListener();
    });
  }

  @override
  Widget buildWithModel(BuildContext context, _MainHomeConversationChatModel model) {
    if (!model.isInit) {
      model.calculateMaxWidthOfItem(maxWidth: MediaQuery.of(context).size.width);
      model.isInit = true;
    }

    if (model.buildChatItem == null) {
      model.buildChatItem = this.chatItem;
    }

    return GestureDetector(
      onTap: () => dismissKeyboard(context),
      child: Scaffold(
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
              '${model.friendInfo.username}',
              style: St.poppins_medium.copyWith(
                fontSize: 15,
                color: Cl.slate,
              ),
            ),
          ),
        ),
        body: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: Stack(
                  children: [
                    AnimatedList(
                      reverse: true,
                      controller: model.scrollController,
                      key: model.listKey,
                      initialItemCount: model.newChats.length + model.chatsHistory.length,
                      itemBuilder: (context, index, animation) {
                        return model.getItemChatByIndex(index) != null
                            ? Padding(
                                padding: const EdgeInsets.only(bottom: 10.0),
                                child: chatItem(
                                  context,
                                  model.getItemChatByIndex(index),
                                  animation,
                                ),
                              )
                            : SizedBox(); // Refer step 3
                      },
                    ),
                    model.isScrollBottom
                        ? Positioned(
                            bottom: 16,
                            right: 16,
                            child: IconButton(
                              icon: Icon(
                                Icons.arrow_drop_down_circle_sharp,
                                color: Cl.apricot,
                                size: 45,
                              ),
                              onPressed: model.scrollToBottom,
                            ),
                          )
                        : SizedBox(),
                    model.isHaveNewMsg ? buildNewMsg(model) : SizedBox(),
                  ],
                ),
              ),
              Divider(
                height: 1,
                color: Cl.greyBottomBarDisable,
              ),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      maxLines: 5,
                      minLines: 1,
                      onChanged: model.onTextFieldChange,
                      cursorColor: Cl.apricot,
                      focusNode: model.focusNode,
                      controller: model.msgTextController,
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(horizontal: 16),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Cl.white),
                        ),
                        disabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Cl.white),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Cl.white),
                        ),
                        alignLabelWithHint: false,
                      ),
                      style: St.p_01,
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.send,
                      color: model.enableSend ? Cl.apricot : Cl.greyBottomBarDisable,
                    ),
                    onPressed: model.enableSend ? model.addMsg : null,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Center buildNewMsg(_MainHomeConversationChatModel model) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          SizedBox(height: 16),
          Container(
            clipBehavior: Clip.hardEdge,
            width: 150,
            height: 40,
            decoration: BoxDecoration(
              color: Cl.white,
              borderRadius: BorderRadius.circular(20),
              boxShadow: [
                BoxShadow(
                  color: Cl.greyBoxShadow,
                  spreadRadius: 5,
                  blurRadius: 7,
                  offset: Offset(0, 3), // changes position of shadow
                ),
              ],
            ),
            child: Material(
              borderRadius: BorderRadius.circular(25),
              color: Colors.transparent,
              child: InkWell(
                onTap: model.scrollToBottom,
                child: Center(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      TText(
                        'New messgae ',
                        style: St.poppins_regular_slate,
                      ),
                      Icon(
                        Icons.keyboard_arrow_down_outlined,
                        size: 25,
                        color: Cl.slate,
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget chatItem(BuildContext context, ChatMessageInfo chat, animation) {
    // return model.checkIsMe(chat.senderId) ? buildMyMsg(chat) : buildBotMsg(chat);
    return SizeTransition(
      sizeFactor: animation,
      axis: Axis.vertical,
      child: model.checkIsMe(chat.senderId) ? buildMyMsg(chat) : buildBotMsg(chat),
    );
  }

  Widget buildMyMsg(ChatMessageInfo chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      mainAxisSize: MainAxisSize.max,
      children: [
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          constraints: BoxConstraints(
            maxWidth: model.maxWidthOfItem,
            minWidth: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${chat.message}'),
              SizedBox(height: 5),
              Text(
                '${convertDateTimeToString(convertTimestampToDateTime(chat.createDate))}',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Cl.apricot.withOpacity(0.3),
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
        SizedBox(width: 16),
      ],
    );
  }

  Widget buildBotMsg(ChatMessageInfo chat) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      mainAxisSize: MainAxisSize.min,
      children: [
        SizedBox(width: 16),
        Container(
          padding: EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 5,
          ),
          constraints: BoxConstraints(
            maxWidth: model.maxWidthOfItem,
            minWidth: 50,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('${chat.message}'),
              SizedBox(height: 5),
              Text(
                '${convertDateTimeToString(convertTimestampToDateTime(chat.createDate))}',
                style: TextStyle(
                  color: Colors.grey,
                  fontStyle: FontStyle.italic,
                ),
              ),
            ],
          ),
          decoration: BoxDecoration(
            color: Cl.white,
            border: Border.all(
              color: Colors.grey,
              width: 1,
            ),
            borderRadius: BorderRadius.circular(15),
          ),
        ),
      ],
    );
  }
}
