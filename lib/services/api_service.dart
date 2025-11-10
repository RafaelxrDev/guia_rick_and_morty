import 'dart:convert';
import 'package:http/http.dart' as http;
import '../utils/constants.dart';
import '../models/character.dart';
import '../models/location.dart';

class ApiService {
  // Characters (paginated)
  static Future<Map<String, dynamic>> fetchCharacters({int page = 1}) async {
    final uri = Uri.parse('$apiBase/character?page=$page');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Erro ao buscar personagens (${res.statusCode})');
    }
  }

  static Future<Character> fetchCharacterById(int id) async {
    final uri = Uri.parse('$apiBase/character/$id');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return Character.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Erro ao buscar personagem $id');
    }
  }

  // Batch fetch characters by list of ids (e.g. /character/1,2,3)
  static Future<List<Character>> fetchCharactersByIds(List<int> ids) async {
    if (ids.isEmpty) return [];
    final idPart = ids.join(',');
    final uri = Uri.parse('$apiBase/character/$idPart');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      final decoded = jsonDecode(res.body);
      if (decoded is List) {
        return (decoded as List)
            .map((e) => Character.fromJson(e as Map<String, dynamic>))
            .toList();
      } else {
        // single object
        return [Character.fromJson(decoded as Map<String, dynamic>)];
      }
    } else {
      throw Exception('Erro ao buscar personagens por ids');
    }
  }

  // Locations (paginated)
  static Future<Map<String, dynamic>> fetchLocations({int page = 1}) async {
    final uri = Uri.parse('$apiBase/location?page=$page');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return jsonDecode(res.body) as Map<String, dynamic>;
    } else {
      throw Exception('Erro ao buscar locais (${res.statusCode})');
    }
  }

  static Future<LocationModel> fetchLocationById(int id) async {
    final uri = Uri.parse('$apiBase/location/$id');
    final res = await http.get(uri);
    if (res.statusCode == 200) {
      return LocationModel.fromJson(jsonDecode(res.body));
    } else {
      throw Exception('Erro ao buscar local $id');
    }
  }
}
