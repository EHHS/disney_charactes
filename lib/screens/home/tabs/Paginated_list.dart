import 'package:flutter/material.dart';
import 'package:infinit_task/screens/character_details/character_details.dart';
import 'package:infinit_task/screens/home/home_view_model.dart';
import 'package:provider/provider.dart';

class PaginatedListTab extends StatelessWidget {
  final ScrollController scrollController;
  const PaginatedListTab({super.key, required this.scrollController});

  @override
  Widget build(BuildContext context) {
    return Consumer<PaginationProvider>(
      builder: (context, provider, child) {
        return ListView.separated(
          controller: scrollController,
          itemCount:
              provider.characters.length + (provider.hasMoreData ? 1 : 0),
          itemBuilder: (context, index) {
            if (index < provider.characters.length) {
              final item = provider.characters[index];
              return ListTile(
                title: Text(
                  item.name,
                  style: const TextStyle(fontWeight: FontWeight.bold),
                ),
                subtitle: Text(item.id.toString()),
                trailing: item.imageUrl != null && item.imageUrl!.isNotEmpty
                    ? Image.network(
                        item.imageUrl!,
                        width: 50,
                        height: 50,
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) =>
                            const Icon(Icons.image_not_supported, size: 50),
                      )
                    : const Icon(Icons.image_not_supported, size: 50),
                onTap: () {
                  Navigator.of(context).pushNamed(
                    CharacterDetailScreen.routeName,
                    arguments: item,
                  );
                },
              );
            } else {
              return provider.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : const SizedBox.shrink();
            }
          },
          separatorBuilder: (context, index) => const Divider(),
        );
      },
    );
  }
}
