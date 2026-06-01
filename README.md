# CatchTheFruitsApp

CatchTheFruits, UIKit ile geliştirilmiş basit ve eğlenceli bir iOS refleks oyunudur. Ekranda rastgele beliren meyvelere dokunarak süre bitmeden en yüksek skora ulaşmanız hedeflenir.

## Güncel Teknoloji Durumu

- **Dil:** Swift 5
- **UI Teknolojisi:** UIKit + Storyboard
- **Minimum iOS Sürümü:** iOS 15.0
- **Proje Türü:** Xcode iOS App (single target)

## Oyun Özeti

- Oyun başladığında sayaç 20 saniyeden geri sayar.
- Meyveler belirli aralıklarla rastgele konumda görünür.
- Her doğru dokunuş skoru 1 artırır.
- Oyun sonunda en yüksek skor `UserDefaults` ile cihazda saklanır.

## Proje Yapısı

- `CatchTheFruits/AppDelegate.swift`  
  Uygulama başlangıç noktası.
- `CatchTheFruits/ViewController.swift`  
  Oyun döngüsü, süre yönetimi, skor ve high score mantığı.
- `CatchTheFruits/Base.lproj/Main.storyboard`  
  Oyun ekranı arayüz yerleşimi.

## Kurulum ve Çalıştırma

1. Xcode 15+ (tercihen en güncel sürüm) yükleyin.
2. Projeyi açın:
   - `CatchTheFruits.xcodeproj`
3. Bir iOS Simulator veya fiziksel cihaz seçin.
4. `Run` (⌘R) ile uygulamayı başlatın.

## Yapılan Güncellemeler

- Swift 4.2 ayarları Swift 5'e yükseltildi.
- Minimum iOS sürümü iOS 15.0 olarak güncellendi.
- Oyun akışı modern Swift API'leriyle sadeleştirildi.
- Timer yönetimi daha güvenli hale getirildi.
- Rastgele meyve seçimi güncel yöntemle iyileştirildi.
