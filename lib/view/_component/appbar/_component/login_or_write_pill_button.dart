import 'package:flutter/material.dart';

class LoginOrWritePillButton extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: SizedBox(
        width: 100, // 버튼의 너비
        height: 35,  // 버튼의 높이
        child: ElevatedButton(
          onPressed: () {
            // 로그인 로직
          },
          style: ElevatedButton.styleFrom(
            backgroundColor: Colors.black,
            // primary: Colors.blue, // 버튼 색상
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30), // 둥근 모서리
            ),
          ),
          child: Padding(
            padding: const EdgeInsets.only(bottom: 3),
            child: Text(
              '로그인',
              style: TextStyle(
                color: Colors.white, // 텍스트 색상
                fontSize: 17,
              ),
            ),
          ),
        ),
      ),
    );
  }
}