import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/Constants/font_family_constant.dart';
import 'package:portfolio/Features/change%20tab/tab_bloc.dart';
import 'package:portfolio/Features/change%20tab/tab_event.dart';
import 'package:portfolio/Features/change%20tab/tab_state.dart';
import 'package:portfolio/Widgets/textreveal.dart';
import 'package:portfolio/models/scroll_offset.dart';
import 'package:sizer/sizer.dart';

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

  @override
  void initState() {
    _scrollController = ScrollController();
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

    // projectsController = AnimationController(
    //   vsync: this,
    //   duration: const Duration(milliseconds: 1700),
    //   reverseDuration: const Duration(milliseconds: 375),
    // );

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
      body: SafeArea(
        child: _buildMainBody(size),
      ),
    );
  }

  _buildMainBody(Size size) {
    return SingleChildScrollView(
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
            // Textreveal(
            //     maxHeight: 2200,
            //     textopacityAnimation: textopacityAnimation,
            //     textrevealAnimation: textRevealAnimation,
            //     controller: controller,
            //     child: const FeaturedProjects()),
          ],
        ),
      ),
    );
  }
}

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
    return
        //  BlocBuilder<DisplayOffset, ScrollOffset>(
        //     buildWhen: (previous, current) {
        //   if ((current.scrollOffsetValue >= 900 &&
        //           current.scrollOffsetValue <= 1300) ||
        //       controller.isAnimating) {
        //     return true;
        //   } else {
        //     return false;
        //   }
        // },
        //   builder: (context, state) {
        // print('refreshed  ${state.scrollOffsetValue}');

        // if (state.scrollOffsetValue > 1100) {
        //   controller.forward();
        // } else {
        //   controller.reverse();
        // }

        Textreveal(
      maxHeight: 500,
      textopacityAnimation: widget.textopacityAnimation,
      textrevealAnimation: widget.textRevealAnimation,
      controller: widget.controller,
      child: MainBody(size: widget.size),
    );
    // });
  }
}

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

  @override
  void initState() {
    super.initState();

    controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
      reverseDuration: const Duration(milliseconds: 375),
    );

    controller2 = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
      reverseDuration: const Duration(milliseconds: 375),
    );

    textRevealAnimation = Tween(begin: 100.0, end: 0.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.0, 0.4, curve: Curves.easeOutQuad),
      ),
    );

    textopacityAnimation = Tween<double>(begin: 0.0, end: 1.0).animate(
      CurvedAnimation(
        parent: controller,
        curve: const Interval(0.2, 1.0, curve: Curves.easeInOut),
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
            color: Colors.grey.shade600,
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
            color: Colors.white,
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
            color: Colors.white,
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
            color: Colors.white,
          ),
        ),
        const Gap(20),
        Text(
          socialName,
          style: TextStyle(
            fontSize: 12.sp,
            fontWeight: FontWeight.w500,
            color: Colors.white,
          ),
        )
      ],
    );
  }
}

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
                        color: Colors.white,
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
            color: Colors.white,
          ),
        ),
        const SizedBox(width: 20),
        SizedBox(
          height: 50,
          width: 40,
          child: SvgPicture.asset(
            'Asset/Icons/right-arrow-svgrepo-com.svg',
            color: Colors.white,
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
        color: Colors.grey.shade800,
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
        child: Text(tagName),
      ),
    );
  }
}

class Header extends StatefulWidget {
  const Header({
    super.key,
  });

  @override
  State<Header> createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  bool checked = false;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        AppBar(
          size: size,
        ),
      ],
    );
  }
}

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

class AppBar extends StatefulWidget {
  const AppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AppBar> createState() => _AppBarState();
}

class _AppBarState extends State<AppBar> {
  bool isSelected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Favad',
                  style: TextStyle(
                    fontFamily: FontFamily.appBarFont,
                    fontSize: 15.sp,
                    color: Colors.white,
                  ),
                ),
                const Gap(20),
                Switch(
                  value: isSelected,
                  activeColor: Colors.grey,
                  padding: EdgeInsets.symmetric(vertical: 20),
                  onChanged: (value) {
                    setState(() {
                      isSelected = value;
                    });
                  },
                ),
                const Gap(10),
                // SizedBox(
                //   height: 25,
                //   width: 25,
                //   child: SvgPicture.asset(
                //     'Asset/Icons/moon.svg',
                //     color: Colors.white,
                //   ),
                // )
              ],
            ),
            BlocBuilder<TabBloc, TabState>(builder: (context, state) {
              int currentIndex = 0;

              if (state is TabUpdated) {
                currentIndex = state.index;
              }

              return Row(
                children: [
                  AppBarOptions(
                    text: 'About',
                    isSeletedTab: currentIndex == 0,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(0));
                    },
                  ),
                  Gap(40),
                  AppBarOptions(
                    text: 'Work ',
                    isSeletedTab: currentIndex == 1,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(1));
                    },
                  ),
                  Gap(40),
                  AppBarOptions(
                    text: 'Resume',
                    isSeletedTab: currentIndex == 2,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(2));
                    },
                  ),
                ],
              );
            })
          ],
        ),
      ],
    );
  }
}

class AppBarOptions extends StatelessWidget {
  const AppBarOptions({
    super.key,
    required this.text,
    this.isSeletedTab = false,
    required this.ontap,
  });

  final String text;

  final bool isSeletedTab;

  final VoidCallback ontap;

  @override
  Widget build(BuildContext context) {
    return IntrinsicWidth(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          const Gap(10),
          if (isSeletedTab)
            Container(
              height: 3,
              width: 40,
              color: Colors.white,
            ),
          const Gap(15),
          Material(
            type: MaterialType.transparency,
            child: InkWell(
              highlightColor: Colors.transparent,
              splashColor: Colors.transparent,
              onTap: ontap,
              child: Text(
                text,
                style: TextStyle(
                  fontFamily: FontFamily.appBarFont,
                  fontSize: 12.sp,
                  color: Colors.white,
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
