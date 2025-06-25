import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

part 'signup_text_field_type.dart';

class SignupTextField extends StatelessWidget {
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final SignupTextFieldType _type;
  final bool _isError;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: _textEditingController,
          keyboardType: _type.textInputType,
          decoration: InputDecoration(
            hintText: _type.hintText,
            hintStyle: xSmallTextStyle.copyWith(color: CupertinoColors.inactiveGray),
            errorText: null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    !_isError
                        ? _textEditingController.text.isEmpty
                            ? CupertinoColors.systemGrey
                            : CupertinoColors.activeGreen
                        : Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(
                color:
                    !_isError
                        ? _textEditingController.text.isEmpty
                            ? CupertinoColors.black
                            : CupertinoColors.activeGreen
                        : Colors.red,
                width: 1,
              ),
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
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
        ),
        const SizedBox(height: 4),
        AnimatedSwitcher(
          duration: const Duration(milliseconds: 200),
          child: SizedBox(
            height: 20,
            width: double.infinity,
            child:
                _errorText != null
                    ? Text(_errorText, style: const TextStyle(color: Colors.red, fontSize: 10))
                    : SizedBox.shrink(),
          ),
        ),
      ],
    );
  }

  const SignupTextField({
    super.key,
    required FocusNode focusNode,
    required TextEditingController textEditingController,
    required SignupTextFieldType type,
    bool isError = false,
    required String? errorText,
  }) : _focusNode = focusNode,
       _textEditingController = textEditingController,
       _type = type,
       _isError = isError,
       _errorText = errorText;
}
