import 'package:flutter/material.dart';
import '../ui/widgets/flip_card.dart';
import '../ui/widgets/card_front.dart';
import '../ui/widgets/card_back.dart';
import '../helpers/card_colors.dart';
import '../helpers/formatters.dart';
import '../blocs/card_bloc.dart';
import '../blocs/bloc_provider.dart';
import '../model/card_color_model.dart';
import '../ui/card_wallet.dart';

class CardCreate extends StatefulWidget {
  const CardCreate({Key? key}) : super(key: key);

  @override
  _CardCreateState createState() => _CardCreateState();
}

class _CardCreateState extends State<CardCreate> {
  final GlobalKey<FlipCardState> animatedStateKey = GlobalKey<FlipCardState>();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(_focusNodeListener);
  }

  @override
  void dispose() {
    _focusNode.removeListener(_focusNodeListener);
    super.dispose();
  }

  Future<void> _focusNodeListener() async {
    animatedStateKey.currentState?.toggleCard();
  }

  @override
  Widget build(BuildContext context) {
    final CardBloc bloc = BlocProvider.of<CardBloc>(context);

    final creditCard = Padding(
      padding: const EdgeInsets.only(top: 6.0),
      child: Card(
        color: Colors.grey[100],
        elevation: 0.0,
        margin: const EdgeInsets.fromLTRB(15.0, 2.0, 15.0, 0.0),
        child: FlipCard(
          key: animatedStateKey,
          front: const CardFront(rotatedTurnsValue: 0),
          back: const CardBack(),
        ),
      ),
    );

    final cardHolderName = StreamBuilder<String>(
      stream: bloc.cardHolderName,
      builder: (context, snapshot) {
        return TextField(
          textCapitalization: TextCapitalization.characters,
          onChanged: bloc.changeCardHolderName,
          keyboardType: TextInputType.text,
          decoration: InputDecoration(
            border: InputBorder.none,
            filled: true,
            fillColor: Colors.white,
            hintText: 'Cardholder Name',
            errorText: snapshot.error?.toString(),
          ),
        );
      },
    );

    final cardNumber = Padding(
      padding: const EdgeInsets.only(top: 16.0),
      child: StreamBuilder<String>(
        stream: bloc.cardNumber,
        builder: (context, snapshot) {
          return TextField(
            onChanged: bloc.changeCardNumber,
            keyboardType: TextInputType.number,
            maxLength: 19,
            inputFormatters: [
              MaskedTextInputFormatter(
                mask: 'xxxx xxxx xxxx xxxx',
                separator: ' ',
              ),
            ],
            decoration: InputDecoration(
              border: InputBorder.none,
              filled: true,
              fillColor: Colors.white,
              hintText: 'Card Number',
              counterText: '',
              errorText: snapshot.error?.toString(),
            ),
          );
        },
      ),
    );

    // Similar corrections for other fields...

    final saveCard = StreamBuilder<bool>(
      stream: bloc.savecardValid,
      builder: (context, snapshot) {
        return SizedBox(
          width: MediaQuery.of(context).size.width - 40,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.lightBlue,
            ),
            onPressed: snapshot.hasData
                ? () {
              var blocProviderCardWallet = BlocProvider(
                bloc: bloc,
                key:const ValueKey(AppBar),
                child: const CardWallet(),
              );
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => blocProviderCardWallet),
              );
            }
                : null,
            child: const Text(
              'Save Card',
              style: TextStyle(color: Colors.white),
            ),
          ),
        );
      },
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Create Card'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      backgroundColor: Colors.grey[100],
      body: ListView(
        itemExtent: 750.0,
        padding: const EdgeInsets.only(top: 10.0),
        children: <Widget>[
          Column(
            children: <Widget>[
              Expanded(
                flex: 3,
                child: creditCard,
              ),
              Expanded(
                flex: 6,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: <Widget>[
                      const SizedBox(height: 8.0),
                      cardHolderName,
                      cardNumber,
                      // Other form fields...
                      const SizedBox(height: 50.0),
                      cardColors(bloc),
                      const SizedBox(height: 50.0),
                      saveCard,
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget cardColors(CardBloc bloc) {
    final dotSize =
        (MediaQuery.of(context).size.width - 220) / CardColor.baseColors.length;

    List<Widget> dotList = [];

    for (var i = 0; i < CardColor.baseColors.length; i++) {
      dotList.add(
        StreamBuilder<List<CardColorModel>>(
          stream: bloc.cardColorsList,
          builder: (context, snapshot) {
            if (!snapshot.hasData) {
              return Container();
            }
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10.0),
              child: GestureDetector(
                onTap: () => bloc.selectCardColor(i),
                child: Container(
                  width: dotSize,
                  height: dotSize,
                  decoration: BoxDecoration(
                    color: CardColor.baseColors[i],
                    shape: BoxShape.circle,
                  ),
                  child: snapshot.data![i].isSelected
                      ? const Icon(
                    Icons.check,
                    color: Colors.white,
                    size: 12.0,
                  )
                      : Container(),
                ),
              ),
            );
          },
        ),
      );
    }

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: dotList,
    );
  }
}
