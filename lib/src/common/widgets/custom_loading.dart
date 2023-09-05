// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokemon_list/src/utils/utils.dart';
import 'package:skeletonizer/skeletonizer.dart';

class CustomLoadingWidget extends StatelessWidget {
  const CustomLoadingWidget({
    required this.child,
    super.key,
  });

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Skeletonizer(
      containersColor: context.colors.backgroundColor?.withOpacity(.5),
      child: child,
    );
  }
}
