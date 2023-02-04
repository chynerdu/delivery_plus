import 'package:deliveryplus/helpers/theme/customColors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class InputTextCenter extends StatelessWidget {
  const InputTextCenter(
      {this.label = '',
      this.suffixIcon = Icons.person,
      this.suffixColor = Colors.transparent,
      this.initialValue = '',
      this.readOnly = false,
      this.style = const TextStyle(color: Colors.white),
      this.obscure = false,
      this.isError = false,
      this.showErrorText = "field can't be empty",
      this.controller});

  final String label;
  final IconData suffixIcon;
  final Color suffixColor;
  final String initialValue;
  final bool readOnly;
  final bool obscure;
  final bool isError;
  final String showErrorText;
  final TextStyle style;
  final TextEditingController? controller;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      readOnly: readOnly,
      textAlign: TextAlign.center,
      obscureText: obscure,
      decoration: InputDecoration(
        hintText: initialValue,
        labelText: label,
        errorText: isError ? showErrorText : null,
        labelStyle: TextStyle(color: Colors.black),
        fillColor: CustomColors.AuthInput,
        hintStyle: TextStyle(color: Colors.black, fontSize: 13),
        contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
        border: new UnderlineInputBorder(
          borderSide: BorderSide(color: CustomColors.SecondaryColor4),
        ),
        focusedBorder: new UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: CustomColors.SecondaryColor4),
        ),
        enabledBorder: new UnderlineInputBorder(
          borderRadius: BorderRadius.circular(6),
          borderSide: BorderSide(color: CustomColors.SecondaryColor4),
        ),
      ),
    );
  }
}

class Input extends StatelessWidget {
  final String? hintText;
  final dynamic validator;
  final dynamic onSaved;
  final dynamic onChanged;
  final Function()? toggleEye;
  final KeyboardType? keyboard;
  final String? init;
  final bool? isPassword;
  final Color? isPasswordColor;
  final bool? showObscureText;
  final bool? obscureText;
  final Color? styleColor;
  final Color? hintStyleColor;
  final bool? enabled;
  final bool? readOnly;
  final String? labelText;
  final dynamic? maxLines;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffixIcon;

  final Key? key;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? isError;
  final String? showErrorText;
  final VoidCallback? onTap;
  final int? maxLength;

  Input(
      {this.hintText = '',
      required this.validator,
      required this.onSaved,
      this.toggleEye,
      this.init,
      this.isPassword = false,
      this.isPasswordColor,
      this.showObscureText,
      this.obscureText = false,
      this.keyboard,
      this.styleColor,
      this.maxLength,
      this.hintStyleColor,
      this.enabled = true,
      this.readOnly = false,
      this.labelText,
      this.maxLines = 1,
      this.borderColor = CustomColors.Ivory,
      this.onChanged,
      this.prefix,
      this.key,
      this.controller,
      this.inputFormatters,
      this.fillColor = CustomColors.AuthInput,
      this.isError = false,
      this.showErrorText = "field can't be empty",
      this.suffixIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 70,
      padding: EdgeInsets.all(0),
      child: TextFormField(
          onTap: onTap != null ? onTap : () {},
          inputFormatters: inputFormatters,
          controller: controller,
          key: key,
          maxLength: maxLength ?? null,
          enabled: enabled,
          readOnly: readOnly as bool,
          style: TextStyle(fontSize: 17, color: Color(0xFF0F0F0F)),
          cursorColor: styleColor,
          obscureText: obscureText as bool,
          maxLines: maxLines,
          onChanged: onChanged != null ? onChanged : (String string) {},
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(25, 10, 20, 20),
            prefixIcon: prefix,
            filled: true,
            fillColor: fillColor,
            labelText: labelText,
            labelStyle: TextStyle(color: Colors.black),
            hintText: hintText ?? labelText,
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            isDense: true,
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(width: 0.5, color: Color(0xffAEAEAE)),
            ),
            disabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: borderColor as Color),
            ),
            // contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            suffixIcon: isPassword ?? true
                ? GestureDetector(
                    onTap: toggleEye != null ? toggleEye!() : () {},
                    child: Icon(
                      showObscureText ?? true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFFC0C1C3),
                    ),
                  )
                : suffixIcon,
            errorText: isError ?? true ? showErrorText : null,
          ),
          validator: validator,
          initialValue: init,
          onSaved: onSaved,
          keyboardType: keyboard == KeyboardType.EMAIL
              ? TextInputType.emailAddress
              : keyboard == KeyboardType.NUMBER
                  ? TextInputType.number
                  : keyboard == KeyboardType.PHONE
                      ? TextInputType.phone
                      : TextInputType.text),
    );
  }
}

