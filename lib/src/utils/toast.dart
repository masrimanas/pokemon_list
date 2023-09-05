import 'package:flutter/material.dart';
import 'package:motion_toast/motion_toast.dart';
import 'package:motion_toast/resources/arrays.dart';
import 'package:pokemon_list/src/utils/utils.dart';

enum ToastType { success, error }

Future<void> showToast(
  BuildContext context,
  String message, {
  ToastType type = ToastType.success,
}) async =>
    switch (type) {
      ToastType.success => MotionToast(
          description: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              message,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onError,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          borderRadius: 0,
          primaryColor: Colors.greenAccent,
          backgroundType: BackgroundType.solid,
          width: context.width,
          height: context.height * .05,
          displaySideBar: false,
        ).show(context),
      ToastType.error => MotionToast(
          description: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              message,
              style: context.textTheme.bodyLarge?.copyWith(
                color: context.colorScheme.onError,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          borderRadius: 0,
          primaryColor: context.colorScheme.error,
          backgroundType: BackgroundType.solid,
          width: context.width,
          height: context.height * .05,
          displaySideBar: false,
        ).show(context),
    };
