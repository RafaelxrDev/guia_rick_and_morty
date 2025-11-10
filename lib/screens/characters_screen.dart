import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/character_provider.dart';
import '../providers/favorites_provider.dart';
import '../widgets/character_card.dart';
import 'character_detail_screen.dart';

class CharactersScreen extends StatefulWidget {
  const CharactersScreen({super.key});

  @override
  State<CharactersScreen> createState() => _CharactersScreenState();
}

class _CharactersScreenState extends State<CharactersScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<CharacterProvider>(context, listen: false);
    provider.fetchInitial();

    _controller.addListener(() {
      if (_controller.position.pixels >
          _controller.position.maxScrollExtent - 200) {
        provider.fetchNext();
      }
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Personagens')),
      body: Consumer<CharacterProvider>(
        builder: (context, provider, _) {
          if (provider.isFetching && provider.characters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null && provider.characters.isEmpty) {
            return Center(child: Text('Erro: ${provider.error}'));
          }

          return RefreshIndicator(
            onRefresh: provider.fetchInitial,
            child: ListView.builder(
              controller: _controller,
              itemCount:
                  provider.characters.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.characters.length) {
                  // loading indicator for next page
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final c = provider.characters[index];
                return CharacterCard(
                  character: c,
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder:
                            (_) => CharacterDetailScreen(characterId: c.id),
                      ),
                    );
                  },
                );
              },
            ),
          );
        },
      ),
    );
  }
}
