## Jawaban Pertanyaan README

### 1. Jelaskan apa itu *widget tree* pada Flutter dan bagaimana hubungan parent–child (induk–anak) bekerja antar widget.

Di Flutter, seluruh tampilan aplikasi dibentuk dari susunan widget yang bertingkat seperti pohon, yang disebut **widget tree**.  
- Di bagian paling atas ada **root widget** (pada proyek ini: `MaterialApp`), lalu di bawahnya ada widget lain seperti `Scaffold`, `AppBar`, `Column`, `Text`, dan seterusnya.  
- Setiap widget yang berada di dalam widget lain disebut **child**, sedangkan widget yang menaunginya disebut **parent**.

Hubungan parent–child bekerja seperti ini:
- **Parent** menentukan struktur besar UI (misalnya `Scaffold` mengatur kerangka layar, `Column` menyusun anak-anaknya secara vertikal).
- **Child** hanya mengatur tampilan dirinya sendiri, tetapi ditempatkan dan di-*constraint* oleh parent-nya (misalnya `Text` diletakkan di dalam `Column` dan diposisikan sesuai aturan `Column`).
- Data atau properti biasanya mengalir dari parent ke child melalui parameter konstruktor.

Dengan struktur seperti ini, Flutter bisa dengan mudah melakukan *rebuild* hanya pada bagian pohon yang berubah ketika UI diperbarui.


### 2. Sebutkan semua widget yang kamu gunakan dalam proyek ini dan jelaskan fungsinya.

Berikut widget yang digunakan pada proyek **Richshop** ini:

- **`MyApp` (StatelessWidget)**  
  Widget kustom sebagai *entry point* UI. Di dalamnya terdapat `MaterialApp` yang mengatur tema dan halaman awal.

- **`MyHomePage` (StatelessWidget)**  
  Halaman utama aplikasi Richshop. Menampilkan identitas pemilik dan tiga tombol menu produk.

- **`MaterialApp`**  
  Menjadi *root widget* aplikasi. Mengatur:
  - judul aplikasi (`title`),
  - tema global (`theme`),
  - serta halaman awal (`home` = `MyHomePage`).

- **`Scaffold`**  
  Menyediakan kerangka dasar tampilan layar: tempat untuk `AppBar`, `body`, dan komponen lain seperti `FloatingActionButton` atau `SnackBar`.

- **`AppBar`**  
  Bilah atas (top bar) yang menampilkan judul aplikasi “Richshop”.

- **`Padding`**  
  Memberikan jarak di tepi halaman agar isi layar tidak menempel langsung ke pinggir layar.

- **`Column`**  
  Menyusun widget-widget di dalamnya secara vertikal (dari atas ke bawah): teks identitas dan tombol-tombol menu.

- **`Text`**  
  Menampilkan tulisan seperti “Selamat datang di Richshop!”, nama, NPM, kelas, dan judul menu.

- **`SizedBox`**  
  Memberikan jarak vertikal antar elemen (seperti antara teks dan tombol) sehingga tata letak lebih rapi.

- **`ElevatedButton.icon` / `ElevatedButton`**  
  Tombol interaktif yang dapat ditekan. Pada proyek ini dipakai untuk tiga menu:
  - All Products  
  - My Products  
  - Create Product  

  Versi `.icon` digunakan agar tombol memiliki ikon dan teks sekaligus.

- **`Icon`**  
  Menampilkan ikon (misalnya `Icons.list_alt`, `Icons.shopping_bag`, `Icons.add_circle_outline`) di dalam tombol.

- **`SnackBar`**  
  Widget kecil yang muncul sementara di bagian bawah layar untuk menampilkan pesan ketika tombol ditekan, misalnya:
  - “Kamu telah menekan tombol All Products”, dan seterusnya.


### 3. Apa fungsi dari widget `MaterialApp`? Jelaskan mengapa widget ini sering digunakan sebagai widget root.

`MaterialApp` adalah widget yang:
- Mengaktifkan dan menerapkan **Material Design** di aplikasi Flutter.
- Menyediakan pengaturan global seperti:
  - `title` aplikasi,
  - `theme` (warna, font, dsb.),
  - `home` (halaman pertama),
  - *routing* antar halaman, dan lain-lain.

Karena `MaterialApp` menjadi wadah utama yang mengatur tampilan dan tema seluruh aplikasi, widget ini **sering digunakan sebagai widget root**. Dengan begitu, semua widget di bawahnya bisa menggunakan komponen Material (seperti `Scaffold`, `AppBar`, `ElevatedButton`, `SnackBar`, dll) dengan konsisten.


### 4. Jelaskan perbedaan antara `StatelessWidget` dan `StatefulWidget`. Kapan kamu memilih salah satunya?

**`StatelessWidget`**  
- Bersifat **tidak memiliki state internal** yang berubah-ubah seiring waktu.  
- Tampilan hanya bergantung pada data yang diberikan lewat konstruktor.  
- Cocok untuk UI yang statis atau tidak berubah setelah dibuat (contoh: teks judul, tombol sederhana, ikon, halaman yang hanya menampilkan informasi tetap).  
- Di proyek ini, `MyApp` dan `MyHomePage` menggunakan `StatelessWidget`.

