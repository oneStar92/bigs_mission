part of '../provider.dart';

final router = Provider<GoRouter>((ref) {
  //로그인 상태 확인.

  final router = GoRouter(
    initialLocation: loginPath,
    redirect: (context, state) {
      return null;
    },
    routes: [
      GoRoute(
        path: loginPath,
        name: loginName,
        builder: (context, state) => LoginScreen(),
        routes: [GoRoute(path: signupPath, name: signupName, builder: (context, state) => SignupScreen())],
      ),
    ],
  );

  return router;
});
