import 'package:flutter/material.dart';
import 'package:u_credit_card/u_credit_card.dart';
import 'package:carousel_slider/carousel_slider.dart';


enum CardType { debit, credit }

enum CardProviderLogoPosition { left, right }

class MCards extends StatelessWidget {
  final String cardHolderFullName;
  final String cardNumber;
  final String validFrom;
  final String validThru;
  final Color topLeftColor;
  final Color bottomRightColor;
  final CreditCardType creditCardType;
  final bool doesSupportNfc;
  final bool placeNfcIconAtTheEnd;

  final CardType cardType;
  final CardProviderLogoPosition cardProviderLogoPosition;

  const MCards({
    Key? key,
    required this.cardHolderFullName,
    required this.cardNumber,
    required this.validFrom,
    required this.validThru,
    required this.topLeftColor,
    required this.bottomRightColor,
    required this.creditCardType,
    required this.doesSupportNfc,
    required this.placeNfcIconAtTheEnd,
    required this.cardType,
    required this.cardProviderLogoPosition,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CreditCardUi(
      cardHolderFullName: cardHolderFullName,
      cardNumber: cardNumber,
      validFrom: validFrom,
      validThru: validThru,
      topLeftColor: topLeftColor,
      bottomRightColor: bottomRightColor,
      creditCardType: creditCardType,
      doesSupportNfc: doesSupportNfc,
      placeNfcIconAtTheEnd: placeNfcIconAtTheEnd,
    );
  }
}

class CarouselBank extends StatefulWidget {
  const CarouselBank({super.key});

  @override
  _CarouselWithIndicatorsState createState() => _CarouselWithIndicatorsState();
}

class _CarouselWithIndicatorsState extends State<CarouselBank> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  // Your list of MCards
  List<MCards> cardsList = [
    const MCards(
      cardHolderFullName: 'Mundie Kaweche',
      cardNumber: '**** **** **** 1234',
      validFrom: '01/22',
      validThru: '12/25',
      topLeftColor: Colors.black38,
      bottomRightColor: Colors.deepPurple,
      creditCardType: CreditCardType.mastercard,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.debit,
      cardProviderLogoPosition: CardProviderLogoPosition.right,
    ),
    const MCards(
      cardHolderFullName: 'Mundie Kaweche',
      cardNumber: '**** **** **** 1234',
      validFrom: '01/22',
      validThru: '12/25',
      topLeftColor: Colors.blue,
      bottomRightColor: Colors.blueGrey,
      creditCardType: CreditCardType.mastercard,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.credit,
      cardProviderLogoPosition: CardProviderLogoPosition.right,
    ),
    const MCards(
      cardHolderFullName: 'Mundie Kaweche',
      cardNumber: '**** **** **** 1234',
      validFrom: '01/22',
      validThru: '12/25',
      topLeftColor: Colors.greenAccent,
      bottomRightColor: Colors.green,
      creditCardType: CreditCardType.mastercard,
      doesSupportNfc: true,
      placeNfcIconAtTheEnd: true,
      cardType: CardType.credit,
      cardProviderLogoPosition: CardProviderLogoPosition.right,
    ),
    // Add more MCards as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
         items: cardsList.map((card) => card).toList(),
          options: CarouselOptions(
            animateToClosest: true,
            initialPage: 0,
            height: 200.0,
            enableInfiniteScroll: false,
            onPageChanged: (index, reason) {
              setState(() {
                _currentIndex = index;
              });
            },
          ),
          carouselController: _controller,
        ),
        const SizedBox(height: 6.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            cardsList.length,
            (index) => buildIndicator(index),
          ),
        ),
      ],
    );
  }

  Widget buildIndicator(int index) {
    return Container(
      width: 13.0,
      height: 4.0,
      margin: const EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(1.7),
        shape: BoxShape.rectangle,
        color: _currentIndex == index ? Colors.green : Colors.grey,
      ),
    );
  }
}