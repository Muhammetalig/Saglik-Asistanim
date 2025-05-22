https://github.com/user-attachments/assets/43926441-cb95-4f56-9fdf-0d8d8ff54fb3


Sağlık Asistanı Uygulaması:
Sağlık Asistanı, kullanıcıların semptomlarına göre evde uygulanabilecek sağlık çözümleri ve beslenme önerileri sunan bir Flutter uygulamasıdır. Kullanıcılar, semptomlarını girerek, kişisel sağlık ihtiyaçlarına uygun öneriler alabilir ve günlük beslenme alışkanlıklarını iyileştirebilir.

Özellikler
Semptom Girişi: Kullanıcılar, yaşadıkları semptomları metin olarak girer.
Ev Çözüm Önerileri: Girdiği semptomlar doğrultusunda en etkili ev çözümleri sunulur.
Beslenme Önerileri: Her çözümle birlikte, sağlıklı beslenme önerileri ve önerilen gıdalar hakkında bilgi verilir.
Günlük Alışkanlık İyileştirme: Kullanıcılar, beslenme düzenlerini iyilestirerek sağlıklarını destekleyebilir.
Teknolojiler
Flutter: Mobil uygulama geliştirme framework'ü.
HTTP REST API çağrıları için.
Generative Language API: Semptomlar için öneriler almak amacıyla Google'ın Generative Language API kullanılmıştır.
Kurulum
Proje Kopyalama: Bu projeyi yerel makinenize klonlayın.

git clone https://github.com/Muhammetalig/saglik-asistani.git

Gerekli Paketlerin Kurulumu:
flutter pub get
Uygulamayı Çalıştırma: Uygulamayı çalıştırmak için aşağıdaki komutu kullanabilirsiniz:

flutter run

API Anahtarı
Google Generative Language API için bir API anahtarı gereklidir.
https://console.cloud.google.com/ üzerinden bir proje oluşturup API anahtarınızı alabilirsiniz.
API anahtarınızı uygulama içindeki apiUrl kısmına ekleyin.
Kullanıcı Arayüzü
Uygulama basit ve kullanıcı dostu bir arayüze sahiptir. Kullanıcılar, semptomları kolayca girebilir ve önerileri hızlıca alabilirler.

Semptom Girişi: Kullanıcılar metin kutusuna semptomlarını girer.
Öneriler: Uygulama, semptomlara uygun beslenme önerileri ve evde yapılabilecek çözümler listeler.
Yükleniyor Durumu: Veriler alınırken kullanıcıya bir yükleniyor animasyonu gösterilir.
Katkıda Bulunma
Bu projeye katkıda bulunmak isterseniz, issue açabilir ya da pull request gönderebilirsiniz.