**`StatefulWidget`**  
- Memiliki objek `State` terpisah yang menyimpan **state dinamis**.  
- Ketika state berubah (melalui `setState()`), widget akan di-*rebuild* sehingga tampilan mengikuti perubahan data.  
- Cocok untuk fitur yang butuh interaksi kompleks seperti form yang berubah, animasi, counter, daftar yang bisa difilter, dsb.

**Pemilihan:**
- Gunakan **`StatelessWidget`** jika tampilan tidak berubah secara dinamis (hanya menampilkan data statis atau data dari luar tanpa perlu diubah di dalam widget tersebut).
- Gunakan **`StatefulWidget`** jika kamu membutuhkan perubahan UI ketika ada event (klik, input, API response) yang mengubah data di dalam widget itu sendiri.


### 5. Apa itu `BuildContext` dan mengapa penting di Flutter? Bagaimana penggunaannya di metode `build`?

`BuildContext` adalah objek yang:
- Merepresentasikan **posisi suatu widget di dalam widget tree**.
- Digunakan Flutter untuk mencari informasi yang terkait dengan posisi tersebut, misalnya:
  - tema (`Theme.of(context)`),
  - `Scaffold` terdekat,
  - `Navigator` untuk pindah halaman,
  - dan berbagai *inherited widget* lainnya.

Penting karena:
- Banyak API Flutter yang memerlukan `BuildContext` untuk bekerja dengan benar, terutama yang bergantung pada struktur widget tree di atasnya.

Penggunaan di metode `build`:
- Setiap widget yang mengoverride `build(BuildContext context)` menerima `context` sebagai parameter.  
- Di dalam `build`, kita bisa memakai `context` untuk:
  - Mengakses tema: `Theme.of(context).textTheme...`
  - Menampilkan `SnackBar`: `ScaffoldMessenger.of(context).showSnackBar(...)`
  - Menampilkan dialog, berpindah halaman, dll.

Pada proyek ini, `context` dipakai antara lain ketika memanggil `ScaffoldMessenger.of(context)` dan `Theme.of(context)`.


### 6. Jelaskan konsep "hot reload" di Flutter dan bagaimana bedanya dengan "hot restart".

**Hot reload**
- Menyuntikkan perubahan kode Dart ke aplikasi yang **sedang berjalan** tanpa menghentikan aplikasi.  
- Flutter akan melakukan *rebuild* pada widget tree yang terdampak, tetapi **state aplikasi tetap dipertahankan** (misalnya nilai counter, halaman yang sedang dibuka, dsb.).  
- Cocok untuk mengubah UI, teks, layout, dan logika yang tidak mengubah struktur awal aplikasi.

**Hot restart**
- Mengulang aplikasi dari awal dengan menjalankan kembali fungsi `main()`.  
- Semua state yang sedang tersimpan **hilang** dan kembali ke kondisi awal seperti baru dijalankan.  
- Dipakai ketika mengubah kode yang mempengaruhi inisialisasi awal aplikasi atau ketika state sudah “berantakan” dan ingin mulai dari nol lagi.

Singkatnya:
- **Hot reload** → cepat, mempertahankan state, enak untuk eksperimen UI.  
- **Hot restart** → memulai ulang aplikasi, menghapus seluruh state dan menjalankan ulang dari awal.



## Tugas 8

### 1. Perbedaan `Navigator.push()` dan `Navigator.pushReplacement()`

`Navigator.push()` menambahkan (*push*) halaman baru ke atas tumpukan (*navigation stack*).  
Halaman sebelumnya tetap berada di bawahnya sehingga pengguna masih bisa kembali dengan tombol *back*.

`Navigator.pushReplacement()` menggantikan (*replace*) halaman saat ini dengan halaman baru.  
Halaman yang digantikan dihapus dari stack sehingga pengguna **tidak** bisa kembali ke halaman tersebut dengan tombol *back*.

Dalam konteks aplikasi Richshop (sebelumnya Football Shop):

- `Navigator.push()` cocok digunakan ketika:
  - Berpindah dari halaman menu utama ke halaman detail/form, dan kita **masih ingin mengizinkan** pengguna kembali ke halaman sebelumnya.
  - Contoh: tombol **Create Product** yang membuka halaman form tambah produk baru. Pengguna masih boleh kembali ke halaman utama setelah melihat atau mengisi form.

- `Navigator.pushReplacement()` cocok digunakan ketika:
  - Halaman lama tidak lagi relevan setelah tindakan tertentu, sehingga **tidak perlu** bisa dikunjungi kembali.
  - Contoh kasus umum (meskipun tidak diimplementasikan di tugas ini) adalah berpindah dari halaman **login** ke **home** setelah autentikasi berhasil, atau dari **splash screen** ke **home**. Kita tidak ingin pengguna kembali ke login/splash dengan tombol *back*.


### 2. Pemanfaatan hierarki widget (`Scaffold`, `AppBar`, `Drawer`) untuk struktur halaman

