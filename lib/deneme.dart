import 'dart:convert';

void main() {
  String jsonResponse = '''
  {
    "sepet_yemekler": [
      {"sepet_yemek_id":"1", "yemek_adi":"Ayran", "yemek_resim_adi":"ayran.png", "yemek_fiyat":"3", "yemek_siparis_adet":"3", "kullanici_adi":"kasim_adalan"},
      {"sepet_yemek_id":"2", "yemek_adi":"Baklava", "yemek_resim_adi":"baklava.png", "yemek_fiyat":"25", "yemek_siparis_adet":"2", "kullanici_adi":"kasim_adalan"},
      {"sepet_yemek_id":"3", "yemek_adi":"Ayran", "yemek_resim_adi":"ayran.png", "yemek_fiyat":"3", "yemek_siparis_adet":"2", "kullanici_adi":"kasim_adalan"}
    ],
    "success":1
  }
  ''';

  Map<String, dynamic> data = jsonDecode(jsonResponse);
  List<dynamic> sepetYemekler = data["sepet_yemekler"];

  // Aynı yemekleri birleştirmek için bir map yapısı kullan
  Map<String, Map<String, dynamic>> groupedItems = {};

  for (var item in sepetYemekler) {
    String yemekAdi = item["yemek_adi"];

    if (groupedItems.containsKey(yemekAdi)) {
      groupedItems[yemekAdi]!["yemek_siparis_adet"] += int.parse(
        item["yemek_siparis_adet"],
      );
    } else {
      groupedItems[yemekAdi] = {
        "yemek_adi": item["yemek_adi"],
        "yemek_resim_adi": item["yemek_resim_adi"],
        "yemek_fiyat": item["yemek_fiyat"],
        "yemek_siparis_adet": int.parse(item["yemek_siparis_adet"]),
      };
    }
  }

  // Son haliyle birleştirilmiş liste
  List<Map<String, dynamic>> finalList = groupedItems.values.toList();

  // Çıktıyı görelim
  for (var item in finalList) {
    print("${item["yemek_adi"]}: ${item["yemek_siparis_adet"]} adet");
  }
}
