import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/usecases/fetch_newest_books_usecase.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestBooksUsecase) : super(NewestBooksInitial());

  final FetchNewestBooksUsecase fetchNewestBooksUsecase;

  Future<void> fetchNewestBooks({int pageNumber = 0}) async {
    if (pageNumber == 0) {
      emit(NewestBooksLoading());
    } else {
      emit(NewestBooksPaginationLoading());
    }
    var result = await fetchNewestBooksUsecase.call(pageNumber);

    result.fold(
      (l) {
        if (pageNumber == 0) {
      emit(NewestBooksFailure(errorMessage: l.message));
    } else {
      emit(NewestBooksPaginationFailure(errorMessage: l.message));
    }
      },
      (r) {
        emit(NewestBooksSuccess(books: r));
      },
    );
  }
}
