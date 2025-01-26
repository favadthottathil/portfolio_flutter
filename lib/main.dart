import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/Features/change%20tab/tab_bloc.dart';
import 'package:portfolio/Routes/route_config.dart';
import 'package:portfolio/core/theme/theme.dart';
import 'package:portfolio/models/scroll_offset.dart';
import 'package:sizer/sizer.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => DisplayOffset(
            ScrollOffset(scrollOffsetValue: 0),
          ),
        ),
        BlocProvider(
          create: (context) => TabBloc(),
        ),
      ],
      child: Sizer(builder: (context, orientation, screenType) {
        return MaterialApp.router(
          debugShowCheckedModeBanner: false,
          routerConfig: RouteConfig.returnRouter(),
          theme: AppTheme.dartkThemeMode,
        );
      }),
    );
  }
}
