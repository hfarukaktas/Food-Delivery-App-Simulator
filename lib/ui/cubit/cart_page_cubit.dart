import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/entity/cart_item.dart';
import 'package:yemeksepeti/data/repository/productsdao_repository.dart';

class CartPageCubit extends Cubit<List<CartItem>> {
  CartPageCubit() : super(<CartItem>[]);

  var prepo = ProductsdaoRepository();
  Future<void> showCartItems() async {
    var cartItems = await prepo.showCartItems();
    emit(cartItems);
  }

  Future<void> removeFromTheCart(int sepet_yemek_id) async {
    await prepo.removeFromTheCart(sepet_yemek_id);
    showCartItems();
  }
}
