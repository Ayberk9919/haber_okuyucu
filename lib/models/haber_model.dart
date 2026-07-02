class Haber {
  final String baslik;
  final String aciklama;
  final String resimUrl;
  final String haberUrl;

  Haber({
    required this.baslik,
    required this.aciklama,
    required this.resimUrl,
    required this.haberUrl,
  });

  // Gelen JSON (Map) verisini bizim Haber objemize dönüştüren fabrika fonksiyonu
  factory Haber.fromJson(Map<String, dynamic> json) {
    return Haber(
      // Eğer API'den null gelirse ?? operatörüyle varsayılan metinleri koyuyoruz ki uygulama çökmesin
      baslik: json['title'] ?? 'Başlık bulunamadı',
      aciklama: json['description'] ?? 'Açıklama bulunamadı',
      resimUrl: json['urlToImage'] ?? 'https://via.placeholder.com/400x200.png?text=Gorsel+Yok',
      haberUrl: json['url'] ?? '',
    );
  }
}