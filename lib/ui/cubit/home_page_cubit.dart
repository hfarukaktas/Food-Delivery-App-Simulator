import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/entity/products.dart';
import 'package:yemeksepeti/data/repository/productsdao_repository.dart';

class HomePageCubit extends Cubit<List<Product>> {
  HomePageCubit() : super(<Product>[]);

  var prepo = ProductsdaoRepository();

  Future<void> loadProducts() async {
    var foods = await prepo.loadProducts();
    emit(foods);
  }
}
