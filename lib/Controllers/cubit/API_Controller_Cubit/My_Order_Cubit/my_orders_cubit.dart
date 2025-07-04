import 'package:bloc/bloc.dart';
import 'package:ecowin/Models/My_Orders%20Models/my_orders_model.dart';
import 'package:ecowin/api/Services/My_Orders_Services/my_orders_service.dart';
import 'package:equatable/equatable.dart';

part 'my_orders_state.dart';

class OrdersCubit extends Cubit<OrdersState> {
  OrdersCubit() : super(OrdersInitial());

  Future<void> fetchOrders() async {
    try {
      final MyOrdersModel ordersModel = await MyOrdersService().fetchMyOrder();
      final List<Order> orders = ordersModel.orders;
      emit(OrdersLoaded(orders));
    } catch (e) {
      emit(OrdersError("There was an error getting orders."));
    }
  }
}
