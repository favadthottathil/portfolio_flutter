import 'package:flutter/material.dart';
import 'package:portfolio/Widgets/Home_screen_widget/main_body_widget.dart';
import 'package:portfolio/Widgets/textreveal.dart';

class FirstSection extends StatefulWidget {
  const FirstSection({
    super.key,
    required this.controller,
    required this.textopacityAnimation,
    required this.textRevealAnimation,
    required this.size,
  });

  final AnimationController controller;
  final Animation<double>? textopacityAnimation;
  final Animation<double>? textRevealAnimation;

  final Size size;

  @override
  State<FirstSection> createState() => _FirstSectionState();
}

class _FirstSectionState extends State<FirstSection> {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textopacityAnimation;

  @override
  void initState() {
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

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Textreveal(
      maxHeight: 500,
      textopacityAnimation: widget.textopacityAnimation,
      textrevealAnimation: widget.textRevealAnimation,
      controller: widget.controller,
      child: MainBody(size: widget.size),
    );
    // });
  }
}
