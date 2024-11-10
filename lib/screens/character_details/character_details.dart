import 'package:flutter/material.dart';
import 'package:infinit_task/models/character.dart';
import 'package:url_launcher/url_launcher.dart';

class CharacterDetailScreen extends StatelessWidget {
  static const String routeName = '/character-details';
  final Character character;

  const CharacterDetailScreen({super.key, required this.character});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(character.name)),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            // Character Image
            ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child:
                  character.imageUrl != null && character.imageUrl!.isNotEmpty
                      ? Image.network(
                          character.imageUrl!,
                          width: double.infinity,
                          height: 250,
                          fit: BoxFit.cover,
                          errorBuilder: (context, error, stackTrace) =>
                              const Icon(Icons.image_not_supported, size: 100),
                        )
                      : const Icon(Icons.image_not_supported, size: 100),
            ),
            const SizedBox(height: 16),
            Text(
              character.name,
              style: const TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 8),
            Text('ID: ${character.id}'),
            const SizedBox(height: 16),
            const Text(
              'Films:',
              style: TextStyle(fontWeight: FontWeight.bold,fontSize: 20),
            ),
            ...(character.films ?? []).map(Text.new),
            const SizedBox(height: 16),
            const Text(
              'TV Shows:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ...(character.tvShows ?? []).map(Text.new),
            const SizedBox(height: 16),
            const Text(
              'Video Games:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ...(character.videoGames ?? []).map(Text.new),
            const SizedBox(height: 16),
            const Text(
              'Park Attractions:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
            ),
            ...(character.parkAttractions ?? []).map(Text.new),
            const SizedBox(height: 16),
            TextButton(
              onPressed: () {
                if (character.sourceUrl != null) {
                  launch(character.sourceUrl!);
                }
              },
              child: const Text('Learn More'),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> launch(String url) async {
    if (await canLaunchUrl(Uri.parse(url))) {
      launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
