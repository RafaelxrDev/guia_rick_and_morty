import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/favorites_provider.dart';
import '../services/api_service.dart';
import '../models/character.dart';
import 'character_detail_screen.dart';
import '../widgets/character_card.dart';

class FavoritesScreen extends StatefulWidget {
  const FavoritesScreen({super.key});

  @override
  State<FavoritesScreen> createState() => _FavoritesScreenState();
}

class _FavoritesScreenState extends State<FavoritesScreen> {
  List<Character> _favs = [];
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadFavorites();
  }

  Future<void> _loadFavorites() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      final favIds =
          Provider.of<FavoritesProvider>(
            context,
            listen: false,
          ).favorites.toList();
      final results = await ApiService.fetchCharactersByIds(favIds);
      setState(() {
        _favs = results;
      });
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final favProvider = Provider.of<FavoritesProvider>(context);
    return Scaffold(
      appBar: AppBar(title: const Text('Favoritos')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Erro: $_error'))
              : _favs.isEmpty
              ? const Center(child: Text('Nenhum favorito'))
              : RefreshIndicator(
                onRefresh: _loadFavorites,
                child: ListView.builder(
                  itemCount: _favs.length,
                  itemBuilder: (context, index) {
                    final c = _favs[index];
                    return CharacterCard(
                      character: c,
                      onTap:
                          () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder:
                                  (_) =>
                                      CharacterDetailScreen(characterId: c.id),
                            ),
                          ),
                    );
                  },
                ),
              ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          // refresh
          await _loadFavorites();
        },
        child: const Icon(Icons.refresh),
      ),
    );
  }
}
