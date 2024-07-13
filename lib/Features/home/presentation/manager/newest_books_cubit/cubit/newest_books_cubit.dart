import 'package:bloc/bloc.dart';
import 'package:bookly/Features/home/domain/entities/book_entity.dart';
import 'package:bookly/Features/home/domain/usecases/fetch_newest_books_usecase.dart';

part 'newest_books_state.dart';

class NewestBooksCubit extends Cubit<NewestBooksState> {
  NewestBooksCubit(this.fetchNewestBooksUsecase) : super(NewestBooksInitial());

  final FetchNewestBooksUsecase fetchNewestBooksUsecase;

  Future<void> fetchNewestBooks({int pageNumber = 1}) async {
    emit(NewestBooksLoading());
    var result = await fetchNewestBooksUsecase.call(
      pageNumber
    );

    result.fold(
      (l) {
        emit(NewestBooksFailure(errorMessage: l.message));
      },
      (r) {
        emit(NewestBooksSuccess(books: r));
      },
    );
  }
}
