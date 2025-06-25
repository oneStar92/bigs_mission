import 'package:flutter/material.dart';

final class FutureButton<T, E extends Exception> extends StatelessWidget {
  final ValueNotifier<bool> _isProcessingNotifier = ValueNotifier(false);
  final Future<T> Function() onTap;
  final void Function(E e)? onError;
  final void Function(T result)? onComplete;
  final Widget child;

  FutureButton({super.key, required this.onTap, required this.child, this.onError, this.onComplete});

  @override
  Widget build(BuildContext context) {
    return ValueListenableBuilder(
      valueListenable: _isProcessingNotifier,
      builder: (context, isProcessing, _) {
        return AbsorbPointer(
          absorbing: isProcessing,
          child: GestureDetector(
            onTap: () async {
              if (_isProcessingNotifier.value) return;
              _isProcessingNotifier.value = true;
              try {
                final result = await onTap();
                onComplete?.call(result);
              } on E catch (e) {
                onError?.call(e);
              } finally {
                if (context.mounted) _isProcessingNotifier.value = false;
              }
            },
            child: child,
          ),
        );
      },
    );
  }
}
