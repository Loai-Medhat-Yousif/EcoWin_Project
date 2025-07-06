import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/Products%20Models/category_model.dart';
import 'package:ecowin/Models/Products%20Models/product_model.dart';
import 'package:ecowin/api/Services/Exchange_Services/product_service.dart';
import 'package:equatable/equatable.dart';

part 'exchange_view_state.dart';

class ExchangeViewCubit extends Cubit<ExchangeViewState> {
  int page = 1;
  bool isLastPage = false;
  int? selectedCategoryId;

  ExchangeViewCubit() : super(ExchangeViewInitial());

  Future<void> loadInitialData() async {
    try {
      if (!isClosed) emit(ExchangeViewInitial());
      final categories = await Productservice.fetchCategories();
      selectedCategoryId = null;
      final products =
          await Productservice.fetchProducts(categoryId: null, page: 1);
      isLastPage = products.length < 20 || products.isEmpty;
      if (!isClosed)
        emit(ExchangeViewLoaded(products, !isLastPage, categories));
    } catch (e) {
      print(e);
      if (!isClosed) emit(ExchangeViewError("Failed to load initial data"));
    }
  }

  Future<void> loadProducts({int? categoryId}) async {
    try {
      page = 1;
      selectedCategoryId = categoryId;
      if (!isClosed) emit(ExchangeViewInitial());
      final categories = await Productservice.fetchCategories();
      final products = await Productservice.fetchProducts(
          categoryId: categoryId, page: page);
      isLastPage = products.length < 20 || products.isEmpty;
      if (!isClosed)
        emit(ExchangeViewLoaded(products, !isLastPage, categories));
    } catch (e) {
      if (!isClosed) emit(ExchangeViewError("Failed to load products"));
    }
  }

  Future<void> loadMoreProducts() async {
    if (isLastPage || state is! ExchangeViewLoaded) return;

    try {
      final currentState = state as ExchangeViewLoaded;
      page++;
      final moreProducts = await Productservice.fetchProducts(
        categoryId: selectedCategoryId,
        page: page,
      );

      final updatedList = [...currentState.exchanges, ...moreProducts];
      isLastPage = moreProducts.length < 20 || moreProducts.isEmpty;

      if (!isClosed)
        emit(ExchangeViewLoaded(
            updatedList, !isLastPage, currentState.categories));
    } catch (e) {
      if (!isClosed) emit(ExchangeViewError("Failed to load more products"));
    }
  }
}
