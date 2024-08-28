import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:bookshelf/application/book_details/book_details_bloc/book_details_bloc.dart';
import 'package:bookshelf/domain/entities/books.dart';

class EditBookScreen extends StatefulWidget {
  final Book book;

  const EditBookScreen({super.key, required this.book});

  @override
  _EditBookScreenState createState() => _EditBookScreenState();
}

class _EditBookScreenState extends State<EditBookScreen> {
  late TextEditingController _titleController;
  late TextEditingController _publisherController;
  late TextEditingController _yearController;
  late TextEditingController _isbnController;
  late TextEditingController _pagesController;

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.book.title);
    _publisherController = TextEditingController(text: widget.book.publisher);
    _yearController = TextEditingController(text: widget.book.year?.toString());
    _isbnController = TextEditingController(text: widget.book.isbn);
    _pagesController = TextEditingController(text: widget.book.pages?.toString());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Book'),
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
                final updatedBook = widget.book.copyWith(
                  title: _titleController.text,
                  publisher: _publisherController.text,
                  year: int.tryParse(_yearController.text),
                  isbn: _isbnController.text,
                  pages: int.tryParse(_pagesController.text),
                );
                context.read<BookDetailsBloc>().add(BookDetailsEvent.update(updatedBook));
                Navigator.pop(context);
              },
              child: const Text('Update Book'),
            ),
          ],
        ),
      ),
    );
  }
}
