import 'package:brik_test/features/product/presentation/bloc/product_bloc.dart';
import 'package:brik_test/features/product/presentation/pages/product_screen.dart';
import 'package:brik_test/injection_container.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  bool isDark = false;

  void _toggleDarkMode() {
    setState(() {
      isDark = !isDark;
    });
  }

  @override
  Widget build(BuildContext context) {
    final themeData = ThemeData(
      useMaterial3: true,
      textTheme: GoogleFonts.latoTextTheme(),
      brightness: isDark ? Brightness.dark : Brightness.light,
    );

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => sl<ProductBloc>()),
      ],
      child: MaterialApp(
        theme: themeData,
        home: ProductScreen(onChangeDarkMode: _toggleDarkMode),
      ),
    );
  }
}
