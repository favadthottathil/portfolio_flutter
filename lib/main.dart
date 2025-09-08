import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/Features/change%20tab/tab_bloc.dart';
import 'package:portfolio/Features/switch_theme/switch_theme_bloc.dart';
import 'package:portfolio/Routes/route_config.dart';
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
        BlocProvider(
          create: (context) => ThemeBloc(),
        )
      ],
      child: Sizer(builder: (context, orientation, screenType) { // 
        return BlocBuilder<ThemeBloc, ThemeState>(
          
          builder: (context, state) {
            return MaterialApp.router(
              debugShowCheckedModeBanner: false,
              routerConfig: RouteConfig.returnRouter(),  // 
              theme: state.themeData,
            );
          }
        );
      }),
    );
  }
}
