# 🧢 TopiZak Store (Flutter + Firebase)

## 👤 Identitas Mahasiswa

**Nama:** Muhammad Abdul Rozak
**NIM:** 1123150006

---

# 🔗 LINK YouTube

https://youtu.be/efVho9XdKy8?si=jThy4Hoh1TadcGlT

---

# 📌 Deskripsi Aplikasi

TopiZak Store adalah aplikasi mobile berbasis Flutter yang digunakan sebagai platform e-commerce sederhana untuk penjualan topi secara online.

Aplikasi ini memiliki beberapa fitur utama seperti:

* 🔐 Login & Register (Email & Google Sign-In)
* 📧 Email Verification (Firebase Authentication)
* 🛍️ Catalog Produk Topi
* ❤️ Favorite / Wishlist Produk
* 🛒 Keranjang Belanja (Cart System)
* 💳 Checkout Produk
* 📦 Penyimpanan Data Pesanan ke Cloud Firestore
* 🌙 Dark Mode
* 👤 Profile User

---

# ⚙️ Teknologi yang Digunakan

Aplikasi ini menggunakan teknologi:

* Flutter (Frontend Mobile)
* Firebase Authentication
* Cloud Firestore
* Provider (State Management)
* Google Sign-In
* Firebase Core

---

# 🧠 Arsitektur Aplikasi

Struktur aplikasi menggunakan modular feature-based architecture dengan pembagian:

## 🔹 Core

Berisi:

* Theme Provider
* Konfigurasi global aplikasi

## 🔹 Features

Berisi fitur utama aplikasi:

* Authentication
* Catalog
* Cart
* Checkout
* Profile

---

# 🔥 Fitur Utama

## 🔐 Authentication

User dapat:

* Register akun
* Login menggunakan Email & Password
* Login menggunakan Google
* Verifikasi email menggunakan Firebase Authentication

---

## 🛍️ Catalog Produk

User dapat:

* Melihat daftar produk
* Membuka detail produk
* Menambahkan produk ke favorit
* Menambahkan produk ke cart

---

## 🛒 Cart System

Fitur cart memungkinkan user:

* Menambah quantity barang
* Mengurangi quantity barang
* Menghapus barang
* Melihat total harga realtime

---

## 💳 Checkout

Saat checkout:

* Data pesanan dikirim ke Cloud Firestore
* Sistem menyimpan:

    * user_id
    * produk
    * quantity
    * total harga
    * waktu transaksi

---

# 🔄 State Management

Aplikasi menggunakan Provider sebagai state management untuk mengelola:

* Cart
* Favorite
* Theme mode

Provider digunakan agar perubahan data dapat langsung memperbarui UI secara realtime menggunakan notifyListeners().

---

# 🔗 API & Firebase Integration

Aplikasi terintegrasi dengan Firebase untuk:

* Authentication
* Email Verification
* Database Firestore

Firebase digunakan untuk menyimpan:

* Data user
* Data pesanan
* Riwayat checkout

---

# 📱 Tampilan Aplikasi

Fitur utama aplikasi:

* Login & Register
* Home / Catalog
* Detail Produk
* Cart
* Checkout
* Success Page
* Profile Page

---

# 🙏 Penutup

TopiZak Store dibuat sebagai project aplikasi mobile e-commerce sederhana berbasis Flutter dengan integrasi Firebase dan Provider state management.
