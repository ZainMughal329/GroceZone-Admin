import 'package:flutter/material.dart';
import 'package:groce_zone_admin/components/text_widget.dart';
// import 'package:flutter_screenutil/flutter_screenutil.dart';
// import 'package:grocery_app/components/reuseable/text_widget.dart';
// import '../colors/light_app_colors.dart';


class RoundButton extends StatelessWidget {
  final String title;
  final Color color, textcolor, borderColor;
  final VoidCallback onPress;
  final bool loading;

  const RoundButton(
      {super.key,
        required this.title,
        required this.onPress,
        this.textcolor = Colors.white,
        this.borderColor = Colors.white,
        this.color = Colors.green,
        this.loading = false});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: InkWell(
        onTap: onPress,
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 10),
          child: InkWell(
            child: Container(
              height: 50,
              width: 300,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(15),
                color: Colors.green,
              ),
              child: loading
                  ? Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                  ))
                  : Center(
                child: TextWidget(
                  title: title,
                  textColor: Colors.white,
                  fontSize: 16,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
