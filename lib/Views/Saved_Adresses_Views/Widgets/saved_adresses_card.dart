import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Saved_Adresses_Cubit/savedadresses_cubit.dart';
import 'package:ecowin/Views/Saved_Adresses_Views/Widgets/edit_adress_sheet.dart';

class SavedAdressesCard extends StatelessWidget {
  final String governate;
  final String city;
  final String buildnumber;
  final String streetadress;
  final String phone;
  final int id;
  final List<Map<String, dynamic>> selectedItemsList;
  SavedAdressesCard({
    Key? key,
    required this.governate,
    required this.city,
    required this.buildnumber,
    required this.streetadress,
    required this.phone,
    required this.id,
    required this.selectedItemsList,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: AppColors.mainColor,
      child: Padding(
        padding: REdgeInsets.all(10),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          Row(
            children: [
              Expanded(
                child: Text(
                  overflow: TextOverflow.ellipsis,
                  maxLines: 1,
                  "${governate} , ${city}",
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 15.sp,
                    fontWeight: FontWeight.bold,
                    fontFamily: "AirbnbCereal_W_Md",
                  ),
                ),
              ),
              IconButton(
                  onPressed: () {
                    context.read<SavedadressesCubit>().deleteadress(
                          id,
                        );
                  },
                  icon: Icon(Icons.delete, color: Colors.white, size: 20.sp)),
              IconButton(
                  onPressed: () {
                    showEditAddressSheet(context, id, governate, city,
                        streetadress, buildnumber, phone);
                  },
                  icon: Icon(Icons.edit, color: Colors.white, size: 20.sp))
            ],
          ),
          20.horizontalSpace,
          Row(
            children: [
              Expanded(
                child: Text(
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    "${buildnumber} ${streetadress}",
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 12.sp,
                        fontFamily: "AirbnbCereal_W_Md",
                        fontWeight: FontWeight.bold)),
              ),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  padding: REdgeInsets.all(10),
                  backgroundColor: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.r),
                  ),
                ),
                onPressed: () {
                  context.read<SavedadressesCubit>().sendOrder(governate, city,
                      streetadress, buildnumber, phone, selectedItemsList);
                },
                child: Text(
                  "Deliver Here",
                  style: TextStyle(
                      fontFamily: "AirbnbCereal_W_Md",
                      color: AppColors.mainColor,
                      fontSize: 12.sp),
                ),
              )
            ],
          )
        ]),
      ),
    );
  }
}