Hierarki widget membantu menjaga struktur halaman yang konsisten di seluruh aplikasi:

- **`Scaffold`**  
  Digunakan sebagai kerangka utama di setiap halaman (`MyHomePage` dan `AddProductPage`).  
  `Scaffold` menyediakan area standar untuk:
  - `appBar`
  - `body`
  - (opsional) `floatingActionButton`, `drawer`, `bottomNavigationBar`, dan lain-lain.  

  Dengan menjadikan `Scaffold` sebagai parent di setiap halaman, tata letak aplikasi menjadi seragam dan mudah dikembangkan.

- **`AppBar`**  
  Ditempatkan di dalam `Scaffold` sebagai `appBar` pada kedua halaman.  
  Fungsinya:
  - Menampilkan judul halaman (misalnya “Richshop” dan “Tambah Produk Baru”).
  - Menjadi titik orientasi pengguna sehingga mereka selalu tahu sedang berada di halaman apa.
  - Menjaga konsistensi visual di bagian atas layar.

- **`Drawer`**  
  Pada tugas ini saya belum mengaktifkan `Drawer`, tetapi secara konsep:
  - `Drawer` dapat digunakan di dalam `Scaffold` untuk menyediakan menu navigasi global (misalnya daftar kategori, profil, pengaturan).
  - Dengan `Drawer`, struktur halaman tetap konsisten karena semua halaman tetap menggunakan pola `Scaffold + AppBar + Drawer`, hanya isi `body` yang berubah.

Dengan memanfaatkan hierarki ini, tampilan aplikasi terasa terstruktur: ada kerangka yang sama, sementara konten di dalam `body` menyesuaikan kebutuhan tiap halaman.


### 3. Kelebihan layout widget (`Padding`, `SingleChildScrollView`, `ListView`) dan contoh penggunaannya

Layout widget membantu mengatur posisi dan perilaku elemen UI agar nyaman digunakan:

- **`Padding`**
  - Menambah jarak di sekitar widget sehingga elemen tidak “menempel” ke tepi layar.
  - Di aplikasi:
    - `Padding` digunakan pada `MyHomePage` dan `AddProductPage` untuk memberi jarak antara isi halaman dengan tepi layar.
    - Hal ini membuat teks identitas dan form tambah produk lebih mudah dibaca dan terasa lega.

- **`SingleChildScrollView`**
  - Memungkinkan seluruh konten di-*scroll* walaupun dibangun menggunakan `Column`.
  - Sangat penting untuk halaman form yang tinggi, agar tidak terjadi *overflow* di layar kecil.
  - Di aplikasi:
    - `AddProductPage` membungkus `Form` di dalam `SingleChildScrollView`.  
      Ketika form tambah produk berisi banyak field, pengguna tetap bisa menggulir ke atas/bawah tanpa menimbulkan error overflow.

- **`ListView`**
  - Menyediakan tampilan daftar yang dapat di-*scroll* dan lebih efisien untuk banyak item.
  - Cocok untuk menampilkan list produk, riwayat pesanan, atau daftar kategori.
  - Pada tugas ini, list produk belum diimplementasikan, tetapi jika nanti Richshop menampilkan daftar “All Products” atau “My Products”, `ListView` akan menjadi pilihan utama karena:
    - Mendukung *lazy loading*,
    - Lebih fleksibel untuk item yang jumlahnya dinamis.

Dengan mengkombinasikan `Padding`, `SingleChildScrollView`, dan (kelak) `ListView`, tampilan form dan halaman lain menjadi lebih responsif dan nyaman digunakan di berbagai ukuran layar.


### 4. Penyesuaian warna tema agar konsisten dengan brand toko

Warna tema membantu membangun identitas visual yang konsisten:

- Di aplikasi Richshop saya menggunakan **`ThemeData`** dengan `ColorScheme.fromSeed(seedColor: Colors.blue)` sebagai dasar tema.
- Warna utama (biru) dipakai secara konsisten untuk:
  - `AppBar`,
  - tombol utama (melalui `ElevatedButtonTheme`),
  - elemen lain yang memerlukan aksen primer.

Selain itu:

- **Latar belakang** aplikasi dibuat sedikit abu-abu (`scaffoldBackgroundColor: Colors.grey[100]`) agar konten utama (Card, form, dan tombol) terlihat menonjol.
- **Tombol menu** menggunakan variasi warna yang tetap selaras:
  - Biru untuk **All Products**,
  - Hijau untuk **My Products**,
  - Merah untuk **Create Product**.  

  Meskipun berbeda warna, gaya tombol (bentuk, ukuran font, dan radius) tetap konsisten melalui `ElevatedButtonTheme`, sehingga masih terasa sebagai bagian dari satu brand yang sama.

Dengan cara ini, aplikasi memiliki:
- Palet warna utama yang konsisten (brand Richshop),
- Aksen warna yang terkontrol untuk membedakan fungsi tombol,
- Tampilan yang rapi dan mudah dikenali sebagai satu identitas toko.
