import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:portfolio/Constants/font_family_constant.dart';
import 'package:sizer/sizer.dart';

class ProjectItem extends StatefulWidget {
  const ProjectItem(
      {super.key,
      required this.descriptin,
      required this.title,
      required this.tag1,
      required this.tag2,
      required this.controller,
      this.textopacityAnimation,
      this.textRevealAnimation,
      required this.height});

  final String descriptin;
  final String title;
  final String tag1;
  final String tag2;
  final AnimationController controller;
  final Animation<double>? textopacityAnimation;
  final Animation<double>? textRevealAnimation;
  final double height;

  @override
  State<ProjectItem> createState() => _ProjectItemState();
}

class _ProjectItemState extends State<ProjectItem> {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textopacityAnimation;

  @override
  void initState() {
    super.initState();

    controller = widget.controller;

    textRevealAnimation = widget.textRevealAnimation ??
        Tween(begin: 100.0, end: 0.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.0, 0.4, curve: Curves.easeOutQuad),
          ),
        );

    textopacityAnimation = widget.textopacityAnimation ??
        Tween<double>(begin: 0.0, end: 1.0).animate(
          CurvedAnimation(
            parent: controller,
            curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
          ),
        );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return LimitedBox(
            maxHeight: widget.height,
            child: Container(
              padding: EdgeInsets.only(top: textRevealAnimation.value),
              child: Opacity(
                opacity: textopacityAnimation.value,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    ProjectTags(
                      tag1: widget.tag1,
                      tag2: widget.tag2,
                    ),
                    const SizedBox(
                      height: 50,
                    ),
                    _projectTtile(),
                    const SizedBox(height: 20),
                    Text(
                      widget.descriptin,
                      style: TextStyle(
                        fontSize: 10.sp,
                      ),
                    ),
                    const SizedBox(height: 30),
                    ClipRRect(
                      borderRadius: BorderRadius.circular(5),
                      child: Container(
                        height: 600,
                        color: Colors.grey.shade900,
                        width: double.infinity,
                      ),
                    ),
                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ),
          );
        });
  }

  Row _projectTtile() {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Text(
          widget.title,
          style: TextStyle(
            fontFamily: FontFamily.appBarFont,
            fontSize: 15.sp,
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          height: 50,
          width: 40,
          child: SvgPicture.asset(
            'Asset/Icons/right-arrow-svgrepo-com.svg',
          ),
        ),
      ],
    );
  }
}

class ProjectTags extends StatelessWidget {
  const ProjectTags({
    super.key,
    required this.tag1,
    required this.tag2,
  });

  final String tag1;
  final String tag2;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        ProjectTag(tagName: tag1),
        const Gap(10),
        ProjectTag(tagName: tag2),
      ],
    );
  }
}

class ProjectTag extends StatelessWidget {
  const ProjectTag({
    super.key,
    required this.tagName,
  });

  final String tagName;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(5),
      child: Container(
        color: context.isDarkMode ? Colors.grey.shade800 : Colors.grey.shade300,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(tagName),
      ),
    );
  }
}