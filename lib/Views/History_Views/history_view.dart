import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/History_View_Cubit/history_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Views/History_Views/Widgets/history_list.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:ecowin/Models/Transation%20Models/transaction_model.dart';
import 'package:intl/intl.dart';

class HistoryView extends StatefulWidget {
  const HistoryView({super.key});

  @override
  State<HistoryView> createState() => _HistoryViewState();
}

class _HistoryViewState extends State<HistoryView> {
  final ScrollController _scrollController = ScrollController();

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  bool _isFetchingMore = false;

  void _onScroll() {
    if (_isFetchingMore) return;

    final cubit = context.read<HistoryViewCubit>();
    final state = cubit.state;

    if (state is HistoryViewLoaded &&
        state.hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      cubit.fetchMoretransactions().whenComplete(() {
        _isFetchingMore = false;
      });
    }
  }

  Map<String, List<TransactionModel>> groupTransactionsByDate(
      List<TransactionModel> transactions) {
    final Map<String, List<TransactionModel>> grouped = {};
    for (var tx in transactions) {
      final dateKey = _formatDate(tx.date);
      grouped.putIfAbsent(dateKey, () => []).add(tx);
    }
    return grouped;
  }

  String _formatDate(String rawDate) {
    final parsedDate = DateTime.parse(rawDate);
    final now = DateTime.now();
    if (parsedDate.day == now.day &&
        parsedDate.month == now.month &&
        parsedDate.year == now.year) {
      return "Today";
    }
    return DateFormat('EEEE dd MMM, yyyy').format(parsedDate);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                    title: "History",
                    ontap: () {
                      Navigator.of(context).pop();
                    },
                    itemscolor: Colors.black,
                  ),
                ),
                BlocBuilder<HistoryViewCubit, HistoryViewState>(
                  builder: (context, state) {
                    if (state is HistoryViewLoading) {
                      return Expanded(
                        child: const Center(
                          child: CircularProgressIndicator(
                              color: AppColors.mainColor),
                        ),
                      );
                    } else if (state is HistoryViewLoaded) {
                      final grouped =
                          groupTransactionsByDate(state.transactions);
                      final entries = grouped.entries.toList();

                      return HistoryList(
                        entries: entries,
                        scrollController: _scrollController,
                        hasMore: state.hasMore,
                      );
                    } else if (state is HistoryViewError) {
                      return Center(child: Text(state.message));
                    } else if (state is HistoryViewEmpty) {
                      return Expanded(
                          child: Center(
                              child: Text("No Transactions Found",
                                  style: TextStyle(
                                      color: AppColors.mainColor,
                                      fontSize: 20.sp,
                                      fontWeight: FontWeight.bold,
                                      fontFamily: "AirbnbCereal_W_Md"))));
                    }
                    return const SizedBox();
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
