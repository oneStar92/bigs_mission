import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class SignupTextField extends StatelessWidget {
  final FocusNode _focusNode;
  final TextEditingController _textEditingController;
  final TextInputType _textInputType;
  final List<TextInputFormatter> _inputFormatters;
  final String _hintText;
  final TextStyle _hintStyle;
  final TextStyle _textStyle;
  final bool _isError;
  final String? _errorText;
  final bool _obscureText;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextFormField(
          focusNode: _focusNode,
          controller: _textEditingController,
          keyboardType: _textInputType,
          inputFormatters: _inputFormatters,
          decoration: InputDecoration(
            hintText: _hintText,
            hintStyle: _hintStyle,
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
                        value.text.isNotEmpty ? Icon(CupertinoIcons.xmark_circle_fill) : SizedBox.shrink(),
              ),
            ),
            suffixIconConstraints: const BoxConstraints(maxWidth: 28, minWidth: 28),
          ),
          validator: null,
          obscureText: _obscureText,
          style: _textStyle,
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
    required TextInputType textInputType,
    List<TextInputFormatter> inputFormatters = const [],
    required String hintText,
    required TextStyle hintStyle,
    required TextStyle textStyle,
    required String? errorText,
    bool isError = false,
    bool obscureText = false,
  }) : _focusNode = focusNode,
       _textEditingController = textEditingController,
       _textInputType = textInputType,
       _inputFormatters = inputFormatters,
       _hintText = hintText,
       _hintStyle = hintStyle,
       _textStyle = textStyle,
  _isError = isError,
       _errorText = errorText,
       _obscureText = obscureText;
}
