import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/History_View_Cubit/history_view_cubit.dart';
import 'package:ecowin/Views/History_Views/history_view.dart';
import 'package:ecowin/Views/My_Orders_Views/my_order_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Core/Theme/colors.dart';

class HomeViewCard extends StatelessWidget {
  final int points;
  HomeViewCard({
    Key? key,
    required this.points,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 0.2.sh,
      margin: REdgeInsets.symmetric(horizontal: 10),
      padding: REdgeInsets.all(15),
      decoration: BoxDecoration(
        image: const DecorationImage(
          image: AssetImage("images/card.png"),
          fit: BoxFit.fill,
        ),
        borderRadius: BorderRadius.circular(20).r,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            children: [
              Row(
                children: [
                  CircleAvatar(
                    backgroundColor: Colors.white10,
                    radius: 30.r,
                    child: Icon(
                      Icons.account_balance_wallet_outlined,
                      color: Colors.white,
                      size: 30.sp,
                    ),
                  ),
                  10.horizontalSpace,
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Your Points",
                        style: TextStyle(color: Colors.white, fontSize: 18.sp),
                      ),
                      Text(
                        points.toString(),
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ],
              ),
              Spacer(),
              Image.asset("images/Logo.png", height: 80.h, width: 80.w),
            ],
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              ElevatedButton.icon(
                style: ElevatedButton.styleFrom(
                  minimumSize: Size(50.w, 40.h),
                  backgroundColor: AppColors.mainColor,
                  padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(
                      MaterialPageRoute(builder: (_) => const MyOrderView()));
                },
                icon: Icon(
                  size: 20.sp,
                  Icons.airport_shuttle_sharp,
                  color: Colors.white,
                ),
                label: Text("My Orders",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontFamily: "AirbnbCereal_W_Md")),
              ),
              OutlinedButton.icon(
                style: OutlinedButton.styleFrom(
                  minimumSize: Size(40.w, 40.h),
                  padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  side: const BorderSide(color: Colors.white),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10).r,
                  ),
                ),
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (_) => BlocProvider(
                            create: (context) =>
                                HistoryViewCubit()..fetchtransactions(),
                            child: const HistoryView(),
                          )));
                },
                icon: Icon(Icons.history_outlined,
                    size: 20.sp, color: Colors.white),
                label: Text("History",
                    style: TextStyle(
                        fontSize: 20.sp,
                        color: Colors.white,
                        fontFamily: "AirbnbCereal_W_Md")),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
