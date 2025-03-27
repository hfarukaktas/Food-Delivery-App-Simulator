import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/entity/products.dart';
import 'package:yemeksepeti/ui/cubit/add_to_cart_cubit.dart';

class ProductPage extends StatefulWidget {
  final Product product;
  ProductPage({required this.product});

  @override
  State<ProductPage> createState() => _ProductPageState();
}

class _ProductPageState extends State<ProductPage> {
  int itemCount = 0;
  @override
  void initState() {
    super.initState();
    itemCount = 1;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Urun Detayi")),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(
              height: 250,
              width: double.infinity,
              child: Image.network(
                "http://kasimadalan.pe.hu/yemekler/resimler/${widget.product.yemek_resim_adi}",
              ),
            ),

            Text(
              "₺${widget.product.yemek_fiyat}",
              style: TextStyle(
                fontFamily: "Oswald",
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Color(0xFF625B71),
              ),
            ),
            Text(
              widget.product.yemek_adi,
              style: TextStyle(
                fontFamily: "Oswald",
                fontSize: 25,
                fontWeight: FontWeight.bold,
                color: Color(0xFF4F378B),
              ),
            ),
            Spacer(),

            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Row(
                  children: [
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      onPressed: () {
                        setState(() {
                          if (itemCount != 1) {
                            itemCount -= 1;
                          }
                        });
                      },
                      child: Icon(Icons.remove, color: Color(0xFF6750A4)),
                    ),
                    Text(itemCount.toString(), style: TextStyle(fontSize: 18)),

                    ElevatedButton(
                      style: ElevatedButton.styleFrom(shape: CircleBorder()),
                      onPressed: () {
                        setState(() {
                          itemCount += 1;
                        });
                      },
                      child: Icon(Icons.add),
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(5),
                        ),
                        backgroundColor: Color(0xFF6750A4),
                      ),
                      onPressed: () {
                        context.read<AddToCartCubit>().addToCart(
                          widget.product.yemek_adi,
                          widget.product.yemek_resim_adi,
                          int.parse(widget.product.yemek_fiyat),
                          itemCount,
                        );
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              "${itemCount} adet ${widget.product.yemek_adi} sepete eklendi",
                            ),
                            duration: Duration(seconds: 2),
                          ),
                        );
                      },
                      child: Text(
                        "Sepete Ekle",
                        style: TextStyle(color: Color(0xFFFFFFFF)),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            SizedBox(height: 40),
          ],
        ),
      ),
    );
  }
}
