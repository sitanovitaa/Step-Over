## Step Over - Aplikasi E-commerce Sepatu
Step Over adalah prototipe aplikasi mobile e-commerce yang berfokus pada penjualan sepatu, dibangun sepenuhnya menggunakan Flutter. Aplikasi ini menampilkan alur kerja lengkap mulai dari halaman pembuka, penjelajahan produk, hingga proses checkout.

## 📸 Tampilan Aplikasi & Penjelasan
Berikut adalah tampilan dari setiap layar utama dalam aplikasi Step Over beserta penjelasan singkat fungsinya.

## 1. Splash & Welcome Screen
Splash Screen: Tampilan awal yang muncul saat aplikasi pertama kali dibuka, menampilkan logo "Step Over" dengan latar belakang gradien yang elegan untuk memberikan kesan pertama yang kuat.

Welcome Screen: Halaman penyambut setelah splash screen, memberikan opsi navigasi yang jelas kepada pengguna untuk masuk (Login) atau mendaftar (Sign Up).

|  Splash Screen | Welcome Screen |
|------------|-----------|
| <img src="screenshots/1.jpg" width="280"> | <img src="screenshots/2.jpg" width="280"> |


## 2. Login Screen
Halaman ini didesain untuk pengguna yang sudah memiliki akun. Terdapat form untuk memasukkan username dan password, serta opsi untuk melanjutkan dengan akun Google.
| <img src="screenshots/3.jpg> |

## 3. Dashboard
Halaman utama aplikasi tempat pengguna dapat menjelajahi produk. Fitur utamanya meliputi search bar, banner promosi interaktif, daftar kategori produk, dan bagian penawaran populer.
| <img src="screenshots/4.jpg> |

## 4. Halaman Detail Produk
Ketika pengguna mengklik sebuah produk, halaman ini akan muncul. Halaman ini menampilkan gambar produk yang besar, deskripsi lengkap, harga, serta pilihan ukuran sepatu yang dinamis dan interaktif.
| <img src="screenshots/5.jpg> |

## 5. Keranjang Belanja (Shopping Cart)
Menampilkan semua item yang telah ditambahkan oleh pengguna. Setiap item menunjukkan gambar, nama, ukuran yang dipilih, serta pengatur jumlah. Subtotal di bagian bawah dihitung secara otomatis berdasarkan jumlah dan harga barang.
| <img src="screenshots/6.jpg> |

## 6. Alur Pembayaran & Halaman Sukses
Alur Pembayaran: Proses checkout multi-langkah yang memandu pengguna melalui pemilihan metode pengiriman, pengisian alamat, hingga pemilihan metode pembayaran.

| Pilih Pengiriman | Isi Alamat | Pilih Pembayaran |
|------------------|------------|------------------|
| ![](screenshots/7.jpg) | ![](iscreenshots/8.jpg) | ![](screenshots/9.jpg) |

Halaman Sukses: Tampilan konfirmasi yang muncul setelah pesanan berhasil dibuat, menampilkan gambar produk yang dibeli.
| <img src="screenshots/10.jpg> |



## ✨ Fitur Utama
Aplikasi ini mencakup alur pengguna yang lengkap dengan fitur-fitur berikut:

Splash Screen: Tampilan pembuka dengan logo aplikasi.

Autentikasi: Halaman selamat datang (Welcome Screen) dengan opsi untuk Login dan Sign Up.

Dashboard Utama:

Search Bar dengan filter.

Banner promosi Flash Sale yang interaktif.

Daftar produk berdasarkan Kategori.

Daftar produk Popular Deals.

Halaman Detail Produk:

Tampilan gambar produk yang besar dan jelas.

Informasi detail (nama, harga, deskripsi).

Pilihan ukuran sepatu yang dinamis.

Keranjang Belanja (Shopping Cart):

Menampilkan daftar produk yang ditambahkan.

Menampilkan ukuran yang dipilih.

Pengatur jumlah barang (quantity stepper) untuk setiap item.

Kalkulasi Subtotal yang dinamis.

Alur Pembayaran (Checkout Flow):

Proses multi-step (Pengiriman, Alamat, Pembayaran).

Stepper visual untuk melacak kemajuan.

Pilihan metode pengiriman dan pembayaran.

Halaman Sukses: Tampilan konfirmasi setelah pesanan berhasil dibuat.

## 🛠️ Teknologi & Dependensi
Proyek ini dibangun menggunakan:

Framework: Flutter

Bahasa: Dart

Dependensi Utama:

google_fonts: Untuk menggunakan font kustom dari Google Fonts (Poppins).

intl: Untuk format angka menjadi mata uang (Rupiah).

