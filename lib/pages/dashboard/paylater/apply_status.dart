import 'package:wallet_app/pages/dashboard/dashboard_page.dart';
import 'package:flutter/material.dart';
import 'package:wallet_app/pages/dashboard/paylater/widgets/primary_button.dart';

class ApplyLoanDetailStatusPage extends StatefulWidget {
  const ApplyLoanDetailStatusPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyLoanDetailStatusPageState();
}

class _ApplyLoanDetailStatusPageState extends State<ApplyLoanDetailStatusPage> {
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
                    Navigator.pop(context);
                  },
                ))
          ],
        ),
        title: const Text("Reviewing"),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('assets/images/successIcon.png'),
            const SizedBox(
              height: 16,
            ),
            Text(
              'Just a few minutes',
              style: Theme.of(context).textTheme.headline5,
            ),
            const SizedBox(
              height: 8,
            ),
            Text('We’re reviewing your PayLater application',
                style: Theme.of(context).textTheme.subtitle1,
                textAlign: TextAlign.center),
            const SizedBox(
              height: 24,
            ),
            const Text(
                'This should take no more than 2 minutes. We’ll send you an SMS once your PayLater is approved.',
                textAlign: TextAlign.center),
            const SizedBox(
              height: 64,
            ),
            SizedBox(
                width: double.infinity,
                child: PrimaryButton(
                    onPressed: () {
                      Navigator.pushReplacement(
                        context,
                        PageRouteBuilder(
                          pageBuilder: (context, animation1, animation2) =>
                              const DashboardPage(),
                          transitionDuration: Duration.zero,
                          reverseTransitionDuration: Duration.zero,
                        ),
                      );
                    },
                    label: 'Okay')),
          ],
        ),
      ),
    );
  }
}
