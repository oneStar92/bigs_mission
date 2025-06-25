import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'login_text_field_type.dart';

class LoginTextField extends StatelessWidget {
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final LoginTextFieldType _type;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      focusNode: _focusNode,
      controller: _textEditingController,
      keyboardType: _type.textInputType,
      decoration: InputDecoration(
        hintText: _type.hintText,
        hintStyle: xSmallTextStyle,
        errorText: null,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CupertinoColors.systemGrey, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: CupertinoColors.black, width: 1),
          borderRadius: BorderRadius.circular(4),
        ),
        contentPadding: const EdgeInsets.symmetric(horizontal: 8),
        prefixIcon: _type.icon,
        suffixIcon: GestureDetector(
          onTap: () {
            _textEditingController.clear();
          },
          child: ValueListenableBuilder(
            valueListenable: _textEditingController,
            builder:
                (context, value, child) =>
                    value.text.isNotEmpty ? Icon(CupertinoIcons.xmark_circle_fill, size: 18) : SizedBox.shrink(),
          ),
        ),
        prefixIconConstraints: const BoxConstraints(maxWidth: 28, minWidth: 28),
        suffixIconConstraints: const BoxConstraints(maxWidth: 28, minWidth: 28),
      ),
      validator: null,
      obscureText: _type.obscureText,
      style: xSmallTextStyle,
      cursorColor: Colors.black,
      cursorErrorColor: Colors.black,
      cursorHeight: 16,
      cursorWidth: 1,
      maxLines: 1,
      onTapOutside: (_) {
        if (_focusNode.hasFocus) {
          _focusNode.unfocus();
        }
      },
    );
  }

  const LoginTextField({
    super.key,
    required FocusNode focusNode,
    required TextEditingController textEditingController,
    required LoginTextFieldType type,
  }) : _focusNode = focusNode,
       _textEditingController = textEditingController,
       _type = type;
}
