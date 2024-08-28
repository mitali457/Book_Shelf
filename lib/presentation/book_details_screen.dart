import 'package:bookshelf/presentation/add_book.dart';
import 'package:bookshelf/presentation/edit_book.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookshelf/application/book_details/book_details_bloc/book_details_bloc.dart';

class BookDetailScreen extends StatelessWidget {
  const BookDetailScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Book Details'),
        centerTitle: true,
        actions: [
          IconButton(
            icon: const Icon(Icons.edit),
            onPressed: () async {
              final bookToEdit =
                  context.read<BookDetailsBloc>().state.allBooks.first;
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => EditBookScreen(book: bookToEdit),
                ),
              );
            },
          ),
          IconButton(
            icon: const Icon(Icons.delete),
            onPressed: () async {
              final bookToDelete =
                  context.read<BookDetailsBloc>().state.allBooks.first;
              final confirmDelete = await showDialog(
                context: context,
                builder: (BuildContext context) => AlertDialog(
                  title: const Text('Delete Book'),
                  content: Text(
                      'Are you sure you want to delete "${bookToDelete.title}"?'),
                  actions: <Widget>[
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(true),
                      child: const Text('Delete'),
                    ),
                    TextButton(
                      onPressed: () => Navigator.of(context).pop(false),
                      child: const Text('Cancel'),
                    ),
                  ],
                ),
              );
              if (confirmDelete == true) {
                // ignore: use_build_context_synchronously
                context
                    .read<BookDetailsBloc>()
                    .add(BookDetailsEvent.delete(bookToDelete.id!));
              }
            },
          ),
        ],
      ),
      body: BlocBuilder<BookDetailsBloc, BookDetailsState>(
        builder: (context, state) {
          if (state.isFetching) {
            return const Center(child: CircularProgressIndicator());
          }
          if (state.allBooks.isEmpty) {
            return const Center(child: Text('No books available'));
          }
          return Padding(
            padding: const EdgeInsets.all(16.0),
            child: ListView.builder(
              itemCount: state.allBooks.length,
              itemBuilder: (context, index) {
                final book = state.allBooks[index];
                return ListTile(
                  title: Text(
                    book.title,
                    style: const TextStyle(fontSize: 18),
                  ),
                  subtitle: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Author: ${book.publisher}',
                        style: const TextStyle(fontSize: 16),
                      ),
                      Text(
                        'Published Year: ${book.year}',
                        style: const TextStyle(fontSize: 16),
                      ),
                    ],
                  ),
                  onTap: () {
                    // Navigate to the book detail or edit screen
                  },
                );
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AddBookScreen()),
          );
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
