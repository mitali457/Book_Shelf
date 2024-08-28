
import 'package:bookshelf/domain/entities/books.dart';
import 'package:bookshelf/domain/error/api_failure.dart';
import 'package:dartz/dartz.dart';

abstract class IBookRepository {
  Future<Either<ApiFailure, List<Book>>> fetchBooks();
  Future<Either<ApiFailure, Unit>> addBook(Book book);
  Future<Either<ApiFailure, Unit>> updateBook(Book book);
  Future<Either<ApiFailure, Unit>> deleteBook(int id);
}
