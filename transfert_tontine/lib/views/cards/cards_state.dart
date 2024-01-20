part of 'cards_bloc.dart';

abstract class CardsState extends Equatable {
  const CardsState();
}

class CardsInitial extends CardsState {
  @override
  List<Object> get props => [];
}
