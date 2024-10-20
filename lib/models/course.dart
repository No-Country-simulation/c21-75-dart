import 'dart:convert';
import 'package:http/http.dart' as http;

class Course {
  final String id;
  final String title;
  final String summary;
  final List<String> levels;
  final List<String> roles;
  final List<String> products;
  final int durationInMinutes;
  final double rating;
  final int ratingCount;
  final double popularity;
  final String iconUrl;
  final String url;

  // Constructor principal
  Course({
    required this.id,
    required this.title,
    required this.summary,
    required this.levels,
    required this.roles,
    required this.products,
    required this.durationInMinutes,
    required this.rating,
    required this.ratingCount,
    required this.popularity,
    required this.iconUrl,
    required this.url,
  });

  // Factory para crear un objeto desde JSON
  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['uid'] ?? '',
      title: json['title'] ?? 'Sin título',
      summary: json['summary'] ?? 'Sin descripción',
      levels: List<String>.from(json['levels'] ?? []),
      roles: List<String>.from(json['roles'] ?? []),
      products: List<String>.from(json['products'] ?? []),
      durationInMinutes: json['duration_in_minutes'] ?? 0,
      rating: (json['rating']?['average'] ?? 0.0).toDouble(),
      ratingCount: json['rating']?['count'] ?? 0,
      popularity: (json['popularity'] ?? 0.0).toDouble(),
      iconUrl: json['icon_url'] ?? '',
      url: json['url'] ?? '',
    );
  }

  // Método para obtener cursos desde la API
  static Future<List<Course>> fetchCourses() async {
    const String apiUrl = 'https://learn.microsoft.com/api/catalog/';

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final List<dynamic> modules = jsonDecode(response.body)['modules'];
      return modules.map((json) => Course.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los cursos');
    }
  }

  // Método factory de prueba para desarrollo
  factory Course.test() {
    return Course(
      id: 'test-id',
      title: 'Curso de Prueba',
      summary: 'Este es un curso de ejemplo para pruebas internas.',
      levels: ['intermediate'],
      roles: ['administrator'],
      products: ['windows', 'intune'],
      durationInMinutes: 48,
      rating: 4.5,
      ratingCount: 42,
      popularity: 0.8,
      iconUrl:
          'https://learn.microsoft.com/en-us/training/achievements/generic-badge.svg',
      url: 'https://learn.microsoft.com/test-url',
    );
  }
}
