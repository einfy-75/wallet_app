import 'package:flutter/material.dart';

class ActionsPush extends StatelessWidget {
  final IconData iconData;
  final String text;

  final Function()? onTap;

  const ActionsPush({super.key,
    required this.iconData,
    required this.text,

    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      highlightColor: Colors.green,
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
            Container(
              padding:EdgeInsets.all(10.0),
              decoration:BoxDecoration(
                color:Colors.black26,
              ),
              child: Icon(
                color:Colors.green,
              iconData,
              size: 25.0,
              weight: 10,

                        ),
            ),
          // SizedBox(height: 3.0),
          Text(
            text,
            style: TextStyle(fontSize: 14.0, fontWeight: FontWeight.w800,color: Colors.white),
          ),
        ],
      ),
    );
  }
}
