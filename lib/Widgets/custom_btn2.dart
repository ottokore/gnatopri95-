import 'package:flutter/material.dart';
import 'package:dassi/utils/utils.dart';

class CustomBtn2 extends StatelessWidget {

final String text;
final VoidCallback onPressed;

  const CustomBtn2({ super.key, required this.text, required this.onPressed });

  @override
  Widget build(BuildContext context){
    double w = MediaQuery.of(context).size.width;

    return ElevatedButton(
      onPressed: onPressed,
      style: ButtonStyle( 
        foregroundColor: WidgetStateProperty.all<Color>(Colors.white),
        backgroundColor: WidgetStateProperty.all<Color>(secondaryColor),
        shape: WidgetStateProperty.all<RoundedRectangleBorder>(RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(10.0),
        ),),
      ), 
      child: Text(text, style: TextStyle(fontSize: w*0.042)),
    );
  }
}