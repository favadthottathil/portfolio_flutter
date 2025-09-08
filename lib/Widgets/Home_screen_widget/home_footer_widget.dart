import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/src/extensions/export.dart';
import 'package:portfolio/Constants/font_family_constant.dart';
import 'package:sizer/sizer.dart';

class Footer extends StatelessWidget {
  const Footer({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Let's Get in Touch",
          style: TextStyle(
            fontFamily: FontFamily.appBarFont,
            fontSize: 15.sp,
          ),
        ),
        const SizedBox(height: 30),
        const SocialItems(),
        const SizedBox(height: 60),
        Text(
          'Designed and coded by Favad',
          style: TextStyle(
            fontSize: 10.sp,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(height: 40),
      ],
    );
  }
}

class SocialItems extends StatelessWidget {
  const SocialItems({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return const Row(
      children: [
        SocialItem(
          socialName: 'LinkedIn',
        ),
        SizedBox(width: 50),
        SocialItem(
          socialName: 'Twitter',
        ),
        SizedBox(width: 50),
        SocialItem(
          socialName: 'Email',
        ),
      ],
    );
  }
}

class SocialItem extends StatelessWidget {
  const SocialItem({super.key, required this.socialName});

  final String socialName;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        SizedBox(
          height: 30,
          width: 30,
          child: SvgPicture.asset(
            'Asset/Icons/right-arrow-svgrepo-com.svg',
            color: context.isDarkMode ? Colors.white : Colors.black,
          ),
        ),
        const Gap(20),
        Text(
          socialName,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
          ),
        )
      ],
    );
  }
}
