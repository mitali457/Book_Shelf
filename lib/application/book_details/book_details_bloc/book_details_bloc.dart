import 'dart:async';

import 'package:bookshelf/domain/entities/books.dart';
import 'package:bookshelf/domain/error/api_failure.dart';
import 'package:bookshelf/domain/repository/i_book_repo.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
part 'book_details_event.dart';
part 'book_details_state.dart';
part 'book_details_bloc.freezed.dart';

class BookDetailsBloc extends Bloc<BookDetailsEvent, BookDetailsState> {
  final IBookRepository repository;
  BookDetailsBloc({required this.repository})
      : super(BookDetailsState.initial()) {
    on<BookDetailsEvent>(_onEvent);
  }
  FutureOr<void> _onEvent(
    BookDetailsEvent event,
    Emitter<BookDetailsState> emit,
  ) async {
    await event.map(
      initial: (_) async => emit(BookDetailsState.initial()),
      fetch: (value) async {
        emit(
          state.copyWith(
            isFetching: true,
            apiFailureOrSuccessOption: none(),
          ),
        );
        final failureOrSuccessOption = await repository.fetchBooks();
        failureOrSuccessOption.fold(
          (failure) {
            emit(
              state.copyWith(
                isFetching: false,
                apiFailureOrSuccessOption: optionOf(failureOrSuccessOption),
              ),
            );
          },
          (bookDetails) {
            emit(
              state.copyWith(
                allBooks: bookDetails,
                isFetching: false,
                apiFailureOrSuccessOption: none(),
              ),
            );
          },
        );
      },
      add: (value) async {
        final failureOrSuccessOption = await repository.addBook(value.book);
        failureOrSuccessOption.fold(
          (failure) {
            emit(
              state.copyWith(
                isFetching: false,
                apiFailureOrSuccessOption: optionOf(failureOrSuccessOption),
              ),
            );
          },
          (_) async {
            add(const BookDetailsEvent.fetch()); // Refresh the book list
          },
        );
      },
      update: (value) async {
        final failureOrSuccessOption = await repository.updateBook(value.book);
        failureOrSuccessOption.fold(
          (failure) {
            emit(
              state.copyWith(
                isFetching: false,
                apiFailureOrSuccessOption: optionOf(failureOrSuccessOption),
              ),
            );
          },
          (_) async {
            add(const BookDetailsEvent.fetch()); // Refresh the book list
          },
        );
      },
      delete: (value) async {
        final failureOrSuccessOption = await repository.deleteBook(value.id);
        failureOrSuccessOption.fold(
          (failure) {
            emit(
              state.copyWith(
                isFetching: false,
                apiFailureOrSuccessOption: optionOf(failureOrSuccessOption),
              ),
            );
          },
          (_) async {
            add(const BookDetailsEvent.fetch()); // Refresh the book list
          },
        );
      },
    );
  }
}
