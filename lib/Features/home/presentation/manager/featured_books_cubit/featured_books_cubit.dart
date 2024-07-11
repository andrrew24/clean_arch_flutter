
import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/usecases/fetch_featured_books_usecase.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUsecase)
      : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUsecase fetchFeaturedBooksUsecase;

  Future<void> fetchFeaturedBooks() async {
    emit(FeaturedBooksLoading());
    var result = await fetchFeaturedBooksUsecase.call();

    result.fold(
      (l) {
        emit(FeaturedBooksFailure(errorMessage: l.message));
      },
      (r) {
        emit(FeaturedBooksSuccess(books: r));
      },
    );
  }
}
