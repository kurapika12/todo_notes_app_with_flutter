# 📝 MiniCommerce Todo & Notes App

Aplikasi manajemen tugas dan catatan pribadi yang dibangun dengan Flutter. Didesain dengan tema **clean & profesional** bernuansa black & white, mendukung mode gelap dan terang, serta menyimpan data secara lokal menggunakan SQLite.

## ✨ Fitur

- ✅ **Todo List** — tambah, edit, hapus, dan tandai selesai
- 🗒️ **Catatan** — tulis, edit, hapus catatan dengan label warna kategori
- 🔍 **Pencarian real-time** untuk todo maupun catatan
- 🌗 **Dark & Light Mode** — beralih tema kapan saja
- 🕒 **Tanggal & jam otomatis** tersimpan setiap catatan diperbarui
- ⚠️ **Konfirmasi hapus** sebelum menghapus todo atau catatan
- 💾 **Penyimpanan lokal** menggunakan SQLite (data tetap ada meski app ditutup)
- 🎨 UI modern dengan bottom sheet, animasi halus, dan swipe-to-delete

## 🛠️ Tech Stack

- **Flutter** — framework UI
- **Provider** — state management
- **SQLite (sqflite)** — database lokal
- **Google Fonts** — tipografi (Poppins)
- **flutter_slidable** — swipe action untuk todo
- **intl** — format tanggal & waktu
- **uuid** — generate ID unik

## 📂 Struktur Project
lib/
├── main.dart
├── theme/
│    └── app_theme.dart          # Tema black & white + label warna catatan
├── models/
│    ├── todo_model.dart
│    └── note_model.dart
├── services/
│    └── db_helper.dart          # SQLite setup
├── providers/
│    ├── todo_provider.dart
│    ├── note_provider.dart
│    └── theme_provider.dart
├── screens/
│    ├── home_screen.dart
│    ├── todo_screen.dart
│    └── note_screen.dart
└── widgets/
├── todo_tile.dart
├── note_card.dart
└── confirm_dialog.dart

## 🚀 Cara Menjalankan

```bash
# Clone repository
git clone https://github.com/username/todo_notes_app_with_flutter.git
cd todo_notes_app_with_flutter

# Install dependencies
flutter pub get

# Jalankan aplikasi
flutter run
```

## 📦 Build APK

```bash
flutter build apk --release
```

File APK hasil build ada di:
build/app/outputs/flutter-apk/app-release.apk

## 📱 Requirements

- Flutter SDK ^3.x
- Dart SDK ^3.x
- Android minSdkVersion 21+

## 📄 License

Project ini dibuat untuk keperluan pembelajaran/pribadi.
