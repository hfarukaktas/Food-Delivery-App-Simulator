import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:yemeksepeti/data/entity/cart_item.dart';
import 'package:yemeksepeti/data/entity/products.dart';
import 'package:yemeksepeti/data/entity/products_response.dart';
import 'package:yemeksepeti/data/entity/show_cart_response.dart';

class ProductsdaoRepository {
  List<Product> parseProducts(String response) {
    return ProductsResponse.fromJson(json.decode(response)).products;
  }

  List<CartItem> parseCartItems(String response) {
    return ShowCartResponse.fromJson(json.decode(response)).cartItems;
  }

  Future<List<Product>> loadProducts() async {
    var url = "http://kasimadalan.pe.hu/yemekler/tumYemekleriGetir.php";
    var response = await Dio().get(url);
    return parseProducts(response.data.toString());
  }

  Future<void> addToCart(
    String yemek_adi,
    String yemek_resim_adi,
    int yemek_fiyat,
    int yemek_siparis_adeti,
  ) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepeteYemekEkle.php";
    var data = {
      "yemek_adi": yemek_adi,
      "yemek_resim_adi": yemek_resim_adi,
      "yemek_fiyat": yemek_fiyat,
      "yemek_siparis_adet": yemek_siparis_adeti,
      "kullanici_adi": "Faruk",
    };
    var response = await Dio().post(url, data: FormData.fromMap(data));

    print("Sepete Ekle: ${response.data.toString()}");
  }

  Future<void> removeFromTheCart(int sepet_yemek_id) async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": "Faruk"};
    var response = await Dio().post(url, data: FormData.fromMap(data));

    var cartItems = parseCartItems(response.data.toString());
    String? potentialDuplicatedName;

    for (var item in cartItems) {
      if (item.sepet_yemek_id == sepet_yemek_id.toString()) {
        potentialDuplicatedName = item.yemek_adi;
        break;
      }
    }

    if (potentialDuplicatedName == null) return;

    List<int> idsToDelete = [];
    for (var item in cartItems) {
      if (item.yemek_adi == potentialDuplicatedName) {
        idsToDelete.add(int.parse(item.sepet_yemek_id));
      }
    }

    for (var id in idsToDelete) {
      var deleteUrl = "http://kasimadalan.pe.hu/yemekler/sepettenYemekSil.php";
      var deleteData = {"sepet_yemek_id": id, "kullanici_adi": "Faruk"};
      await Dio().post(deleteUrl, data: FormData.fromMap(deleteData));
    }
  }

  Future<List<CartItem>> showCartItems() async {
    var url = "http://kasimadalan.pe.hu/yemekler/sepettekiYemekleriGetir.php";
    var data = {"kullanici_adi": "Faruk"};

    try {
      var response = await Dio().post(url, data: FormData.fromMap(data));
      if (response.data == null || response.data.toString().trim().isEmpty) {
        return [];
      }
      var cartItems = parseCartItems(response.data.toString());

      var cartItemsInOrder = <CartItem>[];
      var cartItemNames = <String>[];
      var cartItemOrders = <int>[];

      for (var item in cartItems) {
        if (cartItemNames.contains(item.yemek_adi)) {
          var index = cartItemNames.indexOf(item.yemek_adi);
          cartItemOrders[index] += int.parse(item.yemek_siparis_adet);
          cartItemsInOrder[index].yemek_siparis_adet =
              cartItemOrders[index].toString();
        } else {
          cartItemNames.add(item.yemek_adi);
          cartItemOrders.add(int.parse(item.yemek_siparis_adet));
          cartItemsInOrder.add(item);
        }
      }
      return cartItemsInOrder;
    } catch (e) {
      print("Hata oluştu: $e");
      return [];
    }
  }

  int itemCountAdd(int currentNumber) {
    int newNumber = currentNumber + 1;
    return newNumber;
  }

  int itemCountReduce(int currentNumber) {
    if (currentNumber == 1) {
      return 1;
    }
    ;
    int newNumber = currentNumber - 1;

    return newNumber;
  }
}
