import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/Constants/font_family_constant.dart';
import 'package:portfolio/Widgets/Home_screen_widget/project_item_widget.dart';
import 'package:portfolio/models/scroll_offset.dart';
import 'package:sizer/sizer.dart';

class FeaturedProjects extends StatefulWidget {
  const FeaturedProjects({
    super.key,
    required this.controller,
    this.textopacityAnimation,
    this.textRevealAnimation,
    required this.maxHeight,
  });

  final AnimationController controller;
  final Animation<double>? textopacityAnimation;
  final Animation<double>? textRevealAnimation;

  final double maxHeight;

  @override
  State<FeaturedProjects> createState() => _FeaturedProjectsState();
}

class _FeaturedProjectsState extends State<FeaturedProjects>
    with TickerProviderStateMixin {
  late AnimationController controller;
  late AnimationController controller2; // Second controller
  late Animation<double> textRevealAnimation;
  late Animation<double> textopacityAnimation;
  late Animation<double> textRevealAnimation2; // Second animation
  late Animation<double> textopacityAnimation2; // Second animation
  late Animation<Offset> positionAnimation;

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1200),
      reverseDuration: const Duration(milliseconds: 300),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
      reverseDuration: const Duration(milliseconds: 375),
    );

    textRevealAnimation = Tween(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.5,
            curve: Curves.easeIn), // Increased from 0.4 to 0.6
      ),
    );

    textopacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.3, 1.0, curve: Curves.easeInOut),
      ),
    );

    textRevealAnimation2 = Tween(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller2,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutQuad),
      ),
    );

    textopacityAnimation2 = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller2,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
      ),
    );
  }

  @override
  void dispose() {
    controller.dispose();
    controller2.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Featured Projects.',
          style: TextStyle(
            fontFamily: FontFamily.appBarFont,
            fontSize: 25.sp,
            color: Colors.grey.shade500,
          ),
        ),
        const SizedBox(height: 100),
        BlocBuilder<DisplayOffset, ScrollOffset>(
            buildWhen: (previous, current) {
          if ((current.scrollOffsetValue >= 800 &&
                  current.scrollOffsetValue <= 1300) ||
              controller.isAnimating) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          // print('reload ${state.scrollOffsetValue}');

          if (state.scrollOffsetValue > 1000) {
            controller.forward();
          } else {
            controller.reverse();
          }

          return ProjectItem(
            height: widget.maxHeight,
            controller: controller,
            textRevealAnimation: textRevealAnimation,
            textopacityAnimation: textopacityAnimation,
            descriptin:
                'A Summary of my growth and experiences working at Facebook',
            title: 'Facebook Intership',
            tag1: 'PRODUCT DESIGN',
            tag2: 'INTERNSHIP',
          );
        }),
        BlocBuilder<DisplayOffset, ScrollOffset>(
            buildWhen: (previous, current) {
          if ((current.scrollOffsetValue >= 1800 &&
                  current.scrollOffsetValue <= 2500) ||
              controller2.isAnimating) {
            return true;
          } else {
            return false;
          }
        }, builder: (context, state) {
          if (state.scrollOffsetValue > 2000) {
            controller2.forward();
          } else {
            controller2.reverse();
          }

          return ProjectItem(
            height: widget.maxHeight,
            controller: controller2,
            textRevealAnimation: textRevealAnimation2,
            textopacityAnimation: textopacityAnimation2,
            descriptin: 'Building a community of entrepreneurship and talent',
            title: 'Helios',
            tag1: 'PRODUCT DESIGN',
            tag2: 'CASE STUDY',
          );
        }),
        const SizedBox(height: 50),
      ],
    );
  }
}