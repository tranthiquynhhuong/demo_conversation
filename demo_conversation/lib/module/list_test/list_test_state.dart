part of list_test;

class _ListTestViewState extends TTState<_ListTestModel, _ListTestView> {
  List<String> list;
  List<String> lstTmp;
  ScrollController scrollController;
  GlobalKey key;

  @override
  void initState() {
    super.initState();
    list = List.generate(50, (index) => '$index --- ${DateTime.now().toString()}');
    lstTmp = [];
    scrollController = ScrollController();

    scrollController.addListener(() {
      if (scrollController.offset < scrollController.position.minScrollExtent + 200) {
        print('min');
        updateList();
      } else {
        print('normal');
      }
    });
  }

  void addEnd() {
    list.add('${list.length} --- ${DateTime.now().toString()}');
    setState(() {});
  }

  void addFirst() {
    list.insert(0, 'first --- ${DateTime.now().toString()}');
    setState(() {});
  }

  void updateList() {
    print('lstTmp.length: ${lstTmp.length}');
    if (lstTmp.length > 0) {
      for (int i = 0; i < lstTmp.length; i++) {
        list.insert(0, '-$i${lstTmp[i]}');
        if (i == lstTmp.length - 1) {
          lstTmp = [];
        }
      }
    }
    setState(() {});
  }

  @override
  Widget buildWithModel(BuildContext context, _ListTestModel model) {
    return Scaffold(
      appBar: AppBar(
        title: Text('${list.length ?? ''}'),
        actions: [
          IconButton(
              icon: Icon(Icons.add_box),
              onPressed: () {
                if (scrollController.offset < scrollController.position.minScrollExtent + 200) {
                  addFirst();
                } else {
                  lstTmp.add(' --- ${DateTime.now().toString()}');
                }
              }),
          IconButton(
              icon: Icon(Icons.add_box_outlined),
              onPressed: () {
                addEnd();
              }),
        ],
      ),
      body: SafeArea(
        child: ListView.builder(
          key: key,
          controller: scrollController,
          itemCount: list.length,
          itemBuilder: (context, index) {
            return Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Container(
                padding: EdgeInsets.all(8),
                height: 50,
                color: Colors.grey.shade300,
                child: Center(
                  child: Row(
                    children: [
                      Text('${list[index]}'),
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
