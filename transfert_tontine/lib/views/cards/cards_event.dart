part of 'cards_bloc.dart';

sealed class CardsEvent {
  const CardsEvent();

  List<Object> get props => [];
}

class CardsAddEvent extends CardsEvent {
  final String userId;
  final String nameCard;
  final int enteredAmount;
  final int expired;
  final String option;
  final String status;
  final DateTime createdAt;

  const CardsAddEvent({
    required this.userId,
    required this.nameCard,
    required this.enteredAmount,
    required this.expired,
    required this.option,
    required this.status,
    required this.createdAt,
  });

  @override
  List<Object> get props => [userId, nameCard, enteredAmount, expired, option, status, createdAt];
}

class SelectedOptionEvent extends CardsEvent {
  final OptionType selectedOption;

  const SelectedOptionEvent(this.selectedOption);

  @override
  List<Object> get props => [selectedOption];
}
