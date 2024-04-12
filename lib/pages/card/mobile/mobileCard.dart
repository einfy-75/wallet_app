import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MobileCards {
  final String imagePath;
  final double logoSize;

  MobileCards({
    required this.imagePath,
    this.logoSize = 120.0,
  });

  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.all(10),
      margin: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(13),
      ),
      child: Center(
        child: Image.asset(
          imagePath,
          width: logoSize,
          height: logoSize,
        ),
      ),
    );
  }
}

class CarouselMobile extends StatefulWidget {
  @override
  _CarouselWithIndicatorsState createState() => _CarouselWithIndicatorsState();
}

class _CarouselWithIndicatorsState extends State<CarouselMobile> {
  int _currentIndex = 0;
  final CarouselController _controller = CarouselController();

  // Your list of MCards
  List<MobileCards> mobilecardsList = [
    MobileCards(imagePath: 'assets/images/airtel.jpg', logoSize: 120),
    MobileCards(imagePath: 'assets/images/mpamba.png', logoSize: 120),
    MobileCards(imagePath: 'assets/images/airtel.jpg', logoSize: 120)
    // Add more MCards as needed
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        CarouselSlider(
          items: mobilecardsList.map((card) => card.build(context)).toList(),
          options: CarouselOptions(
            animateToClosest: true,
            initialPage: 0,
            scrollDirection: Axis.horizontal,
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
            mobilecardsList.length,
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
