import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/entity/products.dart';
import 'package:yemeksepeti/ui/cubit/home_page_cubit.dart';
import 'package:yemeksepeti/ui/views/cart_page.dart';
import 'package:yemeksepeti/ui/views/product_page.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  void initState() {
    super.initState();
    context.read<HomePageCubit>().loadProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Yemeksepeti'),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: IconButton(
              iconSize: 30,
              color: Color(0xFF6750A4),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) => CartPage()),
                );
              },
              icon: Icon(Icons.shopping_basket_outlined),
            ),
          ),
        ],
      ),
      body: BlocBuilder<HomePageCubit, List<Product>>(
        builder: (context, productsList) {
          if (productsList.isNotEmpty) {
            return Expanded(
              child: GridView.builder(
                itemCount: productsList.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1 / 1.3,
                ),
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder:
                              (context) =>
                                  ProductPage(product: productsList[index]),
                        ),
                      );
                    },
                    child: Card(
                      color: Color(0xFF6750A4),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.all(Radius.circular(8)),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.only(
                          top: 8.0,
                          right: 8.0,
                          left: 8.0,
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                color: Color(0xFFEADDFF),
                                borderRadius: BorderRadius.all(
                                  Radius.circular(8),
                                ),
                              ),
                              child: Image.network(
                                "http://kasimadalan.pe.hu/yemekler/resimler/${productsList[index].yemek_resim_adi}",
                              ),
                            ),
                            Spacer(),
                            Padding(
                              padding: EdgeInsets.only(left: 8),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Text(
                                    productsList[index].yemek_adi,
                                    style: TextStyle(
                                      fontFamily: "Oswald",
                                      fontSize: 17,
                                      fontWeight: FontWeight.bold,
                                      color: Colors.white,
                                    ),
                                  ),
                                  Spacer(),
                                  Container(
                                    width: 50,
                                    height: 50,
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Color(0xFFEADDFF),
                                    ),
                                    child: Text(
                                      textAlign: TextAlign.end,
                                      "₺${productsList[index].yemek_fiyat}",
                                      style: TextStyle(
                                        fontFamily: "Oswald",
                                        fontSize: 18,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xFF4F378B),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Spacer(),
                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            );
          } else {
            return Text('Bos');
          }
        },
      ),
    );
  }
}
