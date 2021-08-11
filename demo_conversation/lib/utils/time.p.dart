part of utils;

String convertDateTimeToString(DateTime dateTime) {
  return DateFormat('kk:mm').format(dateTime);
}

DateTime convertTimestampToDateTime(int timestamp) {
  return DateTime.fromMillisecondsSinceEpoch(timestamp);
}

int getTimestampUTCNow() {
  return DateTime.now().toUtc().millisecondsSinceEpoch;
}
