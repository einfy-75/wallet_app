
import 'package:wallet_app/pages/dashboard/paylater/widgets/primary_button.dart';
import 'package:wallet_app/pages/dashboard/dashboard_page.dart';
import 'package:wallet_app/pages/dashboard/paylater/apply_form.dart';
import 'package:flutter/material.dart';

class ApplyLoanDetailPage extends StatefulWidget {
  const ApplyLoanDetailPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyLoanDetailPageState();
}

class _ApplyLoanDetailPageState extends State<ApplyLoanDetailPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Row(
          children: [
            Padding(
                padding: const EdgeInsets.only(left: 23),
                child: GestureDetector(
                  child: Icon(
                    Icons.arrow_back_ios_new,
                    color: Theme.of(context).primaryColor,
                  ),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DashboardPage()));
                  },
                ))
          ],
        ),
        title: const Text("PayLater"),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.asset('assets/images/payLater.png'),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Shop now.',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  Text(
                    'Pay at your own pace.',
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  const SizedBox(
                    height: 16,
                  ),
                  Text(
                    '\u2022 500+ shops we partner with',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '\u2022 Pay at your own pace with 3, 6, 10, 12 installment plans',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '\u2022 Max 100,000 THB spending limit',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '\u2022 AutoPay option ensures you’re never late for payments',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    '\u2022 Pay from anywhere you are in Saber Wallet app',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  const SizedBox(
                    height: 32,
                  ),
                  SizedBox(
                      width: double.infinity,
                      child: PrimaryButton(
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const ApplyLoanDetailFormPage()));
                          },
                          label: 'Apply PayLater')),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  static Widget buildCardPayment(context, bool isDueDate, int numberPayment) {
    return Stack(
      children: [
        Container(
          margin: const EdgeInsets.only(left: 24, right: 24, bottom: 8),
          decoration: CustomBoxDecoration.build(),
          child: Theme(
            data: ThemeData(
              primarySwatch: Colors.grey,
            ).copyWith(dividerColor: Colors.transparent),
            child: ExpansionTile(
              trailing: Padding(
                padding: EdgeInsets.only(top: isDueDate ? 24 : 0),
                child: const Icon(
                  Icons.expand_more,
                  size: 16,
                ),
              ),
              title: Padding(
                padding: EdgeInsets.only(top: isDueDate ? 24 : 8, bottom: 8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          'Payment $numberPayment',
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          'Due on 19 Aug 22',
                          style: Theme.of(context).textTheme.bodySmall,
                        )
                      ],
                    ),
                    isDueDate
                        ? ElevatedButton(
                            style: ButtonStyle(
                              shape: MaterialStateProperty.all<
                                      RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(16.0),
                              )),
                              foregroundColor: MaterialStateProperty.all<Color>(
                                  Colors.white),
                              backgroundColor: MaterialStateProperty.all<Color>(
                                  const Color(0xff222222)),
                            ),
                            onPressed: () {},
                            child: const Text('44 THB'))
                        : const Text('44 THB'),
                  ],
                ),
              ),
              children: <Widget>[
                Container(
                    decoration: const BoxDecoration(
                        border: Border(
                            top: BorderSide(color: Colors.grey, width: 0.5))),
                    child: ListTile(
                      title: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('Principal'), Text('34 THB')],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('Interest'), Text('34 THB')],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('Fee'), Text('34 THB')],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: const [Text('Total'), Text('34 THB')],
                            ),
                            const SizedBox(
                              height: 16.0,
                            )
                          ],
                        ),
                      ),
                    )),
              ],
            ),
          ),
        ),
        isDueDate ? ribbon("Next payment", false) : Container()
      ],
    );
  }

  static Widget ribbon(String text, bool isSuccess) {
    return Positioned(
      top: isSuccess ? 30.0 : 5.0,
      left: 18,
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          decoration: BoxDecoration(
            color: isSuccess ? const Color(0xffB6F2A1) : const Color(0xffFFE9BE),
            borderRadius: const BorderRadius.only(
              topRight: Radius.circular(16),
              bottomRight: Radius.circular(16),
            ),
          ),
          child: Text(
            text,
            style: const TextStyle(
                color: Color(0xffE19E1C),
                fontSize: 12,
                fontWeight: FontWeight.bold),
          )),
    );
  }
}

class CustomBoxDecoration {
  static Decoration build() {
    return const BoxDecoration(
      borderRadius: BorderRadius.all(Radius.circular(16)),
      color: Colors.white,
      boxShadow: <BoxShadow>[
        BoxShadow(
            color: Color.fromRGBO(0, 0, 0, 0.05),
            offset: Offset(4, 5),
            blurRadius: 20,
            spreadRadius: 2)
      ],
    );
  }
}
