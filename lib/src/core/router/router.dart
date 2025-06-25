part of '../core.dart';

GoRouter makeGoRouter({required bool hasToken}) {
  return GoRouter(
    initialLocation: hasToken ? homePath : loginPath,
    refreshListenable: TokenStorage.instance,
    redirect: (context, state) {
      final isInLogin = state.fullPath == loginPath || state.fullPath == '$loginPath/$signupPath';

      if (TokenStorage.instance.hasToken) {
        if (isInLogin) return homePath;
        return null;
      } else {
        if (isInLogin) return null;
        return loginPath;
      }
    },
    routes: [
      GoRoute(
        path: loginPath,
        name: loginName,
        builder: (context, state) => LoginScreen(),
        routes: [GoRoute(path: signupPath, name: signupName, builder: (context, state) => SignupScreen())],
      ),
      GoRoute(path: homePath, name: homeName, builder: (context, state) => HomeScreen()),
    ],
  );
}
