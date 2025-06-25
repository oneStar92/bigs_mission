part of 'login_text_field.dart';

enum LoginTextFieldType {
  id,
  password;

  String get hintText {
    switch (this) {
      case LoginTextFieldType.id:
        return '아이디';
      case LoginTextFieldType.password:
        return '비밀번호';
    }
  }

  TextInputType get textInputType {
    switch (this) {
      case LoginTextFieldType.id:
        return TextInputType.emailAddress;
      case LoginTextFieldType.password:
        return TextInputType.text;
    }
  }

  bool get obscureText {
    switch (this) {
      case LoginTextFieldType.id:
        return false;
      case LoginTextFieldType.password:
        return true;
    }
  }

  Widget get icon {
    switch (this) {
      case LoginTextFieldType.id:
        return Icon(Icons.person);
      case LoginTextFieldType.password:
        return Icon(Icons.lock_outline);
    }
  }
}
