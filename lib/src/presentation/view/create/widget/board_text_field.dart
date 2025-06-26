import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BoardTextField extends StatelessWidget {
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final bool _isError;
  final String? _errorText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: _textEditingController,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            hintStyle: xSmallTextStyle.copyWith(color: CupertinoColors.inactiveGray),
            errorText: null,
            enabledBorder: OutlineInputBorder(
              borderSide: BorderSide(color: !_isError ? CupertinoColors.systemGrey : Colors.red, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            focusedBorder: OutlineInputBorder(
              borderSide: BorderSide(color: !_isError ? CupertinoColors.black : Colors.red, width: 1),
              borderRadius: BorderRadius.circular(4),
            ),
            contentPadding: const EdgeInsets.symmetric(horizontal: 8),
          ),
          validator: null,
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

  const BoardTextField({
    super.key,
    required FocusNode focusNode,
    required TextEditingController textEditingController,
    bool isError = false,
    required String? errorText,
  }) : _focusNode = focusNode,
       _textEditingController = textEditingController,
       _isError = isError,
       _errorText = errorText;
}
