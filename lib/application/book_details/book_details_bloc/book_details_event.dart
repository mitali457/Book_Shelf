part of 'book_details_bloc.dart';

@freezed
class BookDetailsEvent with _$BookDetailsEvent {
  const factory BookDetailsEvent.initial() = _Initial;
  const factory BookDetailsEvent.fetch() = _Fetch;
  const factory BookDetailsEvent.add(Book book) = _Add;
  const factory BookDetailsEvent.update(Book book) = _Update;
  const factory BookDetailsEvent.delete(int id) = _Delete;
}
