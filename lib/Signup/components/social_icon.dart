import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:phila/constants.dart';

class SocalIcon extends StatelessWidget {
  final String? iconSrc;
  final Function? press;
  const SocalIcon({super.key, this.iconSrc, this.press});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: press as void Function()?,
      child: Container(
        margin: const EdgeInsets.symmetric(horizontal: 10),
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          border: Border.all(width: 2, color: kPrimaryLightColor),
          shape: BoxShape.circle,
        ),
        child: SvgPicture.asset(iconSrc!, height: 20, width: 20),
      ),
    );
  }
}
