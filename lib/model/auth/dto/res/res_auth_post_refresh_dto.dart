import 'dart:convert';

class ResAuthPostRefreshDTO {
  final String accessJwt;
  final String refreshJwt;

  ResAuthPostRefreshDTO._({required this.accessJwt, required this.refreshJwt});

  factory ResAuthPostRefreshDTO.fromMap(Map<String, dynamic> jsonMap) {
    return ResAuthPostRefreshDTO._(
      accessJwt: jsonMap['accessJwt'],
      refreshJwt: jsonMap['refreshJwt'],
    );
  }

  factory ResAuthPostRefreshDTO.fromJson(String json) {
    return ResAuthPostRefreshDTO.fromMap(jsonDecode(json));
  }
}
