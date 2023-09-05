// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class CustomIconButton<T> extends StatelessWidget {
  const CustomIconButton({
    required this.icon,
    required this.onPressed,
    super.key,
    this.color = Colors.transparent,
    this.iconColor,
    this.shape = BoxShape.rectangle,
    this.borderRadius = 10,
    this.size = const Size(50, 50),
    this.iconPadding = const (top: 2, bottom: 2, right: 2, left: 2),
  });

  final T icon;
  final VoidCallback onPressed;
  final Color color;
  final Color? iconColor;
  final BoxShape shape;
  final double borderRadius;
  final Size size;
  final ({double top, double bottom, double right, double left}) iconPadding;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        width: size.width,
        height: size.height,
        padding: EdgeInsets.only(
          top: iconPadding.top,
          bottom: iconPadding.bottom,
          right: iconPadding.right,
          left: iconPadding.left,
        ),
        decoration: BoxDecoration(
          color: color,
          shape: shape,
          borderRadius: shape == BoxShape.rectangle
              ? BorderRadius.circular(borderRadius)
              : null,
        ),
        child: icon is IconData
            ? Icon(
                icon as IconData,
                color: iconColor ?? context.colors.primaryColor,
              )
            : SvgPicture.asset(
                icon as String,
                colorFilter: ColorFilter.mode(
                  iconColor ?? context.colors.primaryColor!,
                  BlendMode.srcIn,
                ),
              ),
      ),
    );
  }
}
