Future<String> getUserInfo(Future<String?> Function()? onUserInfo) async {
  final userInfo = await onUserInfo?.call();
  return '''
    userInfo: ${userInfo ?? 'Not Logged'}<br>
    ''';
}
