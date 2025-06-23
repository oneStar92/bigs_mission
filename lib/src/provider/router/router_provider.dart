part of '../provider.dart';

final router = Provider<GoRouter>((ref) {
  //로그인 상태 확인.

  final router = GoRouter(
    initialLocation: loginPath,
    redirect: (context, state) {
      return null;
    },
    routes: [],
  );

  return router;
});
