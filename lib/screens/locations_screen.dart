import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/location_provider.dart';
import '../widgets/location_card.dart';
import 'residents_screen.dart';

class LocationsScreen extends StatefulWidget {
  const LocationsScreen({super.key});

  @override
  State<LocationsScreen> createState() => _LocationsScreenState();
}

class _LocationsScreenState extends State<LocationsScreen> {
  final ScrollController _controller = ScrollController();

  @override
  void initState() {
    super.initState();
    final provider = Provider.of<LocationProvider>(context, listen: false);
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
      appBar: AppBar(title: const Text('Locais')),
      body: Consumer<LocationProvider>(
        builder: (context, provider, _) {
          if (provider.isFetching && provider.locations.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }
          if (provider.error != null && provider.locations.isEmpty) {
            return Center(child: Text('Erro: ${provider.error}'));
          }

          return RefreshIndicator(
            onRefresh: provider.fetchInitial,
            child: ListView.builder(
              controller: _controller,
              itemCount: provider.locations.length + (provider.hasMore ? 1 : 0),
              itemBuilder: (context, index) {
                if (index >= provider.locations.length) {
                  return const Padding(
                    padding: EdgeInsets.symmetric(vertical: 16),
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                final l = provider.locations[index];
                return LocationCard(
                  location: l,
                  onTap: () {
                    // extrair id
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (_) => ResidentsScreen(location: l),
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
