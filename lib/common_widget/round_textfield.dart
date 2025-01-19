import 'package:flutter/material.dart';

import '../common/colo_extension.dart';

class RoundTextField extends StatefulWidget {
  final TextEditingController? controller;
  final TextInputType? keyboardType;
  final String hitText;
  final String icon;
  final Widget? rigtIcon;
  final bool obscureText;
  final EdgeInsets? margin;
  final bool enabled;
  const RoundTextField(
      {super.key,
      required this.hitText,
      required this.icon,
      this.controller,
      this.margin,
      this.keyboardType,
      this.obscureText = false,
      this.enabled = true,
      this.rigtIcon});

  @override
  State<RoundTextField> createState() => _RoundTextFieldState();
}

class _RoundTextFieldState extends State<RoundTextField> {
  bool _isPasswordVisible = false;

  void togglePasswordVisibility() {
    setState(() {
      _isPasswordVisible = !_isPasswordVisible;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: widget.margin,
      decoration: BoxDecoration(
          color: TColor.lightGray, borderRadius: BorderRadius.circular(15)),
      child: TextField(
        controller: widget.controller,
        keyboardType: widget.keyboardType,
        obscureText: widget.obscureText && !_isPasswordVisible,
        enabled: widget.enabled,
        decoration: InputDecoration(
            contentPadding:
                const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
            enabledBorder: InputBorder.none,
            focusedBorder: InputBorder.none,
            hintText: widget.hitText,
            // suffixIcon: rigtIcon,
            suffixIcon: widget.obscureText
                ? IconButton(
                    icon: Icon(
                      _isPasswordVisible
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Colors.grey,
                    ),
                    onPressed: togglePasswordVisibility,
                  )
                : null,
            prefixIcon: Container(
                alignment: Alignment.center,
                width: 20,
                height: 20,
                child: Image.asset(
                  widget.icon,
                  width: 20,
                  height: 20,
                  fit: BoxFit.contain,
                  color: TColor.gray,
                )),
            hintStyle: TextStyle(color: TColor.gray, fontSize: 12)),
      ),
    );
  }
}
