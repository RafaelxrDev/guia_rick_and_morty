import 'package:flutter/material.dart';
import 'characters_screen.dart';
import 'locations_screen.dart';
import 'favorites_screen.dart';
import '../utils/transition.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true, // Faz o fundo cobrir até atrás do AppBar
      appBar: AppBar(
        title: const Text(
          'Guia Rick and Morty',
          style: TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
            shadows: [
              Shadow(
                offset: Offset(2, 2),
                blurRadius: 4,
                color: Colors.black54,
              ),
            ],
          ),
        ),
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: Container(
        decoration: const BoxDecoration(
          image: DecorationImage(
            image: AssetImage('assets/images/bg_space.jpg'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          // camada escura semi-transparente pra melhorar contraste
          color: Colors.black54.withOpacity(0.4),
          padding: const EdgeInsets.all(20),
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  'Explore personagens e locais do universo de Rick and Morty!',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 18,
                    color: Colors.white,
                    fontWeight: FontWeight.w500,
                    shadows: [
                      Shadow(
                        offset: Offset(2, 2),
                        blurRadius: 4,
                        color: Colors.black87,
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 40),

                // --- Botão 1 ---
                _buildButton(
                  context,
                  label: 'Personagens',
                  onTap:
                      () => Navigator.of(
                        context,
                      ).push(createRoute(const CharactersScreen())),
                ),

                const SizedBox(height: 16),

                // --- Botão 2 ---
                _buildButton(
                  context,
                  label: 'Locais',
                  onTap:
                      () => Navigator.of(
                        context,
                      ).push(createRoute(const LocationsScreen())),
                ),

                const SizedBox(height: 16),

                // --- Botão 3 ---
                _buildButton(
                  context,
                  label: 'Favoritos',
                  onTap:
                      () => Navigator.of(
                        context,
                      ).push(createRoute(const FavoritesScreen())),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  // 🔘 Função auxiliar para deixar os botões com o mesmo estilo
  Widget _buildButton(
    BuildContext context, {
    required String label,
    required VoidCallback onTap,
  }) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.tealAccent.shade400,
          foregroundColor: Colors.black87,
          padding: const EdgeInsets.symmetric(vertical: 14),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          elevation: 6,
          shadowColor: Colors.tealAccent,
        ),
        onPressed: onTap,
        child: Text(
          label,
          style: const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            letterSpacing: 1.1,
          ),
        ),
      ),
    );
  }
}
