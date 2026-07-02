import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'views/ana_ekran.dart';

void main() {
  // Uygulamayı ProviderScope ile sararak Riverpod bulutunu aktif ediyoruz
  runApp(const ProviderScope(child: HaberUygulamasi()));
}

class HaberUygulamasi extends StatelessWidget {
  const HaberUygulamasi({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData.dark(), // Arka planları otomatik siyaha çeken koyu tema
      home: const AnaEkran(),
    );
  }
}