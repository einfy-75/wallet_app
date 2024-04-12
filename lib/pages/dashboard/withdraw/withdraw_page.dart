import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:wallet_app/components/c_elevated_button.dart';
import 'package:wallet_app/utils/constants.dart';
import 'package:wallet_app/widgets/balance_card.dart';
import '../../../utils/routes.dart';
import '../../../widgets/select_card.dart';



class WithdrawPage extends StatefulWidget {

  const WithdrawPage({super.key});
  @override
  State<WithdrawPage> createState() => _WithdrawPageState();
}

class _WithdrawPageState extends State<WithdrawPage> {
  int loanAmount = 1000;
  double interestRate = 0.0; // Initialize interest rate
  int period = 1; // Initialize loan period (e.g., months)
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: scaffoldColor,
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        backgroundColor: scaffoldColor,
       leadingWidth: 100.w,
        title: Text(
          'Request Loan',
          style: mediumTextStyle,
        ),
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: primaryColor,
            size: 20.r,
          ),
        ),
      ),
      body: ListView(
        physics: const BouncingScrollPhysics(),
        padding: REdgeInsets.all(24),
        shrinkWrap: true,
        children: [
          Text(
            'Select Card',
            style: mediumTextStyle,
         ),
          SizedBox(
            height: 12.h,
          ),
          const SelectCard(),
          SizedBox(
            height: 24.h,
          ),
          Text(
            'Loan Details',
            style: mediumTextStyle,
          ),
          SizedBox(
            height: 12.h,
         ),
          // Amount section (unchanged)
          Container(
            padding: REdgeInsets.symmetric(horizontal: 16.w, vertical: 10.h),
            decoration: BoxDecoration(
                color: const Color(0xFFF5F5F6),
                borderRadius: BorderRadius.all(Radius.circular(6.r))),
            child: ListTile(
              contentPadding: REdgeInsets.all(0),
              title: Text(
                'Mwk$loanAmount', // Update title to show loan amount
                style: heading2,
              ),
              trailing: SizedBox(
                width: 70.w,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    InkWell(
                      onTap: () {
                        loanAmount > 0 ? loanAmount-- : loanAmount;
                        setState(() {});
                      },
                      child: Container(
                        padding: REdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: primaryColor,
                            borderRadius:
                            BorderRadius.all(Radius.circular(4.r))),
                        child: const Icon(
                          Icons.remove,
                          color: whiteColor,
                        ),
                     ),
                    ),
                    SizedBox(
                      width: 12.w,
                    ),
                    InkWell(
                     onTap: () {
                        setState(() {
                          loanAmount++;
                       });
                      },
                      child: Container(
                        padding: REdgeInsets.all(2),
                        decoration: BoxDecoration(
                            color: secondaryColor,
                            borderRadius:
                           BorderRadius.all(Radius.circular(4.r))),
                        child: const Icon(
                          Icons.add,
                          color: primaryColor,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(
            height: 12.h,
          ),
          // Interest Rate section
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Interest Rate',
                style: mediumTextStyle,
              ),
              Text(
                '$interestRate%', // Display interest rate
                style: mediumTextStyle,
              ),
            ],
          ),
          SizedBox(
            height: 12.h,),
         // Interest Rate section (continued)
          TextField(

            keyboardType: TextInputType.number,

            decoration: InputDecoration(

              hintText: 'Enter Interest Rate (e.g., 10)',

              border: OutlineInputBorder(

                borderRadius: BorderRadius.circular(6.0.r),

              ),

            ),

            onChanged: (value) {

              try {

                interestRate = double.parse(value);

              } catch (e) {

                // Handle invalid input (optional)

              }

              setState(() {});

            },

          ),

          SizedBox(

            height: 12.h,

          ),

          // Period section

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              Text(

                'Loan Period',

                style: mediumTextStyle,

              ),

              Text(

                '$period Months', // Display loan period

                style: mediumTextStyle,

              ),

            ],

          ),

          SizedBox(

            height: 12.h,

          ),

          Row(

            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [

              InkWell(

                onTap: () {

                  period > 1 ? period-- : period;

                  setState(() {});

                },

                child: Container(

                  padding: REdgeInsets.all(8.w),

                  decoration: BoxDecoration(

                      color: const Color(0xFFF5F5F6),

                      borderRadius: BorderRadius.all(Radius.circular(6.r))),

                  child: const Icon(

                    Icons.remove,

                    color: primaryColor,

                  ),

                ),

              ),

              Text(

                '$period', // Display loan period value

                style: mediumTextStyle,

              ),

              InkWell(

                onTap: () {

                  period++;

                  setState(() {});

                },

                child: Container(

                  padding: REdgeInsets.all(8.w),

                  decoration: BoxDecoration(

                      color: const Color(0xFFF5F5F6),

                      borderRadius: BorderRadius.all(Radius.circular(6.r))),

                  child: const Icon(

                    Icons.add,
                    color: primaryColor,
                  ),
                ),
              ),
            ],
          ),
          SizedBox(

            height: 97.h, // Adjust spacing if needed

          ),

          CElevatedButton(

              child: const Text('Continue'),

              onPressed: () {

              })
        ],
      ),
    );
  }
}