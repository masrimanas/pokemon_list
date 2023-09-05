// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

sealed class FavoriteState extends Equatable {
  const FavoriteState();

  @override
  List<Object?> get props => [];
}

class FavoriteInitial extends FavoriteState {
  const FavoriteInitial();
}

class FavoriteSuccess extends FavoriteState {
  const FavoriteSuccess();
}
