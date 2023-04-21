import 'package:flutter/material.dart';

final buttonStyle = ButtonStyle(
  shape: MaterialStateProperty.all(
      RoundedRectangleBorder(borderRadius: BorderRadius.circular(10))),
  backgroundColor:
      MaterialStateProperty.all(const Color.fromARGB(255, 229, 78, 118)),
  minimumSize: MaterialStateProperty.all(const Size(200, 50)),
);

class AsynchronousButton extends StatefulWidget {
  const AsynchronousButton({
    Key? key,
    required this.onPressed,
    required this.buttonText,
    this.padding,
  }) : super(key: key);

  final Future<void> Function() onPressed;
  final String buttonText;
  final EdgeInsets? padding;

  @override
  State<AsynchronousButton> createState() => _AsynchronousButtonState();
}

class _AsynchronousButtonState extends State<AsynchronousButton> {
  bool _isButtonBusy = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: widget.padding ?? const EdgeInsets.symmetric(horizontal: 20),
      child: ElevatedButton(
        onPressed: _isButtonBusy
            ? null
            : () async {
                setState(() => _isButtonBusy = true);
                await widget.onPressed();
                setState(() => _isButtonBusy = false);
              },
        style: buttonStyle,
        child: Center(
          child: _isButtonBusy
              ? const CircularProgressIndicator(color: Colors.white)
              : Text(
                  widget.buttonText,
                  style: const TextStyle(color: Colors.white),
                  textAlign: TextAlign.center,
                ),
        ),
      ),
    );
  }
}
