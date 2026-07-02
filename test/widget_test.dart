import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:haber_okuyucu/main.dart'; // Ana dosyamızı çağırıyoruz

void main() {
  testWidgets('Uygulama sorunsuz ayağa kalkıyor mu testi', (WidgetTester tester) async {
    // Projemizde Riverpod olduğu için testi ProviderScope ile sarmak zorundayız
    await tester.pumpWidget(const ProviderScope(child: HaberUygulamasi()));

    // Ekranda sayaç aramak yerine, uygulamanın temeli (MaterialApp) başarıyla çizilmiş mi ona bakıyoruz
    expect(find.byType(MaterialApp), findsOneWidget);
  });
}