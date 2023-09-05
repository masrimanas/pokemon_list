// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favorite_bloc.dart';

sealed class FavoriteEvent extends Equatable {
  const FavoriteEvent();

  @override
  List<Object?> get props => [];
}

class FavoriteDeleteCalled extends FavoriteEvent {
  const FavoriteDeleteCalled(
    this.pokemon,
  );

  final Pokemon pokemon;

  @override
  List<Object?> get props => [pokemon];
}
