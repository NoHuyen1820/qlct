import 'package:flutter/material.dart';
import 'package:qlct/theme/colors.dart';


class RoundedButton extends StatelessWidget {
  final String text;
  final Function()? press;
  final Color color, textColor;
  const RoundedButton({
    Key? key,
    this.text = "",
    this.press,
    this.color = purpleMain,
    this.textColor = Colors.white70,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      width: size.width * 0.8,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: FlatButton(
          padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
          onPressed: press,
          child: Text(
            text,
            style: TextStyle(color: textColor,
                fontSize: 18),
          ),
          color: color,
        ),
      ),
    );
  }
}
