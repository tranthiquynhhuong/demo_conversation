import 'package:demo_conversation/res/res.dart';
import 'package:flutter/material.dart';

class SignInBtn extends StatefulWidget {
  final Function onPressed;
  final String title;

  SignInBtn({this.onPressed, @required this.title}) : assert(title != null);

  @override
  _SignInBtnState createState() => _SignInBtnState();
}

class _SignInBtnState extends State<SignInBtn> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 50,
      child: buildBtn(),
    );
  }

  Widget buildBtn() {
    return buildNormalBtn();
  }

  Widget buildNormalBtn() {
    return Container(
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        gradient: LinearGradient(
          begin: Alignment(1.0, 0.6),
          end: Alignment(-0.0, 0.6),
          colors: [
            Cl.warmPink,
            Cl.salmonTwo,
            Cl.apricot,
          ],
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          borderRadius: BorderRadius.all(Radius.circular(3)),
          onTap: widget.onPressed,
          child: Center(
            child: Text(
              widget.title,
              style: St.p_02,
            ),
          ),
        ),
      ),
    );
  }
}
