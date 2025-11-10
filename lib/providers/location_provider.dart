import 'package:flutter/material.dart';
import '../models/location.dart';
import '../services/api_service.dart';

class LocationProvider extends ChangeNotifier {
  List<LocationModel> _locations = [];
  int _page = 1;
  bool _isFetching = false;
  bool _hasMore = true;
  String? _error;

  List<LocationModel> get locations => _locations;
  bool get isFetching => _isFetching;
  bool get hasMore => _hasMore;
  String? get error => _error;

  Future<void> fetchInitial() async {
    _locations = [];
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
      final data = await ApiService.fetchLocations(page: _page);
      final results =
          (data['results'] as List)
              .map((e) => LocationModel.fromJson(e as Map<String, dynamic>))
              .toList();
      _locations.addAll(results);

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
