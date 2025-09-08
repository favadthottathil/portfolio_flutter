import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/Widgets/Home_screen_widget/featured_project_widget.dart';
import 'package:portfolio/Widgets/Home_screen_widget/first_section_widget.dart';
import 'package:portfolio/Widgets/Home_screen_widget/home_footer_widget.dart';
import 'package:portfolio/Widgets/header.dart';
import 'package:portfolio/models/scroll_offset.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;

  final ScrollController homeScrollController = ScrollController();

  late AnimationController controller;
  // late AnimationController projectsController;
  late Animation<double> textRevealAnimation;
  late Animation<double> textopacityAnimation;

  late ScrollController projectsScrollController;

  @override
  void initState() {
    _scrollController = ScrollController();
    projectsScrollController = ScrollController();
    super.initState();

    _scrollController.addListener(
      () {
        context.read<DisplayOffset>().changeDisplayOffset(
              (MediaQuery.of(context).size.height +
                      _scrollController.position.pixels)
                  .toInt(),
            );
      },
    );

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
      reverseDuration: const Duration(milliseconds: 375),
    );

    textRevealAnimation = Tween(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.3, curve: Curves.easeOut),
      ),
    );

    textopacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(parent: controller, curve: Curves.easeOut),
    );
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body:
          //  WebSmoothScroll(
          // controller: projectsScrollController,
          // child:
          //  SingleChildScrollView(
          //   controller: projectsScrollController,
          //   physics: NeverScrollableScrollPhysics(),
          //   child:
          SafeArea(
        child: _buildMainBody(size),
      ),
      // ),
      // ),
    );
  }

  _buildMainBody(Size size) {
    return WebSmoothScroll(
      controller: _scrollController,
      child: SingleChildScrollView(
        controller: _scrollController,
        child: Container(
          margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Header(),
              FirstSection(
                controller: controller,
                textopacityAnimation: textopacityAnimation,
                textRevealAnimation: textRevealAnimation,
                size: size,
              ),
              const SizedBox(height: 150),
              FeaturedProjects(
                controller: controller,
                maxHeight: 1000,
                textRevealAnimation: textRevealAnimation,
                textopacityAnimation: textopacityAnimation,
              ),
              const Footer(),
            ],
          ),
        ),
      ),
    );
  }
}
