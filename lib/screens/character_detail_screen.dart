import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../models/character.dart';
import '../services/api_service.dart';
import '../providers/favorites_provider.dart';

class CharacterDetailScreen extends StatefulWidget {
  final int characterId;
  const CharacterDetailScreen({super.key, required this.characterId});

  @override
  State<CharacterDetailScreen> createState() => _CharacterDetailScreenState();
}

class _CharacterDetailScreenState extends State<CharacterDetailScreen> {
  Character? _character;
  bool _loading = true;
  String? _error;

  @override
  void initState() {
    super.initState();
    _loadCharacter();
  }

  Future<void> _loadCharacter() async {
    setState(() {
      _loading = true;
      _error = null;
    });
    try {
      final c = await ApiService.fetchCharacterById(widget.characterId);
      setState(() {
        _character = c;
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
      appBar: AppBar(title: const Text('Detalhes')),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Erro: $_error'))
              : _character == null
              ? const Center(child: Text('Personagem não encontrado'))
              : SingleChildScrollView(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(12),
                      child: Image.network(
                        _character!.image,
                        height: 260,
                        fit: BoxFit.cover,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _character!.name,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Wrap(
                      spacing: 8,
                      children: [
                        _chip('${_character!.status}'),
                        _chip('${_character!.species}'),
                        _chip('${_character!.gender}'),
                      ],
                    ),
                    const SizedBox(height: 12),
                    ListTile(
                      title: const Text('Origem'),
                      subtitle: Text(_character!.originName),
                    ),
                    ListTile(
                      title: const Text('Localização'),
                      subtitle: Text(_character!.locationName),
                    ),
                    const SizedBox(height: 12),
                    ElevatedButton.icon(
                      onPressed:
                          () => favProvider.toggleFavorite(_character!.id),
                      icon: Icon(
                        favProvider.isFavorite(_character!.id)
                            ? Icons.favorite
                            : Icons.favorite_border,
                      ),
                      label: Text(
                        favProvider.isFavorite(_character!.id)
                            ? 'Remover dos favoritos'
                            : 'Adicionar aos favoritos',
                      ),
                    ),
                  ],
                ),
              ),
    );
  }

  Widget _chip(String label) => Chip(label: Text(label));
}
