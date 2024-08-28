import 'package:bookshelf/domain/entities/books.dart';
import 'package:dio/dio.dart';

class BookRemoteDatasource {
  final String baseUrl = 'https://stephen-king-api.onrender.com/api';
  final dio = Dio();

  Future<List<Book>> fetchBooks() async {
    final response = await dio.get('$baseUrl/books');
    if (response.statusCode == 200) {
      final jsonResponse = response.data as Map<String, dynamic>?;
      final books = (jsonResponse?['data'] ?? []) as List<dynamic>;

      return books
          .map((book) => Book.fromMap(book as Map<String, dynamic>))
          .toList();
    } else {
      throw Exception('Failed to load books');
    }
  }
}
