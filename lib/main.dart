import 'package:flutter/material.dart';
import 'package:infinit_task/repository/character.dart';
import 'package:infinit_task/routes.dart';
import 'package:infinit_task/screens/home/home_screen.dart';
import 'package:infinit_task/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) =>
              PaginationProvider(characterRepository: CharacterRepository()),
        ),
      ],
      builder: (context, state) {
        return MaterialApp(
          title: 'Flutter Demo',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
            useMaterial3: true,
          ),
          home: const HomeScreen(),
          routes: routes,
        );
      },
    );
  }
}
