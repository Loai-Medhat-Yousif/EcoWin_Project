import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Q&A%20Models/q&a_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class QuestionCard extends StatefulWidget {
  final QuestionAndAnswerModel model;
  const QuestionCard({super.key, required this.model});

  @override
  State<QuestionCard> createState() => _QuestionCardState();
}

class _QuestionCardState extends State<QuestionCard> {
  late bool isExpanded;

  @override
  void initState() {
    super.initState();
    isExpanded = widget.model.isExpanded;
  }

  @override
  Widget build(BuildContext context) {
    final model = widget.model;
    return Padding(
      padding: REdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: AppColors.mainColor),
          borderRadius: BorderRadius.circular(12.r),
        ),
        child: Padding(
          padding: REdgeInsets.all(8),
          child: Column(children: [
            Row(
              children: [
                Expanded(
                  child: Text(
                    model.question,
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: AppColors.mainColor,
                      fontFamily: "AirbnbCereal_W_Md",
                      fontSize: 16.sp,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                IconButton(
                    onPressed: () {
                      setState(() {
                        isExpanded = !isExpanded;
                      });
                    },
                    icon: Icon(
                      isExpanded
                          ? Icons.keyboard_arrow_up
                          : Icons.keyboard_arrow_down,
                      color: AppColors.mainColor,
                    ))
              ],
            ),
            10.verticalSpace,
            Text(
              model.answer,
              overflow: isExpanded ? null : TextOverflow.ellipsis,
              maxLines: isExpanded ? null : 2,
              style: TextStyle(
                color: Colors.black,
                fontFamily: "AirbnbCereal_W_Md",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
