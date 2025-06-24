import 'package:flutter/cupertino.dart';

class CustomBackButton extends StatelessWidget {
  final Function() onTap;

  const CustomBackButton({super.key, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap.call();
      },
      child: SizedBox(height: 24, width: 24, child: FittedBox(child: Icon(CupertinoIcons.back))),
    );
  }
}
