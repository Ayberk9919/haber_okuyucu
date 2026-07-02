import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_riverpod/legacy.dart';
import '../services/api_servisi.dart';
import '../models/haber_model.dart';

// Kategoriyi (Teknoloji, Spor vs.) hafızada tutan basit bir değişken
final kategoriProvider = StateProvider<String>((ref) => 'general');

// Asıl işi yapan provider. ApiServisi'ne gidip haberleri alır.
final haberProvider = FutureProvider<List<Haber>>((ref) async {
  // Seçili kategoriyi radyodan okuyoruz ki ona göre haber çeksin
  final kategori = ref.watch(kategoriProvider);
  return ApiServisi().haberleriGetir(kategori: kategori);
});