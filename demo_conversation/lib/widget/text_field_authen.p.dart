import 'package:demo_conversation/res/res.dart';
import 'package:flutter/material.dart';

class TextFieldAuthen extends StatefulWidget {
  final bool isValid;
  final TextEditingController controller;
  final String label;
  final Function(String str) onChange;
  final bool isObscure;
  final String helperText;
  final String hintText;

  TextFieldAuthen({
    this.controller,
    this.isValid = false,
    this.label,
    this.onChange,
    this.isObscure = false,
    this.helperText,
    this.hintText,
  });

  @override
  _TextFieldAuthenState createState() => _TextFieldAuthenState();
}

class _TextFieldAuthenState extends State<TextFieldAuthen> {
  FocusNode focusNode;
  bool isFocus = false;

  @override
  void initState() {
    focusNode = FocusNode();

    focusNode.addListener(() {
      setState(() {
        isFocus = focusNode.hasFocus;
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        TextField(
          obscureText: widget.isObscure,
          style: St.p_01,
          focusNode: focusNode,
          onChanged: (str) {
            if (widget.onChange != null) {
              widget.onChange(str);
            }
          },
          controller: widget.controller,
          decoration: InputDecoration(
            suffixIcon: widget.isValid
                ? Container(
                    width: 14,
                    height: 14,
                    child: Image.asset(Id.proper),
                  )
                : SizedBox(),
            helperText: widget.helperText ?? null,
            helperStyle: TextStyle(color: Colors.grey.shade500),
            hintText: widget.hintText ?? null,
            helperMaxLines: 2,
            hintStyle: TextStyle(color: Colors.grey.shade300),
            labelText: widget.label ?? '',
            labelStyle: isFocus ? St.p_07 : St.p_04,
            contentPadding: const EdgeInsets.only(right: 20),
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Cl.greyUnderline),
            ),
            disabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Cl.greyUnderline),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(
                color: Cl.apricot,
                width: 2.0,
              ),
            ),
            alignLabelWithHint: false,
          ),
          cursorColor: Cl.apricot,
        ),
      ],
    );
  }
}
