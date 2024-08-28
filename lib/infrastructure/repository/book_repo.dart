import 'package:bookshelf/domain/entities/books.dart';
import 'package:bookshelf/domain/error/api_failure.dart';
import 'package:bookshelf/domain/error/failure_handler.dart';
import 'package:bookshelf/domain/repository/i_book_repo.dart';
import 'package:bookshelf/infrastructure/datasource/book_remote.dart';
import 'package:bookshelf/utils/database_helper.dart';
import 'package:dartz/dartz.dart';

class BookRepository extends IBookRepository {
  final BookRemoteDatasource remoteDataSource;
  BookRepository({
    required this.remoteDataSource,
  });
  @override
  Future<Either<ApiFailure, List<Book>>> fetchBooks() async {
    try {
      final event = await remoteDataSource.fetchBooks();
      return Right(event);
    } catch (e) {
      return Left(FailureHandler.handleFailure(e));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> addBook(Book book) async {
    try {
      await DatabaseHelper.insertBook(book);
      return const Right(unit);
    } catch (e) {
      return Left(ApiFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> updateBook(Book book) async {
    try {
      await DatabaseHelper.updateBook(book);
      return const Right(unit);
    } catch (e) {
      return Left(ApiFailure.serverError(e.toString()));
    }
  }

  @override
  Future<Either<ApiFailure, Unit>> deleteBook(int id) async {
    try {
      await DatabaseHelper.deleteBook(id);
      return const Right(unit);
    } catch (e) {
      return Left(ApiFailure.serverError(e.toString()));
    }
  }
}
