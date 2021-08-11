import 'package:demo_conversation/model/model.dart';

class MeInfo extends UserInfo {
  MeInfo({
    id,
    username,
    avatar,
    createDate,
  }) : super(
          id: id,
          username: username,
          createDate: createDate,
        );

  factory MeInfo.test(int index) {
    return MeInfo(
      id: 'm' + index.toString(),
      username: 'Huong Tran',
      avatar: 'https://picsum.photos/400/400',
      createDate: 1621527240,
    );
  }
}
