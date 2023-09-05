import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/common/widgets/widgets.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class CustomDialog extends StatelessWidget {
  const CustomDialog({
    required this.text,
    required this.path,
    this.onConfirm,
    this.onCancel,
    super.key,
    this.onConfirmText = 'Yes',
    this.onCancelText = 'Cancel',
  });
  final String text;
  final String path;
  final VoidCallback? onConfirm;
  final VoidCallback? onCancel;
  final String onConfirmText;
  final String onCancelText;
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      surfaceTintColor: Colors.white,
      actionsAlignment: MainAxisAlignment.center,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          LottieBuilder.asset(
            path,
            width: 200,
            height: 200,
          ),
          const SizedBox(height: 12),
          Text(
            text,
            textAlign: TextAlign.center,
            maxLines: 10,
            style: context.textTheme.titleMedium,
          ),
        ],
      ),
      actions: [
        if (onCancel != null)
          CustomButton(
            text: onCancelText,
            type: ButtonType.secondary,
            borderRadius: 30,
            size: const Size(100, 50),
            onPressed: () => onCancel?.call(),
          ),
        if (onConfirm != null) const SizedBox(width: 8),
        CustomButton(
          text: onConfirmText,
          type: ButtonType.primary,
          isGradient: true,
          borderRadius: 30,
          onPressed: () => onConfirm?.call(),
        ),
      ],
    );
  }
}
