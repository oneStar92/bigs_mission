part of 'signup_text_field.dart';

enum SignupTextFieldType {
  id,
  name,
  password,
  confirmPassword;

  String get hintText {
    switch (this) {
      case SignupTextFieldType.id:
        return '아이디(이메일)를 입력해주세요.';
      case SignupTextFieldType.name:
        return '이름을 입력해주세요.';
      case SignupTextFieldType.password:
        return '비밀번호를 입력해주세요.';
      case SignupTextFieldType.confirmPassword:
        return '비밀번호를 한번더 입력해주세요.';
    }
  }

  TextInputType get textInputType {
    switch (this) {
      case SignupTextFieldType.id:
        return TextInputType.emailAddress;
      default:
        return TextInputType.text;
    }
  }

  bool get obscureText {
    switch (this) {
      case SignupTextFieldType.password || SignupTextFieldType.confirmPassword:
        return true;
      default:
        return false;
    }
  }
}
