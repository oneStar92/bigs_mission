import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/cupertino.dart';

extension CupertinoAlertExtension on BuildContext {
  void showCupertinoAlert({
    required String message,
    String title = '알림',
    String buttonText = '확인',
    VoidCallback? onPressed,
  }) {
    showCupertinoDialog(
      context: this,
      barrierDismissible: true,
      builder: (_) => CupertinoAlertDialog(
        title: Text(title, style: mediumTextStyle,),
        content: Text(message, style: smallTextStyle,),
        actions: [
          CupertinoDialogAction(
            child: Text(buttonText, style: xSmallTextStyle.copyWith(color: CupertinoColors.black),),
            onPressed: () {
              Navigator.of(this, rootNavigator: true).pop();
              onPressed?.call();
            },
          ),
        ],
      ),
    );
  }
}