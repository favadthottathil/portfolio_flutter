import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:portfolio/Routes/route_name.dart';
import 'package:portfolio/Screens/about_screen.dart';
import 'package:portfolio/Screens/home_screen.dart';

class RouteConfig {
  static GoRouter returnRouter() {
    return GoRouter(
      initialLocation: '/',
      routes: [
        GoRoute(
          path: '/',
          name: RouteNames.initial,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: HomeScreen(),
            );
          },
        ),
        GoRoute(
          path: '/screen1',
          name: RouteNames.screen1,
          pageBuilder: (context, state) {
            return const MaterialPage(
              child: AboutScreen(),
            );
          },
        )
      ],
    );
  }
}
