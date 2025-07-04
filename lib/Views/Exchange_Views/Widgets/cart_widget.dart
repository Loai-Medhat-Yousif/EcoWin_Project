import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Products%20Models/product_model.dart';
import 'package:ecowin/Views/Saved_Adresses_Views/saved_adresses_view.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class FloatingCartButtonWidget extends StatelessWidget {
  final Map<ProductModel, int> selectedProducts;
  final VoidCallback refresh;

  const FloatingCartButtonWidget({
    super.key,
    required this.selectedProducts,
    required this.refresh,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Container(
          height: 65.h,
          width: 65.w,
          child: FloatingActionButton(
            backgroundColor: AppColors.mainColor,
            onPressed: () => _showBottomSheet(context),
            child: Icon(Icons.shopping_cart, color: Colors.white, size: 30.sp),
          ),
        ),
        if (selectedProducts.isNotEmpty)
          Container(
            height: 20.h,
            width: 20.w,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
              border: Border.all(color: Colors.white, width: 2),
            ),
            child: Text(
              selectedProducts.values.reduce((a, b) => a + b).toString(),
              style: TextStyle(
                color: Colors.white,
                fontSize: 10.sp,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
      ],
    );
  }

  void _showBottomSheet(BuildContext context) {
    if (selectedProducts.isEmpty) return;

    // ignore: unused_local_variable
    List<Map<String, dynamic>> selectedItemsList = selectedProducts.entries
        .where((entry) => entry.value > 0)
        .map((entry) => {
              "product_id": entry.key.id,
              "quantity": entry.value,
            })
        .toList();

    int totalPoints = selectedProducts.entries.map((e) {
      int price =
          int.tryParse(e.key.price.replaceAll(RegExp(r'[^0-9]'), '')) ?? 0;
      return price * e.value;
    }).reduce((a, b) => a + b);

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: AppColors.backgroundColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20.r)),
      ),
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateSheet) => Container(
            padding: REdgeInsets.all(16),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    height: 5.h,
                    width: 150.w,
                    decoration: BoxDecoration(
                        color: AppColors.mainColor,
                        borderRadius: BorderRadius.circular(10.r)),
                  ),
                ),
                16.verticalSpace,
                Text("Selected Items",
                    style: TextStyle(
                        fontSize: 18.sp,
                        fontWeight: FontWeight.bold,
                        fontFamily: "AirbnbCereal_W_Md")),
                16.verticalSpace,
                SizedBox(
                  height: MediaQuery.of(context).size.height * 0.4,
                  child: SingleChildScrollView(
                    child: Column(
                      children: selectedProducts.entries.map((entry) {
                        final product = entry.key;
                        final quantity = entry.value;
                        int price = int.tryParse(product.price
                                .replaceAll(RegExp(r'[^0-9]'), '')) ??
                            0;

                        return ListTile(
                          leading: Image.network(
                            product.image,
                            height: 40.h,
                            width: 40.w,
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                Container(
                              height: 40.h,
                              width: 40.w,
                              color: Colors.white,
                            ),
                          ),
                          title: Text("x$quantity ${product.name}",
                              style: TextStyle(
                                  fontFamily: "AirbnbCereal_W_Md",
                                  fontSize: 14.sp)),
                          subtitle: Text("${price * quantity} points",
                              style: TextStyle(
                                  fontFamily: "AirbnbCereal_W_Md",
                                  fontSize: 14.sp)),
                          trailing: IconButton(
                            icon: Icon(Icons.close,
                                color: AppColors.mainColor, size: 20.sp),
                            onPressed: () {
                              selectedProducts.remove(product);
                              setStateSheet(() {});
                              refresh();
                            },
                          ),
                        );
                      }).toList(),
                    ),
                  ),
                ),
                16.verticalSpace,
                Text("TOTAL: $totalPoints",
                    style: TextStyle(
                        fontSize: 16.sp, fontWeight: FontWeight.bold)),
                16.verticalSpace,
                ElevatedButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => SavedAdressesView(
                          selectedItemsList: selectedItemsList,
                        ),
                      ),
                    );
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.mainColor,
                    minimumSize: const Size(double.infinity, 50),
                  ),
                  child: Text("CONFIRM",
                      style: TextStyle(
                          color: Colors.white,
                          fontFamily: "AirbnbCereal_W_Md")),
                ),
                16.verticalSpace
              ],
            ),
          ),
        );
      },
    );
  }
}
