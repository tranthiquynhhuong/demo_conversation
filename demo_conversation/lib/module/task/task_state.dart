part of task;

class _TaskViewState extends TTState<_TaskModel, _TaskView> {
  @override
  Widget buildWithModel(BuildContext context, _TaskModel model) {
    print("---> ${device.padding.top}");
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(42),
        child: AppBar(
          backgroundColor: Cl.white,
          elevation: 0.0,
          title: Row(
            children: [
              IconButton(
                onPressed: () {},
                icon: Icon(Icons.arrow_back),
                color: Cl.slate,
              ),
              SizedBox(
                width: 14,
              ),
              TText(
                'Profile',
                style: St.poppins_medium.copyWith(
                  fontSize: 15,
                  color: Cl.slate,
                ),
              ),
            ],
          ),
        ),
      ),
      backgroundColor: Cl.white,
      body: SafeArea(
        child: Scrollbar(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(bottom: 23.0, top: 12),
            child: Column(
              children: [
                SizedBox(width: 23),
                buildTaskContent(
                  title: 'Task number one',
                  content:
                      'The first task is for you to read the code below and identify the errors in the code and re-write the code in the code snippet box given below.',
                  progressPercent: 40.0,
                ),
                Image.network(
                  'https://picsum.photos/490/200',
                  fit: BoxFit.cover,
                ),
                buildTaskContent(
                  content:
                      'In this example, JavaScript is used to apply behavior to an HTML element with id login. The behavior allows a user to click a LOGIN button that toggles a login form.',
                ),
                Image.network(
                  'https://picsum.photos/500/300',
                  fit: BoxFit.cover,
                ),
                buildTaskContent(
                  content:
                      'In this example, JavaScript is used to apply behavior to an HTML element with id login. The behavior allows a user to click a LOGIN button that toggles a login form.',
                ),
                Image.network(
                  'https://picsum.photos/520/300',
                  fit: BoxFit.cover,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildProgressBar({double progressPercent = 0.0}) {
    return Padding(
      padding: const EdgeInsets.only(top: 17, bottom: 20),
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          double progressBarMaxWidth = constraints.biggest.width;
          double percentBarWidth = model.getWidthOfPercentBar(
            maxWidth: progressBarMaxWidth,
            percent: progressPercent,
          );
          return Stack(
            children: [
              Container(
                height: 9,
                decoration: BoxDecoration(
                  color: Cl.white,
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                ),
              ),
              Container(
                width: percentBarWidth,
                height: 9,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(5)),
                  gradient: LinearGradient(
                    begin: Alignment.centerLeft,
                    end: Alignment.centerRight,
                    colors: [
                      Cl.warmPink,
                      Cl.apricot,
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }

  Widget buildTaskContent({String title, String content, double progressPercent}) {
    return Container(
      width: double.infinity,
      color: Cl.bgtask,
      child: Padding(
        padding: const EdgeInsets.all(18.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            title != null
                ? Padding(
                    padding: const EdgeInsets.only(bottom: 5.0),
                    child: TText(
                      title,
                      style: St.poppins_semi_bold.copyWith(color: Cl.slate),
                    ),
                  )
                : Container(),
            content != null
                ? TText(
                    '$content',
                    style: St.poppins_regular_grey,
                  )
                : Container(),
            progressPercent != null
                ? buildProgressBar(progressPercent: progressPercent)
                : Padding(
                    padding: const EdgeInsets.only(bottom: 11.0),
                    child: Container(),
                  ),
          ],
        ),
      ),
    );
  }
}
