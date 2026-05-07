import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

class textField extends StatefulWidget {
  final String text;
  final width;
  final controller;
  final IconData icon;
  final validator;
  final digitOnly;
  final keyBoardType;
  final obscureText;
  const textField({
    super.key,
    required this.text,
    this.controller,
    this.validator,
    this.digitOnly,
    required this.icon,
    this.keyBoardType,
    this.obscureText,
    this.width,
  });

  @override
  State<textField> createState() => _textFieldState();
}

class _textFieldState extends State<textField> {
  @override
  Widget build(BuildContext context) {
    final deviceWidth = MediaQuery.of(context).size.width;
    return Column(
      children: [
        Text('Enter your ${widget.text}', style: TextStyle(fontSize: 20.0)),

        SizedBox(height: 10.0),
        SizedBox(
          width: widget.width == null ? 270.0 : widget.width,
          child: TextFormField(
            validator: widget.validator,
            inputFormatters: widget.digitOnly != null
                ? [FilteringTextInputFormatter.digitsOnly]
                : [],
            textAlign: .center,
            controller: widget.controller,
            decoration: InputDecoration(
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.black),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.black, width: 3.0),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.blue, width: 3.0),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red, width: 3.0),
              ),
              focusedErrorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(10.0),
                borderSide: BorderSide(color: Colors.red, width: 3.0),
              ),
              prefixIcon: widget.icon == null ? null : Icon(widget.icon),
              label: Text(
                '${widget.text}',
                style: TextStyle(color: Colors.black),
              ),
            ),
            keyboardType: widget.keyBoardType == null
                ? null
                : widget.keyBoardType,
            //obscureText:widget.obscureText==null?null ,
          ),
        ),
      ],
    );
  }
}

dialogBox(BuildContext context, String error) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        alignment: .center,
        contentPadding: EdgeInsets.all(8.0),
        actions: [
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: Text('Okay'),
          ),
        ],
        title: Text('${error.replaceAll(RegExp('\\[.*?\\]'), '')}'),

        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(10.0),
        ),
        backgroundColor: Colors.redAccent.shade100,
        elevation: 5.0,
      );
    },
  );
}

poppinsText({
  required String text,
  required double size,
  FontWeight? weight,
  Color? color,
}) {
  return Text(
    '${text}',
    style: GoogleFonts.poppins(
      fontSize: size,
      fontWeight: weight != null ? weight : FontWeight.normal,
      color: color == null ? Colors.black : color,
    ),
  );
}

clickableButton({
  Color? color,
  required double? width,
  required double? height,
  required String text,
  Color? textColor,
  double? textFontSize,
  FontWeight? textFontWeight,
}) {
  return Container(
    decoration: BoxDecoration(
      color: color != null ? color : Colors.blueAccent,
      borderRadius: BorderRadius.circular(10.0),
    ),
    child: Center(
      child: poppinsText(
        text: text,
        size: textFontSize != null ? textFontSize : 20.0,
        weight: textFontWeight == null ? FontWeight.bold : textFontWeight,
        color: textColor != null ? textColor : Colors.white,
      ),
    ),
    height: height,
    width: width,
  );
}

box({
  required itemCount,
  required Money,
  required Name,
  required String text,
  double? height,
  double? width,
}) {
  return Column(
    children: [
      poppinsText(
        text: '$text',
        size: 20.0,
        weight: .bold,
        color: Colors.blueGrey,
      ),
      Container(
        height: height == null ? 250.0 : height,
        width: width == null ? 170.0 : width,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20.0),
          color: Colors.white,
          border: Border.all(color: Colors.blueAccent.shade100, width: 3.0),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: ListView.builder(
            itemCount: itemCount,
            itemBuilder: (context, index) {
              return Row(
                mainAxisAlignment: .spaceBetween,
                children: [
                  Column(
                    mainAxisAlignment: .start,
                    children: [
                      poppinsText(
                        text: Name[index].toString(),
                        size: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),

                  Column(
                    mainAxisAlignment: .start,
                    children: [
                      poppinsText(
                        text: Money[index].toString(),
                        size: 14.0,
                        color: Colors.blueGrey,
                      ),
                    ],
                  ),
                ],
              );
            },
          ),
        ),
      ),
    ],
  );
}
