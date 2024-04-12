// import 'package:flutter/material.dart';
// import 'package:flutter_credit_card/flutter_credit_card.dart';
// import 'package:shared_preferences/shared_preferences.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:provider/provider.dart';
// import 'package:wallet_app/components/c_elevated_button.dart';
// import 'package:wallet_app/components/c_text_form_field.dart';
// import 'package:flutter_animator/flutter_animator.dart';
// import 'package:supabase/supabase.dart';
//
// import '../../providers/date_provider.dart';
// import '../../utils/constants.dart';
// import '../../widgets/select_card.dart';
//
// class AddCardPage extends StatefulWidget {
//
//   @override
//   State<StatefulWidget> createState() {
//     return AddCardManually();
//   }
// }
//
// class AddCardManually extends State<AddCardPage> {
//   String cardNumber = '';
//   String expiryDate = '';
//   String cardHolderName = '';
//   String cvvCode = '';
//   bool isCvvFocused = false;
//   final GlobalKey<FormState> formKey = GlobalKey<FormState>();
//
//   final supabase = SupabaseClient(
//     'https://isjkgctgkfgxpedgpped.supabase.co',
//     'eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzamtnY3Rna2ZneHBlZGdwcGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NTIyNjQsImV4cCI6MjAxODEyODI2NH0.WEGs8t5-q05iG3_Ocprf4UMXveRVZIin0bXoPw5wisE',
//   );
//
//
//
//   @override
//   Widget build(BuildContext context) {
//     return SlideInDown(
//       child: Scaffold(
//         appBar: AppBar(
//           backgroundColor: Colors.white,
//           title: const Text(
//             'New Card',
//             style: TextStyle(color: Colors.black, fontFamily: 'Oregon'),
//           ),
//           leading: IconButton(
//             icon: const Icon(
//               Icons.arrow_back,
//               color: Colors.black,
//             ),
//             onPressed: () {
//               Navigator.pop(
//                   context); // Pop the screen when the back button is pressed
//             },
//           ),
//         ),
//         resizeToAvoidBottomInset: true,
//         body: SafeArea(
//           child: Column(
//             children: <Widget>[
//               CreditCardWidget(
//                 height: 180,
//                 width: 350,
//                 backgroundImage: 'assets/placeholder/background.jpg',
//                 chipColor: Colors.orangeAccent,
//                 cardNumber: cardNumber,
//                 expiryDate: expiryDate,
//                 cardHolderName: cardHolderName,
//                 cvvCode: cvvCode,
//                 showBackView: isCvvFocused,
//                 obscureCardNumber: true,
//                 obscureCardCvv: true,
//                 onCreditCardWidgetChange: (CreditCardBrand) {},
//               ),
//               Expanded(
//                 child: SingleChildScrollView(
//                   child: Column(
//                     children: <Widget>[
//                       CreditCardForm(
//                         formKey: formKey,
//                         obscureCvv: true,
//                         obscureNumber: true,
//                         cardNumber: cardNumber,
//                         cvvCode: cvvCode,
//                         cardHolderName: cardHolderName,
//                         expiryDate: expiryDate,
//                         onCreditCardModelChange: onCreditCardModelChange,
//                       ),
//                       ElevatedButton(
//                         style: ElevatedButton.styleFrom(
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(8.0),
//                           ),
//                           backgroundColor: Colors.green,
//                         ),
//                         child: Container(
//                           margin: const EdgeInsets.all(8),
//                           child: const Text(
//                             'ADD',
//                             style: TextStyle(
//                               color: Colors.black,
//                               fontFamily: 'Oregon',
//                               fontSize: 16,
//                               package: 'flutter_credit_card',
//                             ),
//                           ),
//                         ),
//                         onPressed: () async {
//                           if (formKey.currentState!.validate()) {
//                             // Assuming you have the user
//
//                             // Assuming you have the user ID and cardToken (you need to generate this) available
//                             int userId = 123; // Replace with the actual user ID
//                             String cardToken = '**************'; // Replace with the actual card token
//
//                             // Call the function to add the debit card
//                             await addDebitCard(
//                               userId,
//                               cardNumber,
//                               cardHolderName,
//                               expiryDate,
//                               cvvCode,
//                               cardToken,
//                             );
//
//                             // Navigate back or perform any other actions
//                             Navigator.pop(context);
//                           }
//                         },
//                       )
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
//
//   void onCreditCardModelChange(CreditCardModel? creditCardModel) {
//     setState(() {
//       cardNumber = creditCardModel!.cardNumber;
//       expiryDate = creditCardModel.expiryDate;
//       cardHolderName = creditCardModel.cardHolderName;
//       cvvCode = creditCardModel.cvvCode;
//       isCvvFocused = creditCardModel.isCvvFocused;
//     });
//   }
//    Future<void> addDebitCard(int userId, String cardNumber, String cardholderName,
//     String expirationDate, String cvv, String cardToken) async {
//   final response = await supabase.from('debit_cards').upsert({
//     'user_id': userId,
//     'card_number': cardNumber,
//     'cardholder_name': cardholderName,
//     'expiration_date': expirationDate,
//     'cvv': cvv,
//     'card_token': cardToken,
//   });
//
//   if (response.error != null) {
//     // Handle error
//     print('Error adding debit card: ${response.error!.message}');
//   } else {
//     // Card added successfully
//     print('Debit card added successfully!');
//   }
// }
//
// }
//
//
//
//
//
//
//
// // class AddCard extends StatelessWidget {
// //   AddCard({super.key});
// //   TextEditingController dateinput = TextEditingController();
//
// //   @override
// //   Widget build(BuildContext context) {
// //     return Scaffold(
// //       backgroundColor: scaffoldColor,
// //       appBar: AppBar(
// //         elevation: 0,
// //         centerTitle: true,
// //         backgroundColor: scaffoldColor,
// //         leadingWidth: 100.w,
// //         title: Text(
// //           'Add Card',
// //           style: mediumTextStyle,
// //         ),
// //         leading: IconButton(
// //           onPressed: () {
// //             Navigator.of(context).pop();
// //           },
// //           icon: Icon(
// //             Icons.arrow_back_ios,
// //             color: primaryColor,
// //             size: 20.r,
// //           ),
// //         ),
// //       ),
// //       body: ListView(
// //         padding: REdgeInsets.all(24),
// //         physics: const BouncingScrollPhysics(),
// //         shrinkWrap: true,
// //         children: [
// //           const SelectCard(),
// //           SizedBox(
// //             height: 24.h,
// //           ),
// //           CTextFormField(
// //             hintText: 'Card Number',
// //             textInputAction: TextInputAction.next,
// //             keyboardType: TextInputType.number,
// //           ),
// //           SizedBox(
// //             height: 16.h,
// //           ),
// //           CTextFormField(
// //             hintText: 'Card Holder Name',
// //             textInputAction: TextInputAction.next,
// //             keyboardType: TextInputType.name,
// //           ),
// //           SizedBox(
// //             height: 16.h,
// //           ),
// //           Row(
// //             children: [
// //               Expanded(
// //                 child: Consumer<DateProvider>(
// //                   builder: (context, dp, child) {
// //                     return CTextFormField(
// //                       textControllor: dateinput,
// //                       hintText: 'Expiration Date',
// //                       textInputAction: TextInputAction.next,
// //                       keyboardType: TextInputType.name,
// //                       onTap: () {
// //                         dp.pickDateDialog(context, dateinput);
// //                       },
// //                     );
// //                   },
// //                 ),
// //               ),
// //               SizedBox(
// //                 width: 16.w,
// //               ),
// //               Expanded(
// //                 child: CTextFormField(
// //                   hintText: 'CVV/CVC',
// //                   textInputAction: TextInputAction.next,
// //                   keyboardType: TextInputType.name,
// //                 ),
// //               ),
// //             ],
// //           ),
// //           SizedBox(
// //             height: 200.h,
// //           ),
// //           CElevatedButton(child: const Text('Add Card'), onPressed: () {}),
// //         ],
// //       ),
// //     );
// //   }
// // }




