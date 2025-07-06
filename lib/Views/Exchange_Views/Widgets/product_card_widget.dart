import 'package:cached_network_image/cached_network_image.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Products%20Models/product_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ProductCardWidget extends StatelessWidget {
  final ProductModel product;
  final Map<ProductModel, int> selectedProducts;
  final VoidCallback onChanged;

  const ProductCardWidget({
    super.key,
    required this.product,
    required this.selectedProducts,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final quantity = selectedProducts[product] ?? 0;

    return Container(
      padding: REdgeInsets.all(8),
      decoration: BoxDecoration(
        color: AppColors.mainColor,
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Padding(
              padding: REdgeInsets.symmetric(vertical: 10),
              child: CachedNetworkImage(
                imageUrl: product.image,
                width: 80.w,
                height: 80.h,
                fit: BoxFit.cover,
                placeholder: (context, url) => const Center(
                  child: CircularProgressIndicator(color: Colors.white),
                ),
                errorWidget: (context, url, error) => const Icon(Icons.error),
              )),
          10.verticalSpace,
          Container(
            padding: REdgeInsets.symmetric(horizontal: 10, vertical: 5),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(6.r),
            ),
            child: Text(
              "${product.price} points",
              style: TextStyle(
                fontSize: 12.sp,
                fontWeight: FontWeight.bold,
                color: Colors.green,
              ),
            ),
          ),
          5.verticalSpace,
          Expanded(
            child: Center(
              child: Text(
                product.name,
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 15.sp,
                  fontFamily: "AirbnbCereal_W_Md",
                ),
              ),
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.remove_circle_outline,
                    color: Colors.white, size: 30.sp),
                onPressed: quantity > 0
                    ? () {
                        selectedProducts[product] = quantity - 1;
                        if (selectedProducts[product] == 0) {
                          selectedProducts.remove(product);
                        }
                        onChanged();
                      }
                    : null,
              ),
              Text(
                "$quantity",
                style: TextStyle(color: Colors.white, fontSize: 16.sp),
              ),
              IconButton(
                padding: EdgeInsets.zero,
                icon: Icon(Icons.add_circle_outline,
                    color: Colors.white, size: 30.sp),
                onPressed: () {
                  selectedProducts[product] = quantity + 1;
                  onChanged();
                },
              ),
            ],
          ),
        ],
      ),
    );
  }
}
