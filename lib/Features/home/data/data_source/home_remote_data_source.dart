import 'package:bookly/Features/home/data/models/book_model/book_model.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/constants.dart';
import 'package:bookly/core/utils/api_services.dart';
import 'package:bookly/core/utils/functions/save_books_data.dart';

abstract class HomeRemoteDataSource {
  Future<List<BookEntity>> fetchFeaturedBooks();
  Future<List<BookEntity>> fetchNewestBooks();
}

class HomeRepoDataSourceImp extends HomeRemoteDataSource {
  final ApiServices apiServices;

  List<BookEntity> parseFetchedBooks(Map<String, dynamic> data) {
    List<BookEntity> books = [];

    for (var bookMap in data['items']) {
      books.add(BookModel.fromJson(bookMap));
    }
    return books;
  }

  HomeRepoDataSourceImp({required this.apiServices});
  @override
  Future<List<BookEntity>> fetchFeaturedBooks() async {
    var data = await apiServices.get(endpoint: 'volumes?Filtering=free-ebooks&q=computer science');

    List<BookEntity> books = parseFetchedBooks(data);

    saveBooksData(books, kFeaturedBox);

    return books;
  }

  @override
  Future<List<BookEntity>> fetchNewestBooks() async {
    var data = await apiServices.get(
        endpoint: 'volumes?Filtering=free-ebooks&Sorting=newest &q=all');

    List<BookEntity> books = parseFetchedBooks(data);

    saveBooksData(books, kNewestBox);

    return books;
  }
}
