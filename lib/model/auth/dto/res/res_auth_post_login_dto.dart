//
// import 'dart:convert';
//
// class ResAuthPostLoginDTO<T> {
//   final int code;
//   final String message;
//   final ResData data;
//
//   class ResData {
//     final String token;
//     final String refreshToken;
//
//     ResData({
//       required this.token,
//       required this.refreshToken,
//     });
//
//     factory ResData.fromMap(Map<String, dynamic> json) {
//       return ResData(
//         token: json['token'],
//         refreshToken: json['refreshToken'],
//       );
//     }
//
//     factory ResData.fromJson(String source) => ResData.fromMap(json.decode(source));
//
//   }
//
// }