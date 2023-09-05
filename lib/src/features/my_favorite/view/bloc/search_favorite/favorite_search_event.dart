// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_search_bloc.dart';

sealed class FavoriteSearchEvent extends Equatable {
  const FavoriteSearchEvent();

  @override
  List<Object?> get props => [];
}

class FavoriteSearchCalled extends FavoriteSearchEvent {
  const FavoriteSearchCalled(
    this.keyword,
  );

  final String keyword;

  @override
  List<Object?> get props => [keyword];
}
