import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:windows_app_test/theme/app_text_theme.dart';

import '../theme/app_color_theme.dart';

showAlertDialog(
  BuildContext context, {
  required Icon icon,
  required String content,
  String? cancelActionText,
  required String defaultActionText,
  VoidCallback? onPressed,
}) {
  if (Platform.isIOS) {
    _showCupertinoAlertDialog(context,
        icon: icon,
        content: content,
        cancelActionText: cancelActionText,
        defaultActionText: defaultActionText,
        onPressed: onPressed!);
  } else {
    _showMaterialAlertDialog(context,
        icon: icon,
        content: content,
        cancelActionText: cancelActionText,
        defaultActionText: defaultActionText,
        onPressed: onPressed);
  }
}

void _showMaterialAlertDialog(BuildContext context,
    {required Icon icon,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
    VoidCallback? onPressed}) {
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return AlertDialog(
        icon: icon,
        contentPadding: const EdgeInsets.fromLTRB(20.0, 20.0, 20.0, 20.0),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(content, style: context.textTheme.small),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.fromLTRB(20.0, 0.0, 20.0, 25.0),
            child: Row(
              mainAxisSize: cancelActionText == null
                  ? MainAxisSize.min
                  : MainAxisSize.max,
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                if (cancelActionText == null)
                  Expanded(
                    child: MaterialButton(
                      height: 51,
                      color: AppColorTheme.color_80DFFF,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        side: BorderSide.none,
                      ),
                      child: Text(defaultActionText,
                          style: context.textTheme.small),
                      onPressed: () => onPressed ?? Navigator.of(context).pop(),
                    ),
                  ),
                if (cancelActionText != null)
                  SizedBox(
                    child: MaterialButton(
                      height: 51,
                      color: AppColorTheme.color_80DFFF,
                      shape: const RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(100)),
                        side: BorderSide.none,
                      ),
                      child: Text(defaultActionText,
                          style: context.textTheme.small),
                      onPressed: () => onPressed ?? Navigator.of(context).pop(),
                    ),
                  ),
                if (cancelActionText != null)
                  MaterialButton(
                    height: 51,
                    color: AppColorTheme.color_80DFFF,
                    shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(100)),
                      side: BorderSide.none,
                    ),
                    child:
                        Text(cancelActionText, style: context.textTheme.small),
                    onPressed: () => Navigator.of(context).pop(),
                  ),
              ],
            ),
          ),
        ],
      );
    },
  );
}

void _showCupertinoAlertDialog(BuildContext context,
    {required Icon icon,
    required String content,
    String? cancelActionText,
    required String defaultActionText,
    VoidCallback? onPressed}) {
  showCupertinoDialog(
    context: context,
    builder: (BuildContext context) {
      return CupertinoAlertDialog(
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
                padding: const EdgeInsets.fromLTRB(0.0, 32.0, 0.0, 8.0),
                child: icon),
            Text(content,
                style: CupertinoTheme.of(context).textTheme.textStyle),
          ],
        ),
        actions: [
          if (cancelActionText != null)
            CupertinoDialogAction(
              child: Text(cancelActionText),
              onPressed: () => Navigator.of(context).pop(),
            ),
          CupertinoDialogAction(
            onPressed: () => onPressed ?? Navigator.of(context).pop(),
            child: Text(defaultActionText),
          ),
        ],
      );
    },
  );
}
