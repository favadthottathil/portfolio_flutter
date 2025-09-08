import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class MainBody extends StatelessWidget {
  const MainBody({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(
          height: size.height * 0.2,
        ),
        Text(
          'Favad T.',
          style: GoogleFonts.bebasNeue(
            fontSize: 30.sp,
            letterSpacing: 4,
            color: Colors.grey.shade500,
          ),
        ),
        // const Gap(10),
        Text(
          'Flutter Developer.',
          textAlign: TextAlign.start,
          style: GoogleFonts.bebasNeue(
            fontSize: 25.sp,
            letterSpacing: 2,
          ),
        ),
      ],
    );
  }
}