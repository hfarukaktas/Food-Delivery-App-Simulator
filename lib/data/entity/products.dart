class Product {
  String yemek_id;
  String yemek_adi;
  String yemek_resim_adi;
  String yemek_fiyat;

  Product({
    required this.yemek_id,
    required this.yemek_adi,
    required this.yemek_fiyat,
    required this.yemek_resim_adi,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      yemek_id: json["yemek_id"],
      yemek_adi: json["yemek_adi"],
      yemek_fiyat: json["yemek_fiyat"],
      yemek_resim_adi: json["yemek_resim_adi"],
    );
  }
}
