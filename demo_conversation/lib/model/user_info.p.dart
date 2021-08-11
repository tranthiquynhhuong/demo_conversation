import 'package:flutter/material.dart';

class UserInfo extends ChangeNotifier {
  final String id;
  final String username;
  final String avatar;
  final int createDate;

  UserInfo({
    this.id,
    this.username,
    this.avatar,
    this.createDate,
  });

  factory UserInfo.test(int index) {
    return UserInfo(
      id: 'f' + index.toString(),
      username: 'Friend ' + index.toString(),
      avatar: 'https://picsum.photos/400/400',
      createDate: 1621527240,
    );
  }

  UserInfo.fromMap(Map<String, UserInfo> map)
      : id = map['${map.keys.first}'].id,
        username = map['${map.keys.first}'].username,
        createDate = map['${map.keys.first}'].createDate,
        avatar = map['${map.keys.first}'].avatar;

  Map<String, UserInfo> toMap(UserInfo userInfo) => {
        'id': userInfo,
      };
}
