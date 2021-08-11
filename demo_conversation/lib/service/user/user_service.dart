import 'package:demo_conversation/model/model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';

UserService get userSrv => UserService.shared();

class UserService extends ChangeNotifier {
  static UserService _sInstance;

  final Map<String, UserInfo> friendsMap = {};

  MeInfo _myInfo;
  MeInfo get me => _myInfo;
  List<UserInfo> get listFriend => friendsMap.values.toList();

  UserService._();

  factory UserService.shared() {
    if (_sInstance == null) {
      _sInstance = UserService._();
    }
    return _sInstance;
  }

  Future<bool> login() async {
    _myInfo = MeInfo.test(1);
    initMyFriends();
    return true;
  }

  void initMyFriends() {
    friendsMap.clear();
    List.generate(10, (index) {
      final user = UserInfo.test(index);
      friendsMap[user.id] = user;
    });
  }

  UserInfo getFriendById(String id) {
    return friendsMap[id];
  }
}
