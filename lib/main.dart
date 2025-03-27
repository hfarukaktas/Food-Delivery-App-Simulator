import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/ui/cubit/add_to_cart_cubit.dart';
import 'package:yemeksepeti/ui/cubit/cart_page_cubit.dart';
import 'package:yemeksepeti/ui/cubit/home_page_cubit.dart';
import 'package:yemeksepeti/ui/views/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => HomePageCubit()),
        BlocProvider(create: (context) => AddToCartCubit()),
        BlocProvider(create: (context) => CartPageCubit()),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          appBarTheme: AppBarTheme(
            centerTitle: false,
            backgroundColor: Color(0xFFFFFFFF),
            titleTextStyle: TextStyle(
              color: Color(0xFF6750A4),
              fontSize: 24,
              fontWeight: FontWeight.bold,
              fontFamily: "Oswald",
            ),
          ),
          scaffoldBackgroundColor: Color(0xFFFFFFFF),
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        ),
        home: const HomePage(),
      ),
    );
  }
}
