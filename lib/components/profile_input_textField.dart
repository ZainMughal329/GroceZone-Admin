import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
// import 'package:grocery_app/components/reuseable/text_widget.dart';
//
// import '../colors/light_app_colors.dart';

class ProfileInputTextField extends StatelessWidget {
  final TextInputType? keyboardType;
  final TextInputAction? textInputAction;
  final bool obsecure;
  IconData icon;
  TextEditingController contr;
  String descrip;
  String labelText;
  bool readOnly;

  ProfileInputTextField({
    super.key,
    required this.contr,
    required this.descrip,
    this.textInputAction,
    this.keyboardType,
    required this.obsecure,
    required this.icon,
    required this.labelText,
    required this.readOnly,

    //
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 0, vertical: 5),
      child: TextField(
        controller: contr,
        textInputAction: textInputAction,
        obscureText: obsecure,
        keyboardType: keyboardType,
        readOnly: readOnly,


        style: GoogleFonts.poppins(fontSize: 16),

        decoration: InputDecoration(

          border:UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          enabledBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(
              color: Colors.orange,
            ),
          ),

          prefixIcon: Icon(
            icon,
            color: Colors.green,
          ),
          label: TextWidget(title: labelText, textColor: Colors.black,),
          // hintText: descrip,
          hintStyle: GoogleFonts.poppins(fontSize: 16),

        ),),
    );
  }
}
