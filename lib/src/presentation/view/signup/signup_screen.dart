import 'package:bigs/src/presentation/view/common/extension/show_cupertino_alert.dart';
import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:bigs/src/presentation/view/common/widget/back_button.dart';
import 'package:bigs/src/presentation/view/common/widget/loading_barrier.dart';
import 'package:bigs/src/presentation/view/common/widget/future_button.dart';
import 'package:bigs/src/presentation/view/signup/widget/signup_text_field.dart';
import 'package:bigs/src/presentation/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

final class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() => _SignupScreenState();
}

final class _SignupScreenState extends ConsumerState<SignupScreen> {
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _nicknameFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final FocusNode _confirmPasswordFocusNode = FocusNode();
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _nicknameTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();
  final TextEditingController _confirmPasswordTextController = TextEditingController();

  @override
  void initState() {
    _idFocusNode.addListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusId();
    });
    _idTextController.addListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeId(_idTextController.text);
    });
    _nicknameFocusNode.addListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusNickname();
    });
    _nicknameTextController.addListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeNickname(_nicknameTextController.text);
    });
    _passwordFocusNode.addListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusPassword();
    });
    _passwordTextController.addListener(() {
      ref.read(signupViewModelProvider.notifier).onChangePassword(_passwordTextController.text);
    });
    _confirmPasswordFocusNode.addListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusConfirmPassword();
    });
    _confirmPasswordTextController.addListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeConfirmPassword(_confirmPasswordTextController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _idFocusNode.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusId();
    });
    _idTextController.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeId(_idTextController.text);
    });
    _nicknameFocusNode.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusNickname();
    });
    _nicknameTextController.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeNickname(_nicknameTextController.text);
    });
    _passwordFocusNode.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusPassword();
    });
    _passwordTextController.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onChangePassword(_passwordTextController.text);
    });
    _confirmPasswordFocusNode.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onFocusConfirmPassword();
    });
    _confirmPasswordTextController.removeListener(() {
      ref.read(signupViewModelProvider.notifier).onChangeConfirmPassword(_confirmPasswordTextController.text);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      signupViewModelProvider.select((asyncValue) => asyncValue.valueOrNull?.isLoading ?? false),
    );
    return Stack(
      children: [
        Scaffold(appBar: _buildAppBar(context), body: SafeArea(child: _buildBody(context))),
        if (isLoading) Positioned.fill(child: LoadingBarrier()),
      ],
    );
  }

  AppBar _buildAppBar(BuildContext context) {
    return AppBar(
      leading: const SizedBox.shrink(),
      leadingWidth: 0,
      titleSpacing: 0,
      centerTitle: false,
      title: Padding(
        padding: EdgeInsets.all(16.0),
        child: Stack(
          alignment: Alignment.center,
          children: [
            Positioned(
              left: 0,
              child: CustomBackButton(
                onTap: () {
                  context.pop();
                },
              ),
            ),
            const Center(child: Text('회원가입')),
            Positioned(
              right: 0,
              child: Consumer(
                builder: (context, ref, child) {
                  final isEnabled = ref.watch(isSignupFormValidProvider);

                  return FutureButton<void, SignupException>(
                    onTap: () {
                      if (isEnabled) {
                        return ref.read(signupViewModelProvider.notifier).signup();
                      } else {
                        ref.read(signupViewModelProvider.notifier).validateAll();
                        throw SignupMissingFieldException();
                      }
                    },
                    onError: (e) {
                      switch (e) {
                        case SignupFailedException():
                          context.showCupertinoAlert(message: e.message, title: '회원가입 실패');
                          break;
                        case SignupMissingFieldException():
                          break;
                      }
                    },
                    onComplete: (_) {
                      context.pop('회원가입을 완료했어요.');
                    },
                    child: Text(
                      '가입하기',
                      style: smallTextStyle.copyWith(color: isEnabled ? Colors.black : CupertinoColors.systemGrey),
                    ),
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildBody(BuildContext context) {
    return SingleChildScrollView(
      padding: EdgeInsets.symmetric(horizontal: 16, vertical: 24),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('회원님에 대해 알려주세요.', style: largeTextStyle),
          const SizedBox(height: 32),
          Text('아이디(이메일)', style: smallTextStyle),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final errorText = ref.watch(idErrorProvider);
              return SignupTextField(
                focusNode: _idFocusNode,
                textEditingController: _idTextController,
                type: SignupTextFieldType.id,
                isError: errorText != null,
                errorText: ref.watch(idErrorProvider),
              );
            },
          ),
          Text('이름'),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final errorText = ref.watch(nicknameErrorProvider);
              return SignupTextField(
                focusNode: _nicknameFocusNode,
                textEditingController: _nicknameTextController,
                type: SignupTextFieldType.name,
                isError: errorText != null,
                errorText: ref.watch(nicknameErrorProvider),
              );
            },
          ),
          Text('비밀번호'),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final errorText = ref.watch(passwordErrorProvider);
              return SignupTextField(
                focusNode: _passwordFocusNode,
                textEditingController: _passwordTextController,
                type: SignupTextFieldType.password,
                isError: errorText != null,
                errorText: errorText,
              );
            },
          ),
          Text('비밀번호 확인'),
          const SizedBox(height: 8),
          Consumer(
            builder: (context, ref, child) {
              final errorText = ref.watch(confirmPasswordErrorProvider);
              return SignupTextField(
                focusNode: _confirmPasswordFocusNode,
                textEditingController: _confirmPasswordTextController,
                type: SignupTextFieldType.confirmPassword,
                isError: errorText != null,
                errorText: errorText,
              );
            },
          ),
        ],
      ),
    );
  }
}
