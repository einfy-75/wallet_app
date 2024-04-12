import 'package:flutter/material.dart';


class PrimaryButton extends StatelessWidget {
  const PrimaryButton(
      {Key? key,
      required this.onPressed,
      required this.label,
      
      this.disabled = false})
      : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: disabled ? null : onPressed,
      style: ElevatedButton.styleFrom(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(24)),
        ),
        minimumSize: Size.zero,
        padding: EdgeInsets.all(8),
      ),
      child: Text(
        label,
        style:TextStyle( fontSize:14,
      fontWeight: FontWeight.bold,
      ),)
    );
  }
}

class PrimaryButtonWithIcon extends StatelessWidget {
  const PrimaryButtonWithIcon(
      {Key? key,
      required this.onPressed,
      required this.label,
      required this.icon,
    
      this.disabled = false})
      : super(key: key);

  final VoidCallback? onPressed;
  final String label;
  final IconData icon;
 
  final bool disabled;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton.icon(
      onPressed: disabled ? null : onPressed,
      icon: Icon(
        icon,
        size: 16.0,
      ),
      style: ElevatedButton.styleFrom(
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(24)),
          ),
          minimumSize: Size.zero,
          padding: EdgeInsets.all(8)),
      label: Text(
        label,
        style:TextStyle(
          color: Colors.white,
          fontSize: 14
        ),
      ),
    );
  }
}
