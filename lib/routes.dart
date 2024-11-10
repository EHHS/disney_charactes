import 'package:flutter/material.dart';
import 'package:infinit_task/models/character.dart';
import 'package:infinit_task/screens/character_details/character_details.dart';
import 'package:infinit_task/screens/home/home_screen.dart';

Map<String, WidgetBuilder> routes = {
  HomeScreen.routeName: (context) => const HomeScreen(),
  CharacterDetailScreen.routeName: (context) {
    return CharacterDetailScreen(
      character: ModalRoute.of(context)!.settings.arguments! as Character,
    );
  },
};
