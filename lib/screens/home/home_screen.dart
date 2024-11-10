import 'package:flutter/material.dart';
import 'package:infinit_task/repository/character.dart';
import 'package:infinit_task/screens/home/home_view_model.dart';
import 'package:infinit_task/screens/home/tabs/Paginated_list.dart';
import 'package:infinit_task/screens/home/tabs/dashboard.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = '/home';

  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen>
    with SingleTickerProviderStateMixin {
  late ScrollController _scrollController;
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    _scrollController.addListener(() {
      if (_scrollController.position.pixels >=
          _scrollController.position.maxScrollExtent) {
        Provider.of<PaginationProvider>(context, listen: false)
            .fetchCharacters();
      }
    });

    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaginationProvider>(context, listen: false).fetchCharacters();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Home'),
          bottom: const TabBar(
            tabs: [
              Tab(icon: Icon(Icons.list), text: 'List'),
              Tab(icon: Icon(Icons.dashboard), text: 'Dashboard'),
            ],
          ),
          actions: [
            IconButton(
              icon: const Icon(Icons.search),
              onPressed: () {
                showSearch(
                  context: context,
                  delegate: CharacterSearchDelegate(),
                );
              },
            ),
          ],
        ),
        body: Consumer<PaginationProvider>(
          builder: (context, provider, child) {
            return TabBarView(
              children: [
                PaginatedListTab(scrollController: _scrollController),
                const DashboardTab(),
              ],
            );
          },
        ),
      ),
    );
  }
}

class CharacterSearchDelegate extends SearchDelegate {
  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () {
          query = '';
          showSuggestions(context);
        },
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<PaginationProvider>(context, listen: false)
          .setSearchQuery(query);
    });

    return Consumer<PaginationProvider>(
      builder: (context, provider, child) {
        return ListView.builder(
          itemCount: provider.characters.length,
          itemBuilder: (context, index) {
            final item = provider.characters[index];
            return ListTile(
              title: Text(item.name),
              subtitle: Text(item.id.toString()),
              trailing: item.imageUrl != null && item.imageUrl!.isNotEmpty
                  ? Image.network(
                      item.imageUrl!,
                      width: 50,
                      height: 50,
                      fit: BoxFit.cover,
                    )
                  : const Icon(Icons.image_not_supported, size: 50),
            );
          },
        );
      },
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return const Center(child: Text('Start typing to search...'));
  }
}
