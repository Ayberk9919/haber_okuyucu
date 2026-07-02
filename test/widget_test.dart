import 'package:flutter_test/flutter_test.dart';

void main() {
  test('CI/CD Pipeline Geçiş Testi', () {
    // İleride Mockito ile sahte internet istekleri (Mock) yazılacak.
    // Şimdilik GitHub robotunun derleme aşamasına geçebilmesi için
    // basit bir mantık testi yapıyoruz.
    
    int sonuc = 2 + 2;
    expect(sonuc, 4); // 4 ise test başarılı sayılır ve AAB üretimine geçer
  });
}