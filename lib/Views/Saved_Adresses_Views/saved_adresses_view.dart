import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Saved_Adresses_Cubit/savedadresses_cubit.dart';
import 'package:ecowin/Core/Constants/screen_dialogs.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/Saved_Adresses_Views/Widgets/add_adress_sheet.dart';
import 'package:ecowin/Views/Saved_Adresses_Views/Widgets/saved_adresses_card.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class SavedAdressesView extends StatelessWidget {
  final List<Map<String, dynamic>> selectedItemsList;
  const SavedAdressesView({
    Key? key,
    required this.selectedItemsList,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
        create: (context) => SavedadressesCubit(),
        child: Scaffold(
          resizeToAvoidBottomInset: true,
          body: Stack(children: [
            Themeconstants.backgroundimage,
            SafeArea(
                child: Column(children: [
              Padding(
                padding: REdgeInsets.symmetric(vertical: 10),
                child: GeneralAppBar(
                  backbutton: true,
                  title: "Saved Adresses",
                  ontap: () {
                    Navigator.pop(context);
                  },
                  itemscolor: Colors.black,
                ),
              ),
              20.verticalSpace,
              BlocConsumer<SavedadressesCubit, SavedadressesState>(
                listener: (context, state) {
                  if (state is ErrorAdressCardState) {
                    ScreenDialogs.showFailureDialog(
                        context, state.message, "Ok", () {
                      context.read<SavedadressesCubit>().resetToDefault();
                    });
                  }
                },
                builder: (context, state) {
                  if (state is LoadingAdressCardState) {
                    return Expanded(
                      child: const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.mainColor,
                        ),
                      ),
                    );
                  }
                  if (state is SucessfulAdressCardState) {
                    return Expanded(
                      child: Center(
                        child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset(
                                "images/Delivery.png",
                                height: 250.h,
                                width: 250.w,
                              ),
                              Padding(
                                padding: REdgeInsets.symmetric(horizontal: 20),
                                child: Text(
                                  "Your Order has been placed We will contact you in 7 days",
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                      color: Colors.black,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "AirbnbCereal_W_Md"),
                                ),
                              ),
                              20.verticalSpace,
                              ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  fixedSize: Size(0.6.sw, 50.h),
                                  padding: REdgeInsets.all(10),
                                  backgroundColor: AppColors.mainColor,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20.r),
                                  ),
                                ),
                                onPressed: () {
                                  context
                                      .read<SavedadressesCubit>()
                                      .resetToDefault();
                                  Navigator.popUntil(
                                      context, (route) => route.isFirst);
                                },
                                child: Text(
                                  "Done",
                                  style: TextStyle(
                                      fontFamily: "AirbnbCereal_W_Md",
                                      color: Colors.white,
                                      fontSize: 20.sp),
                                ),
                              )
                            ]),
                      ),
                    );
                  }
                  SavedadressesCubit savedadresscubit =
                      context.read<SavedadressesCubit>();
                  return Expanded(
                    child: ListView.builder(
                      itemCount:
                          savedadresscubit.state.savedadressescard.length,
                      itemBuilder: (context, index) {
                        return SavedAdressesCard(
                          selectedItemsList: selectedItemsList,
                          governate: savedadresscubit
                              .state.savedadressescard[index].governate,
                          city: savedadresscubit
                              .state.savedadressescard[index].city,
                          streetadress: savedadresscubit
                              .state.savedadressescard[index].streetadress,
                          buildnumber: savedadresscubit
                              .state.savedadressescard[index].buildno,
                          phone: savedadresscubit
                              .state.savedadressescard[index].phone,
                          id: savedadresscubit
                              .state.savedadressescard[index].id,
                        );
                      },
                    ),
                  );
                },
              ),
            ]))
          ]),
          floatingActionButton:
              BlocBuilder<SavedadressesCubit, SavedadressesState>(
            builder: (context, state) {
              if (state is SucessfulAdressCardState ||
                  state is ErrorAdressCardState) {
                return const SizedBox.shrink();
              }
              return AddAdressSheet();
            },
          ),
        ));
  }
}
