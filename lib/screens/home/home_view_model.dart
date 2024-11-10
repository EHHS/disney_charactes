import 'package:flutter/material.dart';
import 'package:infinit_task/models/character.dart';
import 'package:infinit_task/models/paginated_info.dart';
import 'package:infinit_task/repository/character.dart';

class PaginationProvider with ChangeNotifier {
  final CharacterRepository characterRepository;

  PaginationProvider({required this.characterRepository});

  final List<Character> _characters = [];
  bool _isLoading = false;
  int _currentPage = 1;
  final int _pageSize = 20;
  bool _hasMoreData = true;
  String _searchQuery = '';
  PaginationInfo? _paginationInfo;

  List<Character> get characters => _characters;
  bool get isLoading => _isLoading;
  bool get hasMoreData => _hasMoreData;
  PaginationInfo? get paginationInfo => _paginationInfo;

  void setSearchQuery(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _characters.clear();
    _hasMoreData = true;
    fetchCharacters();
  }

  // Fetch characters based on current page and search query
  Future<void> fetchCharacters() async {
    if (_isLoading || (!_hasMoreData && _searchQuery.isEmpty)) return;

    _isLoading = true;
    notifyListeners();

    try {
      final data = await characterRepository.fetchCharacters(_searchQuery, _currentPage, _pageSize);

      // Parse pagination info
      _paginationInfo = PaginationInfo.fromJson(data['info']);

      // Parse character data and add to list
      List<Character> newCharacters = (data['data'] as List)
          .map((item) => Character.fromJson(item))
          .toList();
      _characters.addAll(newCharacters);

      // Update the page count and check if there is more data
      _currentPage++;
      _hasMoreData = _currentPage <= _paginationInfo!.totalPages;
    } catch (e) {
      print('Error fetching characters: $e');
    } finally {
      _isLoading = false;
      notifyListeners();
    }
  }
}
