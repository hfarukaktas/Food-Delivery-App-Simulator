import 'package:yemeksepeti/data/entity/cart_item.dart';

class ShowCartResponse {
  List<CartItem> cartItems;
  int success;

  ShowCartResponse({required this.cartItems, required this.success});

  factory ShowCartResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["sepet_yemekler"] as List? ?? [];
    int success = json["success"] as int;

    var yemekler =
        jsonArray
            .map((jsonArrayObject) => CartItem.fromJson(jsonArrayObject))
            .toList();
    return ShowCartResponse(cartItems: yemekler, success: success);
  }
}
