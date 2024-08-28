import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookshelf/application/book_details/book_details_bloc/book_details_bloc.dart';
import 'package:bookshelf/domain/entities/books.dart';

class AddBookScreen extends StatefulWidget {
  const AddBookScreen({super.key});

  @override
  // ignore: library_private_types_in_public_api
  _AddBookScreenState createState() => _AddBookScreenState();
}

class _AddBookScreenState extends State<AddBookScreen> {
  final _titleController = TextEditingController();
  final _publisherController = TextEditingController();
  final _yearController = TextEditingController();
  final _isbnController = TextEditingController();
  final _pagesController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add New Book'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            TextField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: _publisherController,
              decoration: const InputDecoration(labelText: 'Publisher'),
            ),
            TextField(
              controller: _yearController,
              decoration: const InputDecoration(labelText: 'Year'),
              keyboardType: TextInputType.number,
            ),
            TextField(
              controller: _isbnController,
              decoration: const InputDecoration(labelText: 'ISBN'),
            ),
            TextField(
              controller: _pagesController,
              decoration: const InputDecoration(labelText: 'Pages'),
              keyboardType: TextInputType.number,
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                final newBook = Book(
                  id: DateTime.now().millisecondsSinceEpoch,
                  title: _titleController.text,
                  publisher: _publisherController.text,
                  year: int.tryParse(_yearController.text),
                  isbn: _isbnController.text,
                  pages: int.tryParse(_pagesController.text),
                  createdAt: DateTime.now(),
                );
                context
                    .read<BookDetailsBloc>()
                    .add(BookDetailsEvent.add(newBook));
                Navigator.pop(context);
              },
              child: const Text('Add Book'),
            ),
          ],
        ),
      ),
    );
  }
}
