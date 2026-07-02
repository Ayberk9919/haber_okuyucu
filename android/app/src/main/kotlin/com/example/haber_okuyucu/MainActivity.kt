package com.example.haber_okuyucu

// (KENDI PACKAGE YAZIN BURADA KALSIN, ÖRN: package com.example.haber_okuyucu)

import android.content.Intent
import android.net.Uri
import io.flutter.embedding.android.FlutterActivity
import io.flutter.embedding.engine.FlutterEngine
import io.flutter.plugin.common.MethodChannel

class MainActivity: FlutterActivity() {
    // Flutter'da yazdığımız kanal adının birebir aynısı
    private val CHANNEL = "com.haberokuyucu.app/webview"

    override fun configureFlutterEngine(flutterEngine: FlutterEngine) {
        super.configureFlutterEngine(flutterEngine)
        
        // Flutter'dan gelen mesajları dinleyen kulaklık
        MethodChannel(flutterEngine.dartExecutor.binaryMessenger, CHANNEL).setMethodCallHandler { call, result ->
            
            // Eğer Flutter "openBrowser" komutunu gönderdiyse:
            if (call.method == "openBrowser") {
                val url = call.argument<String>("url")
                
                if (url != null) {
                    // İŞTE KOTLIN'IN GÜCÜ: Android'in kendi yerel tarayıcısını (Chrome vb.) açan o native kod
                    val intent = Intent(Intent.ACTION_VIEW, Uri.parse(url))
                    startActivity(intent)
                    result.success("Tarayıcı başarıyla açıldı")
                } else {
                    result.error("URL_YOK", "Haber linki boş geldi", null)
                }
            } else {
                result.notImplemented()
            }
        }
    }
}
