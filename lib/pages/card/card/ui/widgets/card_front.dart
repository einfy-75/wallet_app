import 'package:flutter/material.dart';
import '../../helpers/card_colors.dart';
import '../../blocs/card_bloc.dart';
import '../../blocs/bloc_provider.dart';

class CardFront extends StatelessWidget {
  final int rotatedTurnsValue;
  const CardFront({Key? key, required this.rotatedTurnsValue});

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final cardNumber = StreamBuilder<String>(
      stream: bloc.cardNumber,
      builder: (context, snapshot) {
        return snapshot.hasData
            ? _formatCardNumber(snapshot.data ?? '0000000000000000')
            : _formatCardNumber('0000000000000000');
      },
    );

    final cardLastNumber = StreamBuilder<String>(
      stream: bloc.cardNumber,
      builder: (context, snapshot) {
        return Text(
          snapshot.hasData && snapshot.data!.length >= 15
              ? snapshot.data!
              .replaceAll(RegExp(r'\s+\b|\b\s'), '')
              .substring(12)
              : '0000',
          style: const TextStyle(color: Colors.white, fontSize: 8.0),
        );
      },
    );

    // Other widget declarations...

    return StreamBuilder<int>(
      stream: bloc.cardColorIndexSelected,
      initialData: 0,
      builder: (context, snapshot) {
        return Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: CardColor.baseColors[snapshot.data ?? 0],
          ),
          child: RotatedBox(
            quarterTurns: rotatedTurnsValue,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                // Add cardNumber and cardLastNumber widgets here
                cardNumber,
                cardLastNumber,
                // Other widgets...
              ],
            ),
          ),
        );
      },
    );
  }

  Widget _formatCardNumber(String cardNumber) {
    cardNumber = cardNumber.replaceAll(RegExp(r'\s+\b|\b\s'), '');
    List<Widget> numberList = [];
    var counter = 0;
    for (var i = 0; i < cardNumber.length; i++) {
      counter += 1;
      numberList.add(
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 1.0),
          child: Text(
            cardNumber[i],
            style: const TextStyle(color: Colors.white, fontSize: 16),
          ),
        ),
      );
      if (counter == 4) {
        counter = 0;
        numberList.add(const SizedBox(width: 26.0));
      }
    }
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: numberList,
    );
  }
}
