import 'package:ecowin/Core/Theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecowin/Models/Products%20Models/category_model.dart';

class CategoryTabsWidget extends StatelessWidget {
  final List<CategoryModel> categories;
  final int? selectedCategoryId;
  final ValueChanged<int?> onCategorySelected;

  const CategoryTabsWidget({
    Key? key,
    required this.categories,
    required this.selectedCategoryId,
    required this.onCategorySelected,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 0.07.sh,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        padding: REdgeInsets.symmetric(horizontal: 12, vertical: 8),
        itemCount: categories.length + 1,
        separatorBuilder: (_, __) => 10.horizontalSpace,
        itemBuilder: (context, index) {
          final bool isAll = index == 0;
          final bool isSelected =
              selectedCategoryId == (isAll ? null : categories[index - 1].id);

          return GestureDetector(
            onTap: () =>
                onCategorySelected(isAll ? null : categories[index - 1].id),
            child: Container(
              padding: REdgeInsets.symmetric(horizontal: 16),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30.r),
                border: Border.all(
                    color: isSelected ? AppColors.mainColor : Colors.grey),
              ),
              child: Text(
                isAll ? 'All' : categories[index - 1].name,
                style: TextStyle(
                  color: isSelected ? AppColors.mainColor : Colors.grey,
                  fontWeight: FontWeight.w600,
                  fontSize: 14.sp,
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}
