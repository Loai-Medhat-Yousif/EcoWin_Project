import 'package:ecowin/Controllers/cubit/Ui_Cubits/Charity_Images_Cubit/charity_images_cubit.dart';
import 'package:ecowin/Core/Constants/general_button.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class CharityViewBody extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final TextEditingController numberofpiecesController =
        TextEditingController();
    final TextEditingController descriptionController = TextEditingController();
    return Expanded(
        child: SingleChildScrollView(
      padding:
          REdgeInsets.only(bottom: MediaQuery.of(context).viewInsets.bottom),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Padding(
          padding: REdgeInsets.only(left: 20),
          child: Text(
            "Charity Donation",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.mainColor,
                fontFamily: "AirbnbCereal_W_Md",
                fontSize: 25.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: numberofpiecesController,
            cursorColor: AppColors.mainColor,
            keyboardType: TextInputType.number,
            inputFormatters: [
              FilteringTextInputFormatter.digitsOnly,
            ],
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: AppColors.mainColor,
                ),
              ),
              hintText: "Number of pieces",
            ),
            style: TextStyle(
              fontFamily: 'AirbnbCereal_W_Md',
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.symmetric(horizontal: 20),
          child: TextField(
            controller: descriptionController,
            maxLines: 5,
            cursorColor: AppColors.mainColor,
            decoration: InputDecoration(
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: Colors.black,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15.r),
                borderSide: const BorderSide(
                  color: AppColors.mainColor,
                ),
              ),
              hintText: "Description",
            ),
            style: TextStyle(
              fontFamily: 'AirbnbCereal_W_Md',
              fontSize: 16.sp,
              color: Colors.black,
            ),
          ),
        ),
        20.verticalSpace,
        Padding(
          padding: REdgeInsets.only(left: 20),
          child: Text(
            "Take a picture(s) of the items :",
            textAlign: TextAlign.start,
            style: TextStyle(
                color: AppColors.mainColor,
                fontFamily: "AirbnbCereal_W_Md",
                fontSize: 16.sp,
                fontWeight: FontWeight.bold),
          ),
        ),
        20.verticalSpace,
        BlocBuilder<CharityImagesCubit, CharityImagesState>(
          builder: (context, state) {
            return Container(
              margin: REdgeInsets.symmetric(horizontal: 20),
              height: 50.h,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: state.charityimages.length + 1,
                itemBuilder: (context, index) {
                  if (index == state.charityimages.length) {
                    return Container(
                      height: 50.h,
                      width: 50.w,
                      margin: REdgeInsets.only(right: 10),
                      decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(12.r),
                      ),
                      child: IconButton(
                        onPressed: () {
                          context.read<CharityImagesCubit>().addImage();
                        },
                        icon: Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 30.sp,
                        ),
                      ),
                    );
                  } else {
                    return Stack(
                      children: [
                        Container(
                          height: 50.h,
                          width: 50.w,
                          margin: REdgeInsets.only(right: 10),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12.r),
                            image: DecorationImage(
                              image: FileImage(state.charityimages[index]),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                        GestureDetector(
                          onTap: () {
                            context
                                .read<CharityImagesCubit>()
                                .removeImage(index);
                          },
                          child: Container(
                            height: 50.h,
                            width: 50.w,
                            child: Icon(
                              Icons.close,
                              color: Colors.white,
                              size: 20.sp,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
            );
          },
        ),
        20.verticalSpace,
        Container(
          alignment: Alignment.center,
          child: GeneralButton(
            color: AppColors.mainColor,
            text: "Submit",
            tap: () {
              context.read<CharityImagesCubit>().submitCharityOrder(
                    context,
                    numberofpiecesController.text,
                    descriptionController.text,
                    context.read<CharityImagesCubit>().state.charityimages,
                  );
            },
            wnumber: 0.6.sw,
            hnumber: 50.h,
            textColor: Colors.white,
          ),
        )
      ]),
    ));
  }
}
