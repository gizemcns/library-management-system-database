# PostgreSQL Kütühane Veritabanı Yönetim Sistemi 📚

## 🌟 Proje Özeti

Bu proje, küçük ve orta ölçekli kütüphanelerin temel operasyonlarını yönetmek için tasarlanmış kapsamlı bir veritabanı yönetim sistemi (DBMS) çözümüdür. Sistem, otomatik stok takibi, kural bazlı ödünç/iade işlemleri ve gecikme cezalarının otomatik hesaplanması gibi gelişmiş veritabanı otomasyonu özelliklerini kullanır.

## 💻 Kullanılan Teknolojiler

| Kategori | Teknoloji | Açıklama |
| :--- | :--- | :--- |
| **Veritabanı Motoru** | **PostgreSQL (SQL)** | İlişkisel veritabanı motoru olarak seçilmiştir. Gelişmiş fonksiyon, prosedür ve trigger desteği sayesinde otomasyon ve karmaşık sorgulama ihtiyaçlarını karşılar. |
| **Veritabanı İstemcisi** | **DBeaver** | Veritabanı bağlantısı, şema yönetimi ve SQL komutlarının çalıştırılması için kullanılan güçlü ve evrensel veritabanı istemcisi. |
| **Görselleştirme** | **DrawSQL (ERD)** | Tablolar arasındaki ilişkilerin (Entity-Relationship Diagram - ERD) görselleştirilmesi ve şema tasarımının belgelenmesi için kullanılmıştır. |
| **Programlama Dili** | **PL/pgSQL** | PostgreSQL'e özgü prosedürel dil olup, Stored Procedure'lar ve Trigger Function'lar bu dil ile yazılmıştır. |

---

## 📋 Veritabanı İçeriği ve Yapısı

Veritabanı, kütüphane yönetiminin temel unsurlarını temsil eden 8 ana tablo ve bu tablolar arası ilişkilerle (Foreign Keys) kurulmuştur.

### Tablolar

1.  **`authors`**: Yazar bilgileri.
2.  **`publishers`**: Yayınevi bilgileri.
3.  **`categories`**: Kitapların tür/kategori bilgileri.
4.  **`books`**: Kitapların detayları ve mevcut stok miktarı.
5.  **`members`**: Kütüphane üye kayıtları.
6.  **`loans`**: Ödünç alma ve iade kayıtları (İşlem tablosu).
7.  **`reservations`**: Kitap rezervasyon kayıtları.
8.  **`fines`**: Gecikme ceza kayıtları.

### 🚀 Otomasyon Bileşenleri

Sistem, verimliliği artırmak ve insan hatasını azaltmak için aşağıdaki otomasyon öğelerini içerir:

#### 1. Triggerlar (Tetikleyiciler)
| Ad | Amaç |
| :--- | :--- |
| `decrease_stock_on_loan_trigger` | Kitap **ödünç alındığında** ilgili kitabın stok miktarını otomatik olarak **-1** düşürür. |
| `increase_stock_on_return_trigger` | Kitap **iade edildiğinde** ilgili kitabın stok miktarını otomatik olarak **+1** artırır. |
| `create_fine_on_late_return_trigger` | İade işlemi sırasında gecikme tespit edilirse, otomatik olarak `fines` tablosuna ceza kaydı oluşturur. |

#### 2. Stored Procedure'lar (PL/pgSQL Fonksiyonları)
* **`sp_borrow_book(member_id, book_id)`**: Kitap müsaitlik ve üye ödünç limit kontrollerini yaparak ödünç alma işlemini tek bir güvenli işlemde gerçekleştirir.
* **`sp_return_book(loan_id)`**: İade tarihini günceller ve ilgili Trigger'ları tetikleyerek stok güncelleme ve ceza hesaplama/kaydetme işlemlerini başlatır.

#### 3. Fonksiyonlar (Özel Hesaplamalar)
* **`calculate_fine(loan_id)`**: Ödünç ve iade tarihlerine bakarak gecikme gün sayısını ve toplam ceza miktarını hesaplar.
* **`book_availability(book_id)`**: Kitabın stok durumunu kontrol ederek ödünç alınabilir olup olmadığını döndürür.
* **`member_borrowed_count(member_id)`**: Üyenin o anda aktif olarak ödünç tuttuğu kitap sayısını döndürerek limit kontrolüne yardımcı olur.

#### 4. Görünümler (Views)
* **`top_borrowed_books`**: En çok ödünç alınan kitapları ve yazarlarını göstererek trend analizi sağlar.
* **`member_loan_statistics`**: Üyelerin toplam ödünç alma sayıları, aktif ödünçleri ve ödenmemiş ceza tutarları gibi istatistiklerini raporlar.

---

## 🛠️ Kurulum ve Kullanım

1.  **Veritabanı Oluşturma:** PostgreSQL sunucunuzda yeni bir veritabanı oluşturun.
2.  **Şema Uygulama:** Projenin DDL (Data Definition Language) komutlarını (CREATE TABLE) DBeaver aracılığıyla veritabanında çalıştırın.
3.  **Otomasyonu Kurma:** CREATE FUNCTION, CREATE TRIGGER ve CREATE PROCEDURE komutlarını sırasıyla çalıştırarak otomasyon bileşenlerini devreye alın.
4.  **Test Etme:** `sp_borrow_book` ve `sp_return_book` prosedürlerini kullanarak sistemi test edin ve Trigger'ların stok ve ceza kayıtlarını otomatik güncellediğini kontrol edin.



## 👨‍💻 Geliştirici

Gizem Can Bayındır
