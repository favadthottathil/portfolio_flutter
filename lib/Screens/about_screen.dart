import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:gap/gap.dart';
import 'package:get/get_utils/get_utils.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:portfolio/Widgets/Home_screen_widget/home_footer_widget.dart';
import 'package:portfolio/Widgets/header.dart';
import 'package:sizer/sizer.dart';
import 'package:web_smooth_scroll/web_smooth_scroll.dart';

class AboutScreen extends StatefulWidget {
  const AboutScreen({super.key});

  @override
  State<AboutScreen> createState() => _AboutScreenState();
}

class _AboutScreenState extends State<AboutScreen> {
  late ScrollController _scrollController;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
  }

  @override
  void dispose() {
    _scrollController.dispose();
    // Dispose of the controller when the widget is removed from the widget tree
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    return Scaffold(
      body: WebSmoothScroll(
        controller: _scrollController,
        child: SingleChildScrollView(
          physics: NeverScrollableScrollPhysics(),
          controller: _scrollController,
          child: SafeArea(
            child: _buildMainBody(size),
          ),
        ),
      ),
    );
  }

  _buildMainBody(Size size) {
    return SingleChildScrollView(
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: size.width * 0.1),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Header(),
            Gap(100),
            AboutFirstSection(size: size),
            Gap(100),
            ExperianceSection(),
            Gap(100),
            const Footer(),
          ],
        ),
      ),
    );
  }
}

class ExperianceSection extends StatelessWidget {
  const ExperianceSection({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Experience.',
          style: GoogleFonts.anton(
            fontSize: 20.sp,
            letterSpacing: 4,
            color: Colors.grey.shade800,
          ),
        ),
        Gap(70),
        ExperianceItem(
          companyName: 'Sawara Solutions Pvt ltd (Promilo)',
          position: 'Flutter Developer',
          duration: 'March 2023 - Present',
        ),
        Gap(20),
        ExperianceItem(
          companyName: 'Brototype',
          position: 'Flutter Developer Trainee',
          duration: 'December 2022 - December 2023',
        ),
        Gap(70),
      ],
    );
  }
}

class ExperianceItem extends StatelessWidget {
  const ExperianceItem({
    super.key,
    required this.companyName,
    required this.position,
    required this.duration,
  });

  final String companyName;

  final String position;
  final String duration;

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: Adaptive.w(30),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                companyName,
                style: GoogleFonts.ptSans(
                  fontSize: 14.sp,
                ),
              ),
              Gap(10),
              Text(
                position,
                style: GoogleFonts.ptSans(
                  fontSize: 14.sp,
                ),
              ),
              Gap(10),
              Text(
                duration,
                style: GoogleFonts.ptSans(
                  fontSize: 13.sp,
                ),
              ),
              Gap(70),
            ],
          ),
        ),
        // Gap(30),
        Flexible(
          child: Text(
            'As a Flutter Developer, I have built and maintained cross-platform mobile applications for both Android and iOS using Flutter and Dart. My work involves collaborating with designers and backend developers to create responsive, user-friendly interfaces and seamless app experiences. I’ve integrated RESTful APIs, Firebase, and third-party services, while also applying state management solutions like Provider and Riverpod to ensure maintainable code architecture. I follow Agile practices, regularly contribute to code reviews, and handle deployment processes for app store releases. My focus is always on delivering clean, efficient, and scalable code in fast-paced development environments.',
            style: GoogleFonts.ptSans(
              fontSize: 13.sp,
            ),
          ),
        ),
      ],
    );
  }
}

class AboutFirstSection extends StatefulWidget {
  const AboutFirstSection({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  State<AboutFirstSection> createState() => _AboutFirstSectionState();
}

class _AboutFirstSectionState extends State<AboutFirstSection>
    with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  late Animation<Offset> offsetImage;
  late Animation<Offset> transform;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1700),
      reverseDuration: const Duration(milliseconds: 375),
    );

    offsetImage =
        Tween<Offset>(begin: const Offset(-1, 0), end: Offset.zero).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );
    transform = Tween<Offset>(
      begin: const Offset(1, 0),
      end: Offset.zero,
    ).animate(
      CurvedAnimation(
        parent: _controller,
        curve: const Interval(0.0, 1.0, curve: Curves.easeOut),
      ),
    );

    // Start animation only if mounted
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (mounted) {
        _controller.forward();
      }
    });

    // Future.delayed(
    //   Duration(milliseconds: 300),
    //   () {
    //     if (mounted) {

    //     }
    //   },
    // );
  }

  @override
  void dispose() {
    _controller.stop();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Flexible(
          child: SlideTransition(
            position: offsetImage,
            // animation: _controller,
            // builder: (context, child) {
            //   return Transform.translate(
            //     offset: _textSlideAnimation.value * widget.size.width,
            //     child: Opacity(
            //       opacity: _fadeAnimation.value,
            //       child: child,
            //     ),
            //   );
            // },
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Hey there,',
                  style: GoogleFonts.anton(
                    fontSize: 30.sp,
                    letterSpacing: 4,
                    color: Colors.grey.shade800,
                  ),
                ),
                // const Gap(10),
                Text(
                  'I\'m Favad.',
                  textAlign: TextAlign.start,
                  style: GoogleFonts.anton(
                    fontSize: 25.sp,
                    letterSpacing: 5,
                    wordSpacing: 2,
                  ),
                ),
                Gap(40),
                ConstrainedBox(
                  constraints: BoxConstraints(
                    maxWidth: widget.size.width * 0.3,
                  ),
                  child: Text(
                    "I'm a Flutter developer who started as the curious problem-solver, always fascinated by how things work behind the scenes. My passion for design, logic, and seamless user experiences led me to mobile development, where I bring ideas to life through clean, efficient, and responsive applications. With one year of experience, I've honed my skills in building intuitive, scalable apps that delight users. I'm excited for what's next in my journey!",
                    style: GoogleFonts.ptSans(
                      letterSpacing: 1,
                      fontWeight: FontWeight.w400,
                      height: 2,
                    ),
                  ),
                ),
                Gap(25),
                Row(
                  children: [
                    SizedBox(
                      height: 20,
                      width: 20,
                      child: SvgPicture.asset(
                        'Asset/Icons/right-arrow-svgrepo-com.svg',
                        // ignore: deprecated_member_use
                        color: context.isDarkMode ? Colors.white : Colors.black,
                      ),
                    ),
                    const Gap(10),
                    InkWell(
                      onTap: () {},
                      child: Text(
                        'Resume',
                        style: GoogleFonts.ptSans(
                          letterSpacing: 1,
                          fontWeight: FontWeight.w400,
                          height: 2,
                        ),
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
        Flexible(
          child: SlideTransition(
            position: transform,
            // animation: _controller,
            // builder: (context, child) {
            //   return Transform.translate(
            //     offset: _boxSlideAnimation.value * widget.size.width,
            //     child: child,
            //   );
            // },
            child: Container(
              height: 70.h,
              width: Adaptive.w(30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.amber,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
