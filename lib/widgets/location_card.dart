import 'package:flutter/material.dart';
import '../models/location.dart';

class LocationCard extends StatelessWidget {
  final LocationModel location;
  final VoidCallback? onTap;

  const LocationCard({super.key, required this.location, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      child: ListTile(
        onTap: onTap,
        title: Text(location.name),
        subtitle: Text(location.type),
        trailing: const Icon(Icons.chevron_right),
      ),
    );
  }
}
