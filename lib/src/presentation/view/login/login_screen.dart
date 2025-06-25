import 'package:bigs/src/core/core.dart';
import 'package:bigs/src/presentation/view/common/text_style/text_style.dart';
import 'package:bigs/src/presentation/view/common/widget/future_button.dart';
import 'package:bigs/src/presentation/view/common/widget/loading_barrier.dart';
import 'package:bigs/src/presentation/view/login/widget/login_text_field.dart';
import 'package:bigs/src/presentation/view_model/view_model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  final FocusNode _idFocusNode = FocusNode();
  final FocusNode _passwordFocusNode = FocusNode();
  final TextEditingController _idTextController = TextEditingController();
  final TextEditingController _passwordTextController = TextEditingController();

  @override
  void initState() {
    _idTextController.addListener(() {
      ref.read(loginViewModelProvider.notifier).onChangeId(_idTextController.text);
    });
    _passwordTextController.addListener(() {
      ref.read(loginViewModelProvider.notifier).onChangePassword(_passwordTextController.text);
    });
    super.initState();
  }

  @override
  void dispose() {
    _idTextController.removeListener(() {
      ref.read(loginViewModelProvider.notifier).onChangeId(_idTextController.text);
    });
    _passwordTextController.removeListener(() {
      ref.read(loginViewModelProvider.notifier).onChangePassword(_passwordTextController.text);
    });
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isLoading = ref.watch(
      loginViewModelProvider.select((asyncValue) => asyncValue.valueOrNull?.isLoading ?? false),
    );
    return Stack(
      children: [
        Scaffold(body: SafeArea(child: _buildBody(context))),
        if (isLoading) Positioned.fill(child: LoadingBarrier()),
      ],
    );
  }

  Widget _buildBody(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Column(
        children: [
          Expanded(
            child: LayoutBuilder(
              builder: (context, constraints) {
                return Center(
                  child: SizedBox(
                    width: constraints.maxWidth * 0.8,
                    height: constraints.maxWidth * 0.8,
                    //Banner
                    // child: ,
                  ),
                );
              },
            ),
          ),
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                spacing: 8,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  LoginTextField(
                    focusNode: _idFocusNode,
                    textEditingController: _idTextController,
                    type: LoginTextFieldType.id,
                  ),
                  LoginTextField(
                    focusNode: _passwordFocusNode,
                    textEditingController: _passwordTextController,
                    type: LoginTextFieldType.password,
                  ),
                  SizedBox(
                    height: 24,
                    child: Consumer(
                      builder: (context, ref, child) {
                        final state = ref.watch(loginViewModelProvider).valueOrNull;
                        final errorMessage = state?.errorMessage;
                        if (errorMessage != null) {
                          return Text(
                            errorMessage,
                            style: xSmallTextStyle.copyWith(color: Colors.red),
                            textAlign: TextAlign.start,
                          );
                        } else {
                          return SizedBox.shrink();
                        }
                      },
                    ),
                  ),
                  FutureButton<void, LoginException>(
                    onTap: () => ref.read(loginViewModelProvider.notifier).login(),
                    onError: (e) {
                      showCupertinoDialog(
                        context: context,
                        builder:
                            (_) => CupertinoAlertDialog(
                              content: Text(e.message, style: TextStyle(fontSize: 15)),
                              actions: [
                                CupertinoDialogAction(
                                  isDefaultAction: true,
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                    ref.read(loginViewModelProvider.notifier).reset();
                                  },
                                  child: Text('확인', style: smallTextStyle.copyWith(color: CupertinoColors.black)),
                                ),
                              ],
                            ),
                      );
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                      decoration: BoxDecoration(color: Colors.black, borderRadius: BorderRadius.circular(8)),
                      child: Center(child: Text('로그인', style: smallTextStyle.copyWith(color: Colors.white))),
                    ),
                  ),
                  Center(
                    child: GestureDetector(
                      onTap: () async {
                        final message = await context.pushNamed<String>(signupName);

                        if (message != null) {
                          Fluttertoast.showToast(msg: message);
                        }
                      },
                      child: Text(
                        '회원가입',
                        style: xSmallTextStyle.copyWith(color: Colors.black87, decoration: TextDecoration.underline),
                      ),
                    ),
                  ),
                  Spacer(),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
