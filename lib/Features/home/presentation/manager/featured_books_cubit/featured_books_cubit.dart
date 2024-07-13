import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/usecases/fetch_featured_books_usecase.dart';

part 'featured_books_state.dart';

class FeaturedBooksCubit extends Cubit<FeaturedBooksState> {
  FeaturedBooksCubit(this.fetchFeaturedBooksUsecase)
      : super(FeaturedBooksInitial());

  final FetchFeaturedBooksUsecase fetchFeaturedBooksUsecase;

  Future<void> fetchFeaturedBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(FeaturedBooksLoading());
    } else {
      emit(FeaturedBooksPaginationLoading());
    }
    var result = await fetchFeaturedBooksUsecase.call(pageNumber);

    result.fold(
      (l) {
        if (pageNumber == 0) {
          emit(FeaturedBooksFailure(errorMessage: l.message));
        } else {
          emit(FeaturedBooksPaginationFailure(errorMessage: l.message));
        }
      },
      (r) {
        emit(FeaturedBooksSuccess(books: r));
      },
    );
  }
}
