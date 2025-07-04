import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Models/Transation%20Models/transaction_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class HistoryList extends StatelessWidget {
  final List<MapEntry<String, List<TransactionModel>>> entries;
  final ScrollController scrollController;
  final bool hasMore;
  const HistoryList({
    super.key,
    required this.entries,
    required this.hasMore,
    required this.scrollController,
  });

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: ListView.builder(
        controller: scrollController,
        padding: REdgeInsets.only(top: 8, bottom: 24, right: 12, left: 12),
        itemCount: entries.length + 1,
        itemBuilder: (context, index) {
          if (index == entries.length) {
            return hasMore
                ? Padding(
                    padding: REdgeInsets.symmetric(vertical: 16),
                    child: Center(
                      child:
                          CircularProgressIndicator(color: AppColors.mainColor),
                    ),
                  )
                : Padding(
                    padding: REdgeInsets.only(top: 12),
                    child: const Center(
                      child: Text("No More Transactions Left",
                          style: TextStyle(color: Colors.grey)),
                    ),
                  );
          }

          final entry = entries[index];
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                entry.key,
                style: TextStyle(
                  fontSize: 16.sp,
                  fontWeight: FontWeight.bold,
                  color: AppColors.mainColor,
                ),
              ),
              8.horizontalSpace,
              ...entry.value.map((tx) {
                final isDebit = tx.type == 'debit';
                final icon =
                    isDebit ? Icons.sync_alt : Icons.inventory_2_outlined;
                final label =
                    isDebit ? 'Redemption Successful' : 'Waste Handover';
                final amountColor = isDebit ? Colors.red : AppColors.mainColor;
                final sign = isDebit ? '-' : '+';

                return Padding(
                  padding: REdgeInsets.symmetric(vertical: 4, horizontal: 10),
                  child: ListTile(
                    contentPadding: EdgeInsets.zero,
                    leading: CircleAvatar(
                      radius: 22.r,
                      backgroundColor: Colors.grey.shade200,
                      child: Icon(icon, color: Colors.black, size: 20.sp),
                    ),
                    title: Text(
                      label,
                      style: TextStyle(
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                        fontSize: 14.sp,
                      ),
                    ),
                    trailing: Text(
                      '$sign${double.tryParse(tx.amount)?.toStringAsFixed(0) ?? '0'}',
                      style: TextStyle(
                        color: amountColor,
                        fontWeight: FontWeight.bold,
                        fontSize: 18.sp,
                      ),
                    ),
                  ),
                );
              }).toList(),
              8.horizontalSpace,
            ],
          );
        },
      ),
    );
  }
}
