import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'locations_screen.dart';
import 'favorites_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Guia Rick and Morty')),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            const Text(
              'Explore personagens e locais do universo de Rick and Morty.',
              style: TextStyle(fontSize: 16),
            ),
            const SizedBox(height: 24),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const CharactersScreen()),
                  ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('Personagens')),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const LocationsScreen()),
                  ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('Locais')),
              ),
            ),
            const SizedBox(height: 12),
            ElevatedButton(
              onPressed:
                  () => Navigator.push(
                    context,
                    MaterialPageRoute(builder: (_) => const FavoritesScreen()),
                  ),
              child: const SizedBox(
                width: double.infinity,
                child: Center(child: Text('Favoritos')),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
