import 'package:yemeksepeti/data/entity/products.dart';

class ProductsResponse {
  List<Product> products;
  int success;

  ProductsResponse({required this.products, required this.success});

  factory ProductsResponse.fromJson(Map<String, dynamic> json) {
    var jsonArray = json["yemekler"] as List;
    int success = json["success"] as int;

    var yemekler =
        jsonArray
            .map((jsonArrayObject) => Product.fromJson(jsonArrayObject))
            .toList();
    return ProductsResponse(products: yemekler, success: success);
  }
}
