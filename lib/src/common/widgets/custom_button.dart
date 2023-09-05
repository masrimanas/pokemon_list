// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokemon_list/src/common/enums.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({
    required this.onPressed,
    required this.type,
    required this.text,
    super.key,
    this.icon,
    this.isGradient = false,
    this.borderRadius = 10,
    this.size = const Size(100, 40),
    this.color,
    this.child,
  });

  final VoidCallback onPressed;
  final ButtonType type;
  final String text;
  final IconData? icon;
  final bool isGradient;
  final double borderRadius;
  final Size size;
  final Color? color;
  final Widget Function(String)? child;

  @override
  Widget build(BuildContext context) {
    return switch (type) {
      ButtonType.primary => _PrimaryButton(
          size: size,
          isGradient: isGradient,
          onPressed: onPressed,
          text: text,
          icon: icon,
          borderRadius: borderRadius,
          child: child,
        ),
      ButtonType.secondary => _SecondaryButton(
          size: size,
          isGradient: isGradient,
          onPressed: onPressed,
          text: text,
          icon: icon,
          color: color,
          borderRadius: borderRadius,
          child: child,
        ),
    };
  }
}

class _PrimaryButton extends StatelessWidget {
  const _PrimaryButton({
    required this.onPressed,
    required this.text,
    required this.borderRadius,
    required this.size,
    this.icon,
    this.isGradient = false,
    this.child,
  });

  final VoidCallback onPressed;
  final String text;
  final IconData? icon;
  final bool isGradient;
  final double borderRadius;
  final Size size;
  final Widget Function(String)? child;

  @override
  Widget build(BuildContext context) {
    return switch (isGradient) {
      true => DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                context.colors.primaryColor!,
                context.colors.primaryColor!.withOpacity(.7),
              ],
            ),
          ),
          child: FilledButton(
            style: FilledButton.styleFrom(
              fixedSize: size,
              maximumSize: Size(context.width * .9, context.width * .5),
              backgroundColor: Colors.transparent,
              shadowColor: Colors.transparent,
              foregroundColor: Colors.transparent,
              surfaceTintColor: Colors.transparent,
            ),
            onPressed: onPressed,
            child: child?.call(text) ??
                Text(
                  text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.backgroundColor,
                  ),
                ),
          ),
        ),
      false => icon != null
          ? FilledButton.icon(
              style: ButtonStyle(
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              onPressed: onPressed,
              icon: Icon(
                icon,
                size: 16,
                color: context.colors.backgroundColor,
              ),
              label: child?.call(text) ??
                  Text(
                    text,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.backgroundColor,
                    ),
                  ),
            )
          : FilledButton(
              style: ButtonStyle(
                fixedSize: MaterialStateProperty.all(size),
                maximumSize: MaterialStateProperty.all(
                  Size(context.width * .9, context.width * .5),
                ),
                shape: MaterialStateProperty.all(
                  RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(borderRadius),
                  ),
                ),
              ),
              onPressed: onPressed,
              child: child?.call(text) ??
                  Text(
                    text,
                    style: context.textTheme.bodyMedium?.copyWith(
                      color: context.colors.backgroundColor,
                    ),
                  ),
            ),
    };
  }
}

class _SecondaryButton extends StatelessWidget {
  const _SecondaryButton({
    required this.onPressed,
    required this.text,
    required this.isGradient,
    required this.borderRadius,
    required this.size,
    this.color,
    this.icon,
    this.child,
  });

  final VoidCallback onPressed;
  final String text;
  final Color? color;
  final IconData? icon;
  final bool isGradient;
  final double borderRadius;
  final Size size;
  final Widget Function(String)? child;

  @override
  Widget build(BuildContext context) {
    return icon != null
        ? FilledButton.icon(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              fixedSize: size,
              maximumSize: Size(context.width * .9, context.width * .5),
              backgroundColor: color ?? context.colorScheme.background,
              shape: RoundedRectangleBorder(
                side: BorderSide(
                  color: Colors.grey.withOpacity(.5),
                ),
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            icon: Icon(
              icon,
              size: 16,
              color: context.colors.primaryColor,
            ),
            label: child?.call(text) ??
                Text(
                  text,
                  maxLines: 1,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.textColor,
                  ),
                ),
          )
        : FilledButton(
            onPressed: onPressed,
            style: FilledButton.styleFrom(
              fixedSize: size,
              maximumSize: Size(context.width * .9, context.width * .5),
              backgroundColor: context.colorScheme.background,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(borderRadius),
              ),
            ),
            child: child?.call(text) ??
                Text(
                  text,
                  style: context.textTheme.bodyMedium?.copyWith(
                    color: context.colors.primaryColor,
                  ),
                ),
          );
  }
}
