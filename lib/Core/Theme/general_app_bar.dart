import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class GeneralAppBar extends StatelessWidget {
  const GeneralAppBar({
    Key? key,
    required this.title,
    required this.ontap,
    required this.backbutton,
    required this.itemscolor,
  }) : super(key: key);
  final String title;
  final VoidCallback ontap;
  final bool backbutton;
  final Color itemscolor;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.05.sh,
      width: double.infinity,
      child: Stack(children: [
        backbutton
            ? Container(
                margin: const EdgeInsets.only(left: 10),
                child: OutlinedButton(
                    style: OutlinedButton.styleFrom(
                      shape: CircleBorder(
                        side: BorderSide(
                          color: itemscolor,
                          width: 1,
                        ),
                      ),
                      padding: EdgeInsets.zero,
                    ),
                    onPressed: ontap,
                    child: Icon(
                      Icons.arrow_back_outlined,
                      color: itemscolor,
                      size: 25.sp,
                    )),
              )
            : Container(),
        Center(
          child: Text(
            textAlign: TextAlign.center,
            title,
            style: TextStyle(
                fontFamily: 'AirbnbCereal_W_Md',
                fontSize: 20.sp,
                color: itemscolor,
                fontWeight: FontWeight.bold),
          ),
        )
      ]),
    );
  }
}
