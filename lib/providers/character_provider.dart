import 'package:flutter/material.dart';
import '../models/character.dart';
import '../services/api_service.dart';

class CharacterProvider extends ChangeNotifier {
  List<Character> _characters = [];
  int _page = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  String? _error;

  List<Character> get characters => _characters;
  bool get isFetching => _isFetching;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> fetchInitial() async {
    _characters = [];
    _page = 1;
    _hasMore = true;
    await fetchNext();
  }

  Future<void> fetchNext() async {
    if (!_hasMore || _isFetching) return;
    _isFetching = true;
    _error = null;
    notifyListeners();

    try {
      final data = await ApiService.fetchCharacters(page: _page);
      final results =
          (data['results'] as List)
              .map((e) => Character.fromJson(e as Map<String, dynamic>))
              .toList();
      _characters.addAll(results);

      // next page check
      final info = data['info'] as Map<String, dynamic>?;
      if (info == null || info['next'] == null) {
        _hasMore = false;
      } else {
        _page++;
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      _isFetching = false;
      notifyListeners();
    }
  }
}
