import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:pokemon_app/pages/home_page.dart';
import 'package:get_it/get_it.dart';
import 'package:pokemon_app/services/database_service.dart';
import 'package:pokemon_app/services/http_service.dart';

Future<void> _initServices() async {
  GetIt.instance.registerSingleton<HttpService>(HttpService());
  GetIt.instance.registerSingleton<DatabaseService>(DatabaseService());
}

Future<void> main() async {
  await _initServices();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'PokeDex',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.lightGreen),
          useMaterial3: true,
          textTheme: GoogleFonts.aBeeZeeTextTheme()
        ),
        home: HomePage()
      ),
    );
  }
}
