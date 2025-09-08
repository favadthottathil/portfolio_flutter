import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:gap/gap.dart';
import 'package:get/utils.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/Constants/font_family_constant.dart';
import 'package:portfolio/Features/change%20tab/tab_bloc.dart';
import 'package:portfolio/Features/change%20tab/tab_event.dart';
import 'package:portfolio/Features/change%20tab/tab_state.dart';
import 'package:portfolio/Features/switch_theme/switch_theme_bloc.dart';
import 'package:portfolio/Routes/route_name.dart';
import 'package:sizer/sizer.dart';

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
    return AppBar(
      size: size,
    );
  }
}

class AppBar extends StatelessWidget {
  const AppBar({
    super.key,
    required this.size,
  });

  final Size size;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        const Gap(10),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Column(
              children: [
                Gap(15),
                Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Align(
                      alignment: Alignment.bottomCenter,
                      child: Text(
                        'Favad',
                        style: TextStyle(
                          fontFamily: FontFamily.appBarFont,
                          fontSize: 15.sp,
                        ),
                      ),
                    ),
                    const Gap(20),
                    BlocBuilder<ThemeBloc, ThemeState>(
                      builder: (context, state) {
                        return Transform.scale(
                          scale: 0.8,
                          child: Switch.adaptive(
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            trackOutlineColor:
                                WidgetStateProperty.all(Colors.grey),
                            value:
                                state.themeData.brightness == Brightness.dark,
                            activeTrackColor: Colors.grey,
                            inactiveTrackColor: Colors.grey,
                            activeColor: Colors.white,
                            inactiveThumbColor: Colors.white,
                            thumbIcon:
                                WidgetStateProperty.resolveWith((states) {
                              return context.isDarkMode
                                  ? Icon(
                                      Icons.dark_mode_outlined,
                                      size: 16,
                                      color: Colors.grey.shade800,
                                    )
                                  : Icon(
                                      Icons.light_mode_outlined,
                                      size: 16,
                                      color: Colors.grey.shade800,
                                    );
                            }),
                            padding: EdgeInsets.symmetric(vertical: 20),
                            onChanged: (value) {
                              BlocProvider.of<ThemeBloc>(context).add(
                                ThemeChanged(value),
                              );
                            },
                          ), //
                        );
                      },
                    ),
                    const Gap(10),
                  ],
                ),
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
                    text: 'Work',
                    isSeletedTab: currentIndex == 0,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(0));
                      if (GoRouter.of(context)
                              .routeInformationProvider
                              .value
                              .location !=
                          RouteNames.initial) {
                        context.pushReplacementNamed(RouteNames.initial);
                      }
                    },
                  ),
                  Gap(40),
                  AppBarOptions(
                    text: 'Resume ',
                    isSeletedTab: currentIndex == 1,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(1));
                    },
                  ),
                  Gap(40),
                  AppBarOptions(
                    text: 'About',
                    isSeletedTab: currentIndex == 2,
                    ontap: () {
                      context.read<TabBloc>().add(TabChanged(2));
                      context.goNamed(RouteNames.aboutscreen);
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
              color: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white
                  : Colors.black,
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
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
