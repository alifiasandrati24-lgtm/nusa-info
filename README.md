# NusaInfo – Aplikasi Informasi dan Pengumuman

## Deskripsi
NusaInfo merupakan aplikasi mobile berbasis Flutter yang digunakan untuk menampilkan daftar pengumuman, melihat detail pengumuman beserta komentar, dan menambahkan pengumuman baru. Aplikasi ini menggunakan REST API dari JSONPlaceholder.

## Fitur Aplikasi
1. Menampilkan daftar pengumuman dari API.
2. Menampilkan detail pengumuman.
3. Menampilkan komentar berdasarkan pengumuman.
4. Menambahkan pengumuman baru melalui formulir.
5. Validasi input judul dan isi pengumuman.
6. Menampilkan indikator loading.
7. Menampilkan pesan error ketika gagal mengambil data.
8. Menyediakan tombol Coba Lagi.
9. Memperbarui daftar pengumuman dengan tarik untuk memuat ulang.
10. Menampilkan SnackBar setelah pengumuman berhasil dikirim.

## Teknologi yang Digunakan
- Flutter
- Dart
- HTTP
- JSON
- JSONPlaceholder API

## API yang Digunakan
- GET `/posts` – Mengambil daftar pengumuman.
- GET `/posts/{id}/comments` – Mengambil komentar pengumuman.
- POST `/posts` – Mengirim pengumuman baru.

**Catatan:** JSONPlaceholder merupakan API simulasi. Data yang dikirim melalui POST tidak disimpan secara permanen.

## Struktur Folder
```text
lib/
├── models/
│   └── post.dart
├── services/
│   └── post_service.dart
├── screens/
│   ├── home_screen.dart
│   ├── detail_screen.dart
│   └── add_post_screen.dart
└── main.dart

screenshots/
├── home.png
├── detail.png
├── tambah_pengumuman.png
├── sukses_tambah.png
└── error_offline.png
```

## Tampilan Aplikasi

### 1. Halaman Home
![Halaman Home](screenshots/home.png)

### 2. Halaman Detail Pengumuman
![Detail Pengumuman](screenshots/detail.png)

### 3. Halaman Tambah Pengumuman
![Tambah Pengumuman](screenshots/tambah_pengumuman.png)

### 4. Bukti Berhasil Menambahkan Pengumuman
![Berhasil Menambahkan Pengumuman](screenshots/sukses_tambah.png)

### 5. Tampilan Error Saat Offline
![Error Offline](screenshots/error_offline.png)

## Cara Menjalankan Aplikasi
1. Clone repository.
2. Buka folder proyek di Visual Studio Code.
3. Jalankan perintah:
   ```bash
   flutter pub get
   ```
4. Jalankan aplikasi:
   ```bash
   flutter run
   ```

## Pengujian
Pemeriksaan kode menggunakan `flutter analyze` berhasil dengan hasil:

`No issues found!`

Pengujian aplikasi menggunakan `flutter test` berhasil dengan hasil:

`All tests passed!`

## Pengembang
**Nama:** Alifia Sandra  
**Program Studi:** Teknik Informatika
