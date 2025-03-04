import 'package:flutter/material.dart';

class DefaultTextField extends StatelessWidget {
  final TextEditingController? controller;
  final String? hintText;
  final String? prefixText;
  final String? initialValue;
  final TextInputType? keyboardType;
  final Function(String)? onChanged;
  final Widget? prefixIcon;
  final int? maxLength;
  final int? maxLines;
  final int? minLines;

  const DefaultTextField(
      {super.key,
      this.controller,
      this.hintText,
      this.prefixText,
      this.initialValue,
      this.keyboardType,
      this.onChanged,
      this.prefixIcon,
      this.maxLength,
      this.maxLines,
      this.minLines});

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      style: Theme.of(context).textTheme.bodyMedium,
      onChanged: onChanged,
      initialValue: initialValue,
      maxLength: maxLength,
      maxLines: maxLines,
      minLines: minLines,
      controller: controller,
      keyboardType: keyboardType,
      decoration: InputDecoration(
        filled: true,
        fillColor: Theme.of(context).colorScheme.onSurfaceVariant,
        hintText: hintText,
        prefixText: prefixText,
        prefixIcon: prefixIcon,
        contentPadding: const EdgeInsets.symmetric(horizontal: 20,vertical: 10),
        hintStyle: Theme.of(context).textTheme.bodyMedium?.copyWith(
          color: Theme.of(context).colorScheme.onSurface.withOpacity(.7)
        ),
        border: OutlineInputBorder(
          borderRadius: BorderRadius.circular(12),
          borderSide: BorderSide.none,
        ),
        counterStyle: Theme.of(context).textTheme.bodySmall?.copyWith(
          color: Theme.of(context).colorScheme.onSurface
        )
      ),
    );
  }
}
