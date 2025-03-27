import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/entity/cart_item.dart';
import 'package:yemeksepeti/ui/cubit/cart_page_cubit.dart';

class CartPage extends StatefulWidget {
  const CartPage({super.key});

  @override
  State<CartPage> createState() => _CartPageState();
}

class _CartPageState extends State<CartPage> {
  @override
  void initState() {
    super.initState();
    context.read<CartPageCubit>().showCartItems();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Sepetim')),
      body: Column(
        children: [
          Expanded(
            child: BlocBuilder<CartPageCubit, List<CartItem>>(
              builder: (context, cartItems) {
                if (cartItems.isNotEmpty) {
                  return ListView.builder(
                    itemCount: cartItems.length,
                    itemBuilder: (context, index) {
                      int itemCount = int.parse(
                        cartItems[index].yemek_siparis_adet,
                      );
                      int itemPrice = int.parse(cartItems[index].yemek_fiyat);
                      int totalPrice = itemCount * itemPrice;
                      return Card(
                        color: Color(0xFF6750A4),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(8)),
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFFEADDFF),
                                  borderRadius: BorderRadius.all(
                                    Radius.circular(8),
                                  ),
                                ),
                                height: 75,
                                child: Image.network(
                                  "http://kasimadalan.pe.hu/yemekler/resimler/${cartItems[index].yemek_resim_adi}",
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    cartItems[index].yemek_adi,
                                    style: TextStyle(
                                      fontFamily: "Oswald",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  SizedBox(height: 5),
                                  Text(
                                    "Adet: ${itemCount.toString()}",
                                    style: TextStyle(
                                      fontFamily: "Oswald",
                                      fontSize: 17,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: Container(
                                width: 50,
                                height: 50,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  shape: BoxShape.circle,
                                  color: Color(0xFFEADDFF),
                                ),
                                child: Text(
                                  textAlign: TextAlign.end,
                                  "₺${totalPrice.toString()}",
                                  style: TextStyle(
                                    fontFamily: "Oswald",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4F378B),
                                  ),
                                ),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(right: 12.0),
                              child: GestureDetector(
                                onTap: () {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                        "${cartItems[index].yemek_adi} ürününü sepetten silmek istediğinize emin misiniz?",
                                      ),
                                      action: SnackBarAction(
                                        label: "Evet",
                                        onPressed: () {
                                          context
                                              .read<CartPageCubit>()
                                              .removeFromTheCart(
                                                int.parse(
                                                  cartItems[index]
                                                      .sepet_yemek_id,
                                                ),
                                              );
                                          ScaffoldMessenger.of(
                                            context,
                                          ).showSnackBar(
                                            SnackBar(
                                              content: Text(
                                                "${cartItems[index].yemek_adi} ürünü sepetten kaldırıldı.",
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  );
                                },
                                child: Icon(Icons.delete, color: Colors.white),
                              ),
                            ),
                          ],
                        ),
                      );
                    },
                  );
                } else {
                  return Center(child: Text("Sepetiniz Boş"));
                }
              },
            ),
          ),
          BlocBuilder<CartPageCubit, List<CartItem>>(
            builder: (context, cartItems) {
              if (cartItems.isNotEmpty) {
                int total = cartItems.fold(0, (sum, item) {
                  int itemCount = int.parse(item.yemek_siparis_adet);
                  int itemPrice = int.parse(item.yemek_fiyat);
                  return sum + (itemCount * itemPrice);
                });

                return Padding(
                  padding: const EdgeInsets.only(bottom: 16.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        "Toplam: ₺$total",
                        style: TextStyle(fontFamily: "Roboto"),
                      ),
                      ElevatedButton(
                        style: ElevatedButton.styleFrom(
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(5),
                          ),
                          backgroundColor: Color(0xFF6750A4),
                        ),
                        onPressed: () {
                          showDialog(
                            context: (context),
                            builder: (BuildContext context) {
                              return AlertDialog(
                                backgroundColor: Color(0xFFEADDFF),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(12),
                                ),
                                title: Text(
                                  "Siparişiniz Alındı!",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 18,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF4F378B),
                                  ),
                                ),
                                content: Text(
                                  "Siparişiniz başarıyla oluşturuldu! Teşekkür ederiz.",
                                  style: TextStyle(
                                    fontFamily: "Roboto",
                                    fontSize: 18,
                                    color: Color(0xFF4F378B),
                                  ),
                                ),
                                actions: [
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(5),
                                      ),
                                      backgroundColor: Color(0xFF6750A4),
                                    ),
                                    onPressed: () {
                                      for (var item in cartItems) {
                                        context
                                            .read<CartPageCubit>()
                                            .removeFromTheCart(
                                              int.parse(item.sepet_yemek_id),
                                            );
                                      }

                                      Navigator.of(context).pop();
                                    },
                                    child: Text(
                                      "Tamam",
                                      style: TextStyle(
                                        color: Color(0xFFFFFFFF),
                                        fontFamily: "Roboto",
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          );
                        },
                        child: Text(
                          "Siparişi Oluştur",
                          style: TextStyle(
                            color: Color(0xFFFFFFFF),
                            fontFamily: "Roboto",
                          ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return SizedBox();
              }
            },
          ),
        ],
      ),
    );
  }
}
