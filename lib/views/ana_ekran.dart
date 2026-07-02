import 'package:flutter/services.dart'; // MethodChannel için gerekli
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cached_network_image/cached_network_image.dart';
import '../providers/haber_provider.dart';

// Normal StatelessWidget yerine Riverpod'u dinleyebilen ConsumerWidget kullanıyoruz
class AnaEkran extends ConsumerWidget {
  const AnaEkran({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Haber bulutunu dinliyoruz (Yükleniyor mu, geldi mi, hata mı var?)
    final haberlerAsyncValue = ref.watch(haberProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text("Günün Haberleri", style: TextStyle(fontWeight: FontWeight.bold)),
        backgroundColor: const Color.fromARGB(255, 65, 30, 223), // Y2K tarzı koyu morlar
        centerTitle: true,
      ),
      body: haberlerAsyncValue.when(
        
        // 1. DURUM: Veri API'den başarıyla geldi!
        data: (haberler) {
          if (haberler.isEmpty) {
            return const Center(child: Text("Şu an gösterilecek haber yok."));
          }
          // Binlerce haberi kasmadan çizen sonsuz listemiz
          return ListView.builder(
            itemCount: haberler.length,
            itemBuilder: (context, index) {
              final haber = haberler[index];
              return Card(
                margin: const EdgeInsets.all(10),
                color: Colors.grey[900],
                child: ListTile(
                  contentPadding: const EdgeInsets.all(10),
                  
                  // Resmi önbelleğe (Cache) alarak yüklüyoruz
                  leading: SizedBox(
                    width: 100,
                    height: 100,
                    child: CachedNetworkImage(
                      imageUrl: haber.resimUrl,
                      fit: BoxFit.cover,
                      placeholder: (context, url) => const Center(child: CircularProgressIndicator(color: Colors.greenAccent)),
                      errorWidget: (context, url, error) => const Icon(Icons.error, color: Colors.redAccent),
                    ),
                  ),
                  title: Text(haber.baslik, style: const TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
                  subtitle: Text(haber.aciklama, maxLines: 2, overflow: TextOverflow.ellipsis, style: const TextStyle(color: Colors.grey)),
                  onTap: () async {
                  // Kotlin ile aramızdaki gizli iletişim kanalının adı (İki tarafta da aynı olmak zorunda)
                  const platform = MethodChannel('com.haberokuyucu.app/webview');
                  
                  try {
                    // Kotlin'e "openBrowser" adında bir komut ve haberin URL'sini yolluyoruz
                    await platform.invokeMethod('openBrowser', {'url': haber.haberUrl});
                  } on PlatformException catch (e) {
                    print("Kotlin tarafıyla iletişim kurulamadı: '${e.message}'.");
                  }
                },
                ),
              );
            },
          );
        },
        
        // 2. DURUM: İnternetten veri bekleniyor (Spinner döndür)
        loading: () => const Center(child: CircularProgressIndicator(color: Colors.greenAccent)),
        
        // 3. DURUM: Hata alındı (Örn: İnternet koptu)
        error: (error, stack) => Center(child: Text("Bir hata oluştu: $error", style: const TextStyle(color: Colors.redAccent))),
      ),
    );
  }
}