import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/material.dart';

class LoginButton extends StatelessWidget {
  final Function() onTap;

  const LoginButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: Container(
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
        child: Center(child: Text('로그인', style: smallTextStyle.copyWith(color: Colors.white))),
      ),
    );
  }
}
