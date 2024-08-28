part of 'book_details_bloc.dart';

@freezed
class BookDetailsState with _$BookDetailsState {
  const BookDetailsState._();

  const factory BookDetailsState({
    required List<Book> allBooks,
    required Option<Either<ApiFailure, dynamic>> apiFailureOrSuccessOption,
    required bool isFetching,
  }) = _BookDetailsState;

  factory BookDetailsState.initial() => BookDetailsState(
        allBooks:[],
        apiFailureOrSuccessOption: none(),
        isFetching: false,
      );
}