class UnderlinedInput extends StatelessWidget {
  final String? hintText;
  final dynamic validator;
  final dynamic onSaved;
  final Function()? onChanged;
  final Function()? toggleEye;
  final KeyboardType? keyboard;
  final String? init;
  final bool? isPassword;
  final Color? isPasswordColor;
  final bool? showObscureText;
  final bool? obscureText;
  final Color? styleColor;
  final Color? hintStyleColor;
  final bool? enabled;
  final bool? readOnly;
  final String? labelText;
  final dynamic? maxLines;
  final Color? borderColor;
  final Widget? prefix;
  final Widget? suffixIcon;
  final Key? key;
  final TextEditingController? controller;
  final List<TextInputFormatter>? inputFormatters;
  final Color? fillColor;
  final bool? isError;
  final String? showErrorText;
  final VoidCallback? onTap;

  UnderlinedInput(
      {this.hintText = '',
      required this.validator,
      required this.onSaved,
      this.toggleEye,
      this.init,
      this.isPassword = false,
      this.isPasswordColor,
      this.showObscureText,
      this.obscureText = false,
      this.keyboard,
      this.styleColor,
      this.hintStyleColor,
      this.enabled = true,
      this.readOnly = false,
      this.labelText,
      this.maxLines = 1,
      this.borderColor = CustomColors.Ivory,
      this.onChanged,
      this.prefix,
      this.key,
      this.controller,
      this.inputFormatters,
      this.fillColor = CustomColors.AuthInput,
      this.isError = false,
      this.showErrorText = "field can't be empty",
      this.suffixIcon,
      this.onTap});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(0),
      child: TextFormField(
          onTap: onTap != null ? onTap : () {},
          inputFormatters: inputFormatters,
          controller: controller,
          key: key,
          enabled: enabled,
          readOnly: readOnly as bool,
          style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w700,
              color: Color(0xFF000000)),
          cursorColor: styleColor,
          obscureText: obscureText as bool,
          maxLines: maxLines,
          onChanged: onChanged != null ? onChanged!() : (String) {},
          decoration: InputDecoration(
            contentPadding: EdgeInsets.fromLTRB(25, 20, 20, 20),
            prefixIcon: prefix,
            // filled: false,
            // fillColor: fillColor,
            labelText: labelText,
            labelStyle: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: Color(0xff979797)),
            hintText: hintText ?? labelText,
            hintStyle: TextStyle(color: Color(0xff9E9E9E)),
            isDense: true,
            errorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: Colors.red),
            ),
            enabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(width: 0.5, color: Color(0xff979797)),
            ),
            focusedBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(width: 0.5, color: Color(0xff979797)),
            ),
            disabledBorder: UnderlineInputBorder(
              borderRadius: BorderRadius.circular(6),
              borderSide: BorderSide(color: borderColor as Color),
            ),
            // contentPadding: EdgeInsets.only(top: 10, bottom: 10),
            suffixIcon: isPassword ?? true
                ? GestureDetector(
                    onTap: toggleEye != null ? toggleEye!() : () {},
                    child: Icon(
                      showObscureText ?? true
                          ? Icons.visibility
                          : Icons.visibility_off,
                      color: Color(0xFFC0C1C3),
                    ),
                  )
                : suffixIcon,
            errorText: isError ?? true ? showErrorText : null,
          ),
          validator: validator,
          initialValue: init,
          onSaved: onSaved,
          keyboardType: keyboard == KeyboardType.EMAIL
              ? TextInputType.emailAddress
              : keyboard == KeyboardType.NUMBER
                  ? TextInputType.number
                  : keyboard == KeyboardType.PHONE
                      ? TextInputType.phone
                      : TextInputType.text),
    );
  }
}

enum KeyboardType { EMAIL, PHONE, NUMBER, TEXT }
