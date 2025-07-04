import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/My_Order_Cubit/my_orders_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/My_Orders_Views/Widgets/my_order_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class MyOrderView extends StatelessWidget {
  const MyOrderView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => OrdersCubit()..fetchOrders(),
      child: Scaffold(
        body: Stack(
          children: [
            Themeconstants.backgroundimage,
            SafeArea(
              child: Column(
                children: [
                  Padding(
                    padding: REdgeInsets.symmetric(vertical: 10),
                    child: GeneralAppBar(
                      backbutton: true,
                      title: "My Orders",
                      ontap: () {
                        Navigator.of(context).pop();
                      },
                      itemscolor: Colors.black,
                    ),
                  ),
                  Expanded(
                    child: BlocBuilder<OrdersCubit, OrdersState>(
                      builder: (context, state) {
                        if (state is OrdersInitial) {
                          return const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.mainColor,
                            ),
                          );
                        }
                        if (state is OrdersError) {
                          return Center(
                            child: Text(
                              state.message,
                              style: const TextStyle(color: Colors.grey),
                            ),
                          );
                        }
                        if (state is OrdersLoaded) {
                          final orders = state.orders;
                          if (orders.isEmpty) {
                            return Center(
                              child: Text(
                                "There are no orders yet.",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 20.sp,
                                    fontFamily: "AirbnbCereal_W_Md"),
                              ),
                            );
                          }
                          return MyOrderList(orders: orders);
                        }
                        return const Center(
                          child: Text("No items in your order"),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
