import 'package:flutter/material.dart';

class PaymentBottomSheet extends StatefulWidget {
  @override
  _PaymentBottomSheetState createState() => _PaymentBottomSheetState();
}

class _PaymentBottomSheetState extends State<PaymentBottomSheet> {
  TextEditingController _amountController = TextEditingController();
  String _selectedBank = "";

  List<String> banks = [
    "Bank A",
    "Bank B",
    "Bank C",
    // Add more banks as needed
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Enter Amount",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            TextField(
              controller: _amountController,
              keyboardType: TextInputType.number,
              decoration: InputDecoration(
                labelText: "Amount",
                border: OutlineInputBorder(),
              ),
            ),
            SizedBox(height: 16),
            Text(
              "Pay With",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 8),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                crossAxisSpacing: 8.0,
                mainAxisSpacing: 8.0,
              ),
              itemCount: banks.length,
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    setState(() {
                      _selectedBank = banks[index];
                    });
                  },
                  child: Card(
                    color: _selectedBank == banks[index]
                        ? Colors.blueAccent
                        : Colors.white,
                    child: Center(
                      child: Text(banks[index]),
                    ),
                  ),
                );
              },
            ),
            SizedBox(height: 16),
            ElevatedButton(
              onPressed: () {
                // Add your payment logic here
                if (_amountController.text.isNotEmpty && _selectedBank.isNotEmpty) {
                  // Perform payment with the entered amount and selected bank
                  print("Payment Successful: Amount ${_amountController.text}, Bank: $_selectedBank");
                  Navigator.pop(context); // Close the bottom sheet
                } else {
                  // Show an error message if amount or bank is not selected
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text("Please enter the amount and select a bank."),
                    ),
                  );
                }
              },
              child: Text("Pay"),
            ),
          ],
        ),
      ),
    );
  }
}

// Example of how to use this bottom sheet in another widget:
// showModalBottomSheet(
//   context: context,
//   builder: (context) => PaymentBottomSheet(),
// );
