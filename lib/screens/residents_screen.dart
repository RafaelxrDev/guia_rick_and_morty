import 'package:flutter/material.dart';
import '../models/location.dart';
import '../services/api_service.dart';
import '../models/character.dart';
import '../widgets/character_card.dart';
import 'character_detail_screen.dart';

class ResidentsScreen extends StatefulWidget {
  final LocationModel location;
  const ResidentsScreen({super.key, required this.location});

  @override
  State<ResidentsScreen> createState() => _ResidentsScreenState();
}

class _ResidentsScreenState extends State<ResidentsScreen> {
  bool _loading = true;
  String? _error;
  List<Character> _residents = [];

  @override
  void initState() {
    super.initState();
    _loadResidents();
  }

  Future<void> _loadResidents() async {
    setState(() {
      _loading = true;
      _error = null;
    });

    try {
      // extrair ids dos urls
      final ids =
          widget.location.residents
              .map((url) {
                final parts = url.split('/');
                return int.tryParse(parts.last) ?? 0;
              })
              .where((id) => id > 0)
              .toList();

      if (ids.isEmpty) {
        _residents = [];
      } else {
        _residents = await ApiService.fetchCharactersByIds(ids);
      }
    } catch (e) {
      _error = e.toString();
    } finally {
      setState(() => _loading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(widget.location.name)),
      body:
          _loading
              ? const Center(child: CircularProgressIndicator())
              : _error != null
              ? Center(child: Text('Erro: $_error'))
              : _residents.isEmpty
              ? const Center(child: Text('Nenhum residente listado'))
              : RefreshIndicator(
                onRefresh: _loadResidents,
                child: ListView.builder(
                  itemCount: _residents.length,
                  itemBuilder: (context, index) {
                    final c = _residents[index];
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
    );
  }
}
