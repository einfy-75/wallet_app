import 'package:flutter/material.dart';
import 'package:wallet_app/pages/dashboard/paylater/widgets/primary_button.dart';
import 'package:wallet_app/pages/dashboard/paylater/apply_status.dart';

enum SingingValue { value1, value2 }

class ApplyLoanDetailFormPage extends StatefulWidget {
  const ApplyLoanDetailFormPage({
    Key? key,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ApplyLoanDetailFormPageState();
}

class _ApplyLoanDetailFormPageState extends State<ApplyLoanDetailFormPage> {
  final items = ['Option 1', 'Option 2', 'Option 3', 'Option 4'];
  String? selectedValue;

  SingingValue? _value = SingingValue.value1;

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
        title: const Text("Your info"),
        foregroundColor: Theme.of(context).primaryColor,
        backgroundColor: Colors.white,
        shadowColor: Colors.transparent,
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Your name',
                style: Theme.of(context).textTheme.subtitle2,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: 'Your name',
                ),
              ),
              const SizedBox(height: 16),
              Text(
                'Your mobile number',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(8))),
                  hintText: 'Your mobile number',
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'What’s your occupation?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'What’s your occupation?'),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: items
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
              ),
              const SizedBox(
                height: 24,
              ),
              Text(
                'How much do you earn?',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              const SizedBox(height: 16),
              Text(
                'Monthly income',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              TextFormField(
                decoration: const InputDecoration(
                    border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    hintText: 'Monthly income',
                    suffixText: 'Mwk/month'),
              ),
              const SizedBox(height: 16),
              Text(
                'Where do you earn a living?',
                style: Theme.of(context).textTheme.titleSmall,
              ),
              const SizedBox(height: 8),
              DropdownButtonFormField(
                decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(8),
                    ),
                    hintText: 'Lilongwe'),
                value: selectedValue,
                onChanged: (String? newValue) {
                  setState(() {
                    selectedValue = newValue!;
                  });
                },
                items: items
                    .map<DropdownMenuItem<String>>(
                        (String value) => DropdownMenuItem<String>(
                              value: value,
                              child: Text(value),
                            ))
                    .toList(),
                icon: const Icon(
                  Icons.keyboard_arrow_down,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              Row(
                children: [
                  Radio<SingingValue>(
                    groupValue: _value,
                    value: SingingValue.value1,
                    onChanged: (SingingValue? value) {
                      setState(() {
                        _value = value;
                      });
                    },
                  ),
                  const Text('I agree with the Terms and Conditions'),
                ],
              ),
              const SizedBox(
                height: 24,
              ),
              SizedBox(
                  width: double.infinity,
                  child: PrimaryButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) =>
                                    const ApplyLoanDetailStatusPage()));
                      },
                      label: 'Confirm')),
            ],
          ),
        ),
      ),
    );
  }
}
