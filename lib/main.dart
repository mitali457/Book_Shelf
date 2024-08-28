import 'package:bookshelf/application/book_details/book_details_bloc/book_details_bloc.dart';
import 'package:bookshelf/infrastructure/datasource/book_remote.dart';
import 'package:bookshelf/infrastructure/repository/book_repo.dart';
import 'package:bookshelf/presentation/book_details_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

void main() async {
  runApp(const BookPage());
}

class BookPage extends StatelessWidget {
  const BookPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<BookDetailsBloc>(
        create: (context) => BookDetailsBloc(
                repository: BookRepository(
              remoteDataSource: BookRemoteDatasource(),
            ))
              ..add(const BookDetailsEvent.fetch()),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Book Shelf',
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(seedColor: Colors.amber),
            useMaterial3: true,
          ),
          home: const BookDetailScreen(),
        ));
  }
}
