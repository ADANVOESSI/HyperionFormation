import 'package:bloc/bloc.dart';
import 'package:transfert_tontine/provider/cards_provider.dart';
import 'package:transfert_tontine/utils/extension/option_extension.dart';
import 'package:transfert_tontine/views/cards/cards_state.dart';

part 'cards_event.dart';

class CardsBloc extends Bloc<CardsEvent, CardsState> {
  final cardProvider = CardProvider();
  CardsBloc() : super(const CardsState()) {
    // on<CardsAddEvent>(_addCards);
    on<SelectedOptionEvent>(_selectedOption);
  }

  // Future<String> _addCards(
  //   CardsAddEvent event,
  //   Emitter<CardsState> emit,
  // ) async {
  //   try {
  //     DocumentReference documentReference = await cardProvider.registerCard(
  //       userId: event.userId,
  //       nameCard: event.nameCard,
  //       enteredAmount: event.enteredAmount,
  //       expired: event.expired,
  //       option: event.option,
  //       status: event.status,
  //       createdAt: event.createdAt,
  //     );
  //
  //     emit(state.copyWith());
  //     // print("L'id de l'élément est ${documentReference.id}").
  //     return documentReference;
  //   } catch (e) {
  //     log('Failed to add cards $e', stackTrace: StackTrace.current);
  //     rethrow;
  //   }
  // }

  // Future<void> _addCards(
  //   CardsAddEvent event,
  //   Emitter<CardsState> emit,
  // ) async {
  //   try {
  //     await cardProvider.registerCard(
  //       userId: event.userId,
  //       nameCard: event.nameCard,
  //       enteredAmount: event.enteredAmount,
  //       expired: event.expired,
  //       option: event.option,
  //       status: event.status,
  //       createdAt: event.createdAt,
  //     );
  //     emit(state.copyWith());
  //   } catch (e) {
  //     log('Failed to add cards $e', stackTrace: StackTrace.current);
  //   }
  // }

  Future<void> _selectedOption(
    SelectedOptionEvent event,
    Emitter<CardsState> emit,
  ) async {
    emit(state.copyWith(optionType: event.selectedOption));
    print("L'option sélectionnée est ${event.selectedOption.value}");
  }
}
