import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Q&A_View_Cubit/questions_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController searchController;
  const SearchWidget({
    Key? key,
    required this.searchController,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(15),
      child: TextField(
        onSubmitted: (_) {
          context.read<FQAViewCubit>().searchQuestions(searchController.text);
        },
        controller: searchController,
        cursorColor: Colors.white,
        decoration: InputDecoration(
            border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(30.r),
                borderSide: BorderSide.none),
            filled: true,
            fillColor: AppColors.mainColor,
            hintText: "Search",
            hintStyle: TextStyle(
              color: Colors.white,
              fontFamily: "AirbnbCereal_W_Md",
              fontSize: 16.sp,
              fontWeight: FontWeight.bold,
            ),
            prefixIcon: Icon(
              Icons.search,
              color: Colors.white,
              size: 20.sp,
            )),
        style: TextStyle(
          color: Colors.white,
          fontFamily: "AirbnbCereal_W_Md",
          fontSize: 16.sp,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
