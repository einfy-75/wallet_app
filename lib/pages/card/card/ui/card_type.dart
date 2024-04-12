import 'package:flutter/material.dart';
import '../blocs/bloc_provider.dart';
import '../blocs/card_bloc.dart';
import '../ui/card_create.dart';

class CardType extends StatelessWidget {
  const CardType({super.key});

  @override
  Widget build(BuildContext context) {
    final buildTextInfo = Padding(
      padding: const EdgeInsets.fromLTRB(10.0, 20.0, 10.0, 0.0),
      child: Text.rich(
        TextSpan(
          text:
          'You can now add gift cards with a specific balance into wallet. When the card hits \$0.00 it will automatically dissapear. Want to know if your gift card will link? ',
          style: TextStyle(fontSize: 14.0, color: Colors.grey[700]),
          children: const <TextSpan>[
            TextSpan(
              text: 'Learn More',
              style: TextStyle(
                color: Colors.lightBlue,
                fontWeight: FontWeight.bold,
              ),
            )
          ],
        ),
        softWrap: true,
        textAlign: TextAlign.center,
      ),
    );

    return Scaffold(
      appBar: AppBar(
        title: const Text('Select Type'),
        leading: IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Container(
        padding: const EdgeInsets.fromLTRB(20.0, 30.0, 20.0, 0.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildRaisedButton(
              buttonColor: Colors.lightBlue,
              buttonText: 'Credit Card',
              textColor: Colors.white,
              context: context,
            ),
            _buildRaisedButton(
              buttonColor: Colors.grey.shade100,
              buttonText: 'Debit Card',
              textColor: Colors.grey.shade600,
              context: context,
            ),
            _buildRaisedButton(
              buttonColor: Colors.grey.shade100,
              buttonText: 'Gift Card',
              textColor: Colors.grey.shade600,
              context: context,
            ),
            buildTextInfo,
          ],
        ),
      ),
    );
  }

  Widget _buildRaisedButton({
    required Color buttonColor,
    required String buttonText,
    required Color textColor,
    required BuildContext context,
  }) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 5.0),
      child: ElevatedButton(
        onPressed: () {
          var blocProviderCardCreate = BlocProvider(
            bloc: CardBloc(),
            key: ValueKey(buttonText),
            child: const CardCreate(),
          );
          blocProviderCardCreate.bloc.selectCardType(buttonText);
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => blocProviderCardCreate),
          );
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: buttonColor,
        ),
        child: Text(
          buttonText,
          style: TextStyle(
            color: textColor,
          ),
        ),
      ),
    );
  }
}
