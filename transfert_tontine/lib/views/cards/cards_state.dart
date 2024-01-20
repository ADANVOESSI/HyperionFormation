import 'package:equatable/equatable.dart';
import 'package:transfert_tontine/utils/extension/option_extension.dart';

enum CardsStatus { initial, loading, success, failure }

class CardsState extends Equatable {
  final CardsStatus status;
  final OptionType? optionType;
  final String? nameCard;
  final String? userId;
  final String? paymentNumber;
  final int? expired;
  final int? enteredAmount;

  const CardsState({
    this.status = CardsStatus.initial,
    this.optionType,
    this.nameCard,
    this.userId,
    this.paymentNumber,
    this.expired,
    this.enteredAmount,
  });

  CardsState copyWith({
    CardsStatus? status,
    OptionType? optionType,
    String? nameCard,
    String? userId,
    String? paymentNumber,
    int? expired,
    int? enteredAmount,
  }) {
    return CardsState(
      status: status ?? this.status,
      optionType: optionType ?? this.optionType,
      nameCard: nameCard ?? this.nameCard,
      userId: userId ?? this.userId,
      paymentNumber: paymentNumber ?? this.paymentNumber,
      expired: expired ?? this.expired,
      enteredAmount: enteredAmount ?? this.enteredAmount,
    );
  }

  @override
  List<Object?> get props => [status, optionType, nameCard, userId, paymentNumber, expired, enteredAmount];
}
