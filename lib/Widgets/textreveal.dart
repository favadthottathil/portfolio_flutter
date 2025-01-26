import 'package:flutter/material.dart';

class Textreveal extends StatefulWidget {
  const Textreveal({
    super.key,
    required this.child,
    required this.maxHeight,
    required this.controller,
    this.textrevealAnimation,
    this.textopacityAnimation,
  });

  final Widget child;
  final double maxHeight;
  final AnimationController controller;
  final Animation<double>? textrevealAnimation;
  final Animation<double>? textopacityAnimation;

  @override
  State<Textreveal> createState() => _TextrevealState();
}

class _TextrevealState extends State<Textreveal> with TickerProviderStateMixin {
  late AnimationController controller;
  late Animation<double> textRevealAnimation;
  late Animation<double> textopacityAnimation;

  @override
  void initState() {
    super.initState();
    controller = widget.controller;

    textRevealAnimation = widget.textrevealAnimation ??
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

    Future.delayed(
      const Duration(milliseconds: 1000),
      () {
        controller.forward();
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
        animation: controller,
        builder: (context, child) {
          return LimitedBox(
            maxHeight: widget.maxHeight,
            child: Container(
              padding: EdgeInsets.only(top: textRevealAnimation.value),
              child: Opacity(
                  opacity: textopacityAnimation.value, child: widget.child),
            ),
          );
        });
  }
}
