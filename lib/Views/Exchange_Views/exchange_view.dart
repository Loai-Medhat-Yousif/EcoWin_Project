import 'package:ecowin/Controllers/cubit/API_Controller_Cubit/Exchange_View_Cubit/exchange_view_cubit.dart';
import 'package:ecowin/Core/Theme/colors.dart';
import 'package:ecowin/Core/Theme/general_app_bar.dart';
import 'package:ecowin/Core/Theme/theme_constants.dart';
import 'package:ecowin/Models/Products%20Models/product_model.dart';
import 'package:ecowin/Views/Exchange_Views/Widgets/cart_widget.dart';
import 'package:ecowin/Views/Exchange_Views/Widgets/category_tabs_widget.dart';
import 'package:ecowin/Views/Exchange_Views/Widgets/product_card_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

class ExchangeView extends StatefulWidget {
  const ExchangeView({super.key});

  @override
  State<ExchangeView> createState() => _ExchangeViewState();
}

class _ExchangeViewState extends State<ExchangeView> {
  final ScrollController _scrollController = ScrollController();
  bool _isFetchingMore = false;
  final Map<ProductModel, int> selectedProducts = {};

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
  }

  void _onScroll() {
    final cubit = context.read<ExchangeViewCubit>();
    final state = cubit.state;
    if (!_isFetchingMore &&
        state is ExchangeViewLoaded &&
        state.hasMore &&
        _scrollController.position.pixels >=
            _scrollController.position.maxScrollExtent - 200) {
      _isFetchingMore = true;
      cubit.loadMoreProducts().whenComplete(() {
        _isFetchingMore = false;
      });
    }
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingCartButtonWidget(
        selectedProducts: selectedProducts,
        refresh: () => setState(() {}),
      ),
      body: Stack(children: [
        Themeconstants.backgroundimage,
        SafeArea(
            child: Column(children: [
          Padding(
            padding: REdgeInsets.symmetric(vertical: 10),
            child: GeneralAppBar(
              backbutton: false,
              title: "Exchange",
              ontap: () {},
              itemscolor: Colors.black,
            ),
          ),
          Expanded(
            child: BlocBuilder<ExchangeViewCubit, ExchangeViewState>(
              builder: (context, state) {
                if (state is ExchangeViewInitial) {
                  return Center(
                    child: CircularProgressIndicator(
                      color: AppColors.mainColor,
                    ),
                  );
                }
                if (state is ExchangeViewError) {
                  return Center(
                    child: Text(
                      state.errorMessage,
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 20.sp,
                          fontWeight: FontWeight.bold,
                          fontFamily: "AirbnbCereal_W_Md"),
                    ),
                  );
                }
                if (state is ExchangeViewLoaded) {
                  return Column(
                    children: [
                      CategoryTabsWidget(
                        categories: state.categories,
                        selectedCategoryId: context
                            .read<ExchangeViewCubit>()
                            .selectedCategoryId,
                        onCategorySelected: (id) {
                          context
                              .read<ExchangeViewCubit>()
                              .loadProducts(categoryId: id);
                        },
                      ),
                      Expanded(
                        child: GridView.builder(
                          controller: _scrollController,
                          padding: REdgeInsets.all(12),
                          itemCount: state.exchanges.length + 1,
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2,
                                  crossAxisSpacing: 12.sp,
                                  mainAxisSpacing: 12.sp,
                                  mainAxisExtent: 250.h),
                          itemBuilder: (context, index) {
                            if (index == state.exchanges.length) {
                              return Center(
                                child: Padding(
                                  padding: REdgeInsets.all(16),
                                  child: state.hasMore
                                      ? CircularProgressIndicator(
                                          color: AppColors.mainColor)
                                      : Text(
                                          "No More Products Left",
                                          style: TextStyle(
                                              color: Colors.black,
                                              fontSize: 15.sp,
                                              fontFamily: "AirbnbCereal_W_Md"),
                                        ),
                                ),
                              );
                            }
                            return ProductCardWidget(
                              product: state.exchanges[index],
                              selectedProducts: selectedProducts,
                              onChanged: () => setState(() {}),
                            );
                          },
                        ),
                      ),
                    ],
                  );
                }
                return const SizedBox();
              },
            ),
          ),
        ])),
      ]),
    );
  }
}
