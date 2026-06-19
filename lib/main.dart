import 'dart:ui';
import 'package:portfolio/views/screen/home_screen.dart';

import 'core/theme/app_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:portfolio/providers/theme/theme_provider.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized(); // Safety initialization binding
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final themeMode = ref.watch(themeProvider);

    return MaterialApp(
      key: const ValueKey('rahul-portfolio-root-app-engine'),
      debugShowCheckedModeBanner: false,
      title: 'Rahul Kumar Sah • Flutter Developer',
      themeMode: themeMode,
      theme: AppTheme.lightTheme,
      darkTheme: AppTheme.darkTheme,
      home:  HomeScreen(),
      scrollBehavior: const MaterialScrollBehavior().copyWith(
        scrollbars: false,
        dragDevices: {
          PointerDeviceKind.mouse,
          PointerDeviceKind.touch,
          PointerDeviceKind.trackpad,
        },
      ),
    );
  }
}