import 'package:flutter/material.dart';
import 'package:flutter_credit_card/flutter_credit_card.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:wallet_app/components/c_elevated_button.dart';
import 'package:wallet_app/components/c_text_form_field.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:supabase/supabase.dart';

import '../../providers/date_provider.dart';
import '../../utils/constants.dart';
import '../../widgets/select_card.dart';

class AddCardPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return AddCardManually();
  }
}

class AddCardManually extends State<AddCardPage> {
  String cardNumber = '';
  String expiryDate = '';
  String cardHolderName = '';
  String cvvCode = '';
  bool isCvvFocused = false;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  final supabase = SupabaseClient(
  "https://isjkgctgkfgxpedgpped.supabase.co",
 "eyJhbGciOiJIUzI1NiIsInR5cCI6IkpXVCJ9.eyJpc3MiOiJzdXBhYmFzZSIsInJlZiI6ImlzamtnY3Rna2ZneHBlZGdwcGVkIiwicm9sZSI6ImFub24iLCJpYXQiOjE3MDI1NTIyNjQsImV4cCI6MjAxODEyODI2NH0.WEGs8t5-q05iG3_Ocprf4UMXveRVZIin0bXoPw5wisE",
  );

  @override
  Widget build(BuildContext context) {
    return SlideInDown(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: const Text(
            'New Card',
            style: TextStyle(color: Colors.black, fontFamily: 'Oregon'),
          ),
          leading: IconButton(
            icon: const Icon(
              Icons.arrow_back,
              color: Colors.black,
            ),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
        ),
        resizeToAvoidBottomInset: true,
        body: SafeArea(
          child: Column(
            children: <Widget>[
              CreditCardWidget(
                height: 180,
                width: 350,
                backgroundImage: 'assets/card_back.jpg',
                chipColor: Colors.orangeAccent,
                cardNumber: cardNumber,
                expiryDate: expiryDate,
                cardHolderName: cardHolderName,
                cvvCode: cvvCode,
                showBackView: isCvvFocused,
                obscureCardNumber: true,
                obscureCardCvv: true,
                onCreditCardWidgetChange: (CreditCardBrand) {},
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Column(
                    children: <Widget>[
                      CreditCardForm(
                        formKey: formKey,
                        obscureCvv: true,
                        obscureNumber: true,
                        cardNumber: cardNumber,
                        cvvCode: cvvCode,
                        cardHolderName: cardHolderName,
                        expiryDate: expiryDate,
                        onCreditCardModelChange: onCreditCardModelChange,
                      ),
                      SizedBox(height: 50,),
                      CElevatedButton(
                         child: const Text(
                           'ADD',
                           style: TextStyle(
                             color: Colors.black,
                             fontFamily: 'Oregon',
                             fontSize: 16,
                             package: 'flutter_credit_card',
                           ),
                         ),
                        onPressed: () async {
                          if (formKey.currentState!.validate()) {
                            // Call the function to add the debit card
                            await addDebitCard(
                              cardNumber,
                              cardHolderName,
                              expiryDate,
                              cvvCode,
                            );

                            // Navigate back or perform any other actions
                            Navigator.pop(context);
                          }
                        },
                      )
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void onCreditCardModelChange(CreditCardModel? creditCardModel) {
    setState(() {
      cardNumber = creditCardModel!.cardNumber;
      expiryDate = creditCardModel.expiryDate;
      cardHolderName = creditCardModel.cardHolderName;
      cvvCode = creditCardModel.cvvCode;
      isCvvFocused = creditCardModel.isCvvFocused;
    });
  }

  Future<void> addDebitCard(String cardNumber, String cardholderName,
      String expirationDate, String cvv) async {
    final response = await supabase.from('debit_cards').insert({
      'card_number': cardNumber,
      'cardholder_name': cardholderName,
      'expiration_date': expirationDate,
      'cvv': cvv,
    });

    if (response.error != null) {
      // Handle error
      print('Error adding debit card: ${response.error!.message}');
    } else {
      // Card added successfully
      print('Debit card added successfully!');
      // Navigate back to the previous screen
      Navigator.pop(context);
    }
  }}
