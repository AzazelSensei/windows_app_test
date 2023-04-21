import 'package:flutter/material.dart';
import 'package:windows_app_test/theme/app_text_theme.dart';

import '../theme/app_color_theme.dart';

class PrimaryButton extends StatelessWidget {
  final String? text;
  final Widget? icon;
  final void Function()? onPressed;
  final Color? color;
  final Color? focusColor;
  final bool? fullWidthButton;
  final TextStyle? style;

  const PrimaryButton({
    super.key,
    this.text,
    this.icon,
    this.onPressed,
    this.color,
    this.fullWidthButton,
    this.style,
    this.focusColor,
  });

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      elevation: 0,
      onPressed: onPressed,
      color: color ?? AppColorTheme.color_80DFFF,
      hoverColor: focusColor ?? AppColorTheme.color_00BFFF,
      focusColor: focusColor ?? AppColorTheme.color_00BFFF,
      disabledColor: color ?? AppColorTheme.color_80DFFF,
      height: 55,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(15)),
        side: BorderSide.none,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (icon != null)
            Padding(
              padding: const EdgeInsets.only(right: 10.0),
              child: SizedBox(
                  child: icon ??
                      const Placeholder(
                        fallbackHeight: 30,
                        fallbackWidth: 30,
                      )),
            ),
          if (text != null)
            Text(
              text ?? "",
              textAlign: TextAlign.center,
              overflow: TextOverflow.ellipsis,
              maxLines: 3,
              style: style ?? context.textTheme.medium,
            ),
        ],
      ),
    );
  }
}
