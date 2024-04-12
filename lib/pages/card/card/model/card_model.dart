import 'package:flutter/material.dart';

class CardModel {
  List<CardResults> results;

  CardModel({required this.results});

  CardModel.fromJson(Map<String, dynamic> json)
      : results = List<CardResults>.from(
      (json['cardResults'] ?? []).map((v) => CardResults.fromJson(v)));
}

class CardResults {
  String cardHolderName;
  String cardNumber;
  String cardMonth;
  String cardYear;
  String cardCvv;
  Color cardColor;
  String cardType;

  CardResults({
    required this.cardHolderName,
    required this.cardNumber,
    required this.cardMonth,
    required this.cardYear,
    required this.cardCvv,
    required this.cardColor,
    required this.cardType,
  });

  CardResults.fromJson(Map<String, dynamic> json)
      : cardHolderName = json['cardHolderName'],
        cardNumber = json['cardNumber'],
        cardMonth = json['cardMonth'],
        cardYear = json['cardYear'],
        cardCvv = json['cardCvv'], //Card Verification Number
        cardColor = json['cardColor'] != null
            ? Color(json['cardColor'])
            : Colors.black, // Initialize with a default color if null
        cardType = json['cardType'];
}
