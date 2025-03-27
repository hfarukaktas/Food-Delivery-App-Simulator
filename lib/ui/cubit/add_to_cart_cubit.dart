import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:yemeksepeti/data/repository/productsdao_repository.dart';

class AddToCartCubit extends Cubit<void> {
  AddToCartCubit() : super(1);

  var prepo = ProductsdaoRepository();

  Future<void> addToCart(
    String yemek_adi,
    String yemek_resim_adi,
    int yemek_fiyat,
    int yemek_siparis_adeti,
  ) async {
    await prepo.addToCart(
      yemek_adi,
      yemek_resim_adi,
      yemek_fiyat,
      yemek_siparis_adeti,
    );
  }
}
