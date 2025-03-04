import 'package:flutter/material.dart';

class DefaultButton extends StatelessWidget {
  final String? text;
  final Color? backgroundColor;
  final Color? textColor;
  final Function()? onPressed;
  final EdgeInsets? padding;

  const DefaultButton(
      {super.key,
      this.text,
      this.backgroundColor,
      this.textColor,
      this.onPressed,
      this.padding});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        width: double.maxFinite,
        child: ElevatedButton(
            onPressed: onPressed,
            style: Theme.of(context).elevatedButtonTheme.style?.copyWith(
                backgroundColor: WidgetStateProperty.resolveWith(
              (state) {
                if (state.contains(WidgetState.disabled)) {
                  return backgroundColor?.withOpacity(.5);
                } else {
                  return backgroundColor;
                }
              },
            ), foregroundColor: WidgetStateProperty.resolveWith((state) {
              if (state.contains(WidgetState.disabled)) {
                return textColor?.withOpacity(.5);
              } else {
                return textColor;
              }
            })),
            child: Text(text ?? '')));
  }
}
