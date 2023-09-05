// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:pokemon_list/src/l10n/l10n.dart';
import 'package:pokemon_list/src/utils/utils.dart';

class CustomSearchField extends StatelessWidget {
  const CustomSearchField({
    this.searchCtrl,
    this.onChanged,
    super.key,
  });

  final TextEditingController? searchCtrl;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: searchCtrl,
      onChanged: onChanged,
      decoration: InputDecoration(
        focusedBorder: OutlineInputBorder(
          gapPadding: 1,
          borderRadius: BorderRadius.circular(30),
          borderSide: BorderSide(
            color: context.colors.primaryColor!,
            width: 2,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          gapPadding: 1,
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFc4c2c1),
          ),
        ),
        hintText: '${context.l10n.search}...',
        hintStyle: context.textTheme.titleMedium?.copyWith(
          color: context.colors.backgroundColor!.withOpacity(.5),
        ),
        contentPadding: const EdgeInsets.only(left: 18),
        border: OutlineInputBorder(
          gapPadding: 1,
          borderRadius: BorderRadius.circular(30),
          borderSide: const BorderSide(
            color: Color(0xFFc4c2c1),
          ),
        ),
      ),
    );
  }
}
