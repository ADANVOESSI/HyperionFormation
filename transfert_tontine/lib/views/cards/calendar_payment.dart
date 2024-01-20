import 'package:flutter/material.dart';
import 'package:transfert_tontine/configurations/themes.dart';

class DynamicCalendar extends StatelessWidget {
  final int echeance;
  final int joursPayes;
  // final String cardId;

  DynamicCalendar({
    required this.echeance,
    required this.joursPayes,
    // required this.cardId,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Détails sur le paiement'),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(10, 5, 10, 0),
        color: AppliColors.mybackground,
        child: Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).padding.top,
            ),
            Expanded(
              flex: 3,
              child: buildCalendars(),
            ),
            // Text('data')
          ],
        ),
      ),
      floatingActionButton: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          FloatingActionButton.extended(
            onPressed: () => {
              // Navigator.of(context).pushReplacementNamed(
              //   '/payment',
              //   // arguments: cardId,
              // )
            },
            // _editPokemon(context, context.read<PokemonsBloc>().state.selectedPokemon),
            label: const Text('Payer'),
            icon: const Icon(Icons.payment),
            backgroundColor: AppliColors.green,
            foregroundColor: AppliColors.white,
          ),
          IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(Icons.arrow_back),
          )
        ],
      ),
    );
  }

  Widget buildCalendars() {
    int joursParCalendrier = 31;
    int joursRestants = joursPayes;

    return ListView.builder(
      itemCount: echeance,
      itemBuilder: (context, index) {
        int joursPourCeCalendrier = joursRestants > joursParCalendrier ? joursParCalendrier : joursRestants;

        joursRestants -= joursPourCeCalendrier;

        return Container(
          color: AppliColors.backgroundLight,
          margin: EdgeInsets.only(bottom: 16.0),
          child: buildCalendar(joursPourCeCalendrier),
        );
      },
    );
  }

  Widget buildCalendar(int joursPourCeCalendrier) {
    return GridView.builder(
      shrinkWrap: true,
      physics: NeverScrollableScrollPhysics(),
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 8,
        crossAxisSpacing: 2.0,
        mainAxisSpacing: 2.0,
      ),
      itemCount: 31,
      itemBuilder: (context, index) {
        return buildDayWidget(index, index < joursPourCeCalendrier);
      },
    );
  }

  Widget buildDayWidget(int index, bool estPaye) {
    return Container(
      alignment: Alignment.center,
      decoration: BoxDecoration(
        border: Border.all(color: AppliColors.red),
      ),
      child: Stack(
        children: [
          Container(
            width: double.infinity,
            height: double.infinity,
            alignment: Alignment.center,
            child: Text(
              '${index + 1}',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.w500,
                fontFamily: 'Poppins',
              ),
            ),
          ),
          if (estPaye)
            Center(
              child: Icon(
                Icons.check,
                color: AppliColors.green,
                size: 30,
              ),
            ),
        ],
      ),
    );
  }
}
