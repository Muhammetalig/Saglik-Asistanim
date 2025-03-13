import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

void main() {
  runApp(HealthApp());
}

class HealthApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Sağlık Asistanı',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        scaffoldBackgroundColor: Colors.white,
        elevatedButtonTheme: ElevatedButtonThemeData(
          style: ElevatedButton.styleFrom(
            backgroundColor: Color(0xFF1E88E5),
            padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(30),
            ),
          ),
        ),
      ),
      home: SymptomInputScreen(),
    );
  }
}

class SymptomInputScreen extends StatefulWidget {
  @override
  _SymptomInputScreenState createState() => _SymptomInputScreenState();
}

class _SymptomInputScreenState extends State<SymptomInputScreen> {
  final TextEditingController _symptomsController = TextEditingController();
  String _suggestion = '';
  bool _isLoading = false;

  Future<void> getSuggestions() async {
    setState(() {
      _isLoading = true;
    });

    final String apiUrl =
        'https://generativelanguage.googleapis.com/v1beta/models/gemini-2.0-flash:generateContent?key=AIzaSyCtxlQPTxk0y9P9Q1cZouC8hK4UiEASwtw';

    try {
      final response = await http.post(
        Uri.parse(apiUrl),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          "contents": [
            {
              "parts": [
                {
                  "text": "Semptomlar: ${_symptomsController.text}. "
                      "Lütfen bu semptomlar için sadece en etkili 5 pratik ev çözümünü listele minumum biri tüketebileceği besinle ilgili olsun, günlük 3 öğün için beslenme önerisinde bulun önerinin sonunda da nedenini yaz öğünlerin ve nelerden kaçınması gerektiğini söyle. nokta dışında hiçbir özel karakter bulundurma cümlelerde(*)yıldız gibi."
                      "Her öneri en fazla bir cümle olsun. "
                      "Önerileri '• ' ile başlat."
                }
              ]
            }
          ]
        }),
      );
      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        setState(() {
          _suggestion = data['candidates'][0]['content']['parts'][0]['text'];
          _isLoading = false;

          // Yıldız işaretlerini ('*') kaldırıyoruz
          _suggestion = _suggestion.replaceAll('*', '');
        });
      } else {
        setState(() {
          _suggestion = 'Bir hata oluştu: ${response.statusCode}';
          _isLoading = false;
        });
      }
    } catch (e) {
      setState(() {
        _suggestion = 'Bir hata oluştu: $e';
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Color(0xFF1E88E5),
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.health_and_safety, color: Colors.white),
            SizedBox(width: 10),
            Text('Sağlık Asistanı',
                style: TextStyle(
                    color: Colors.white, fontWeight: FontWeight.bold)),
          ],
        ),
        centerTitle: true,
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              Color(0xFF1E88E5).withOpacity(0.1),
              Colors.white,
              Colors.white,
            ],
          ),
        ),
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: Column(
            children: [
              Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    colors: [Colors.white, Color(0xFFE3F2FD)],
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                  ),
                  borderRadius: BorderRadius.circular(15),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.blue.withOpacity(0.1),
                      blurRadius: 10,
                      spreadRadius: 5,
                    ),
                  ],
                ),
                child: Card(
                  elevation: 0,
                  color: Colors.transparent,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Padding(
                    padding: EdgeInsets.all(16.0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(
                              Icons.medical_information,
                              color: Color(0xFF1E88E5),
                              size: 28,
                            ),
                            SizedBox(width: 10),
                            Text(
                              'Semptomlarınız neler?',
                              style: TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                                color: Color(0xFF1E88E5),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(height: 12),
                        TextField(
                          controller: _symptomsController,
                          maxLines: 3,
                          decoration: InputDecoration(
                            hintText: 'Örn: başım ağrıyor, midem bulanıyor',
                            hintStyle: TextStyle(color: Colors.grey[400]),
                            filled: true,
                            fillColor: Colors.white,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(color: Colors.blue[200]!),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(12),
                              borderSide: BorderSide(
                                color: Color(0xFF1E88E5),
                                width: 2,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              SizedBox(height: 20),
              ElevatedButton.icon(
                onPressed: _isLoading ? null : getSuggestions,
                icon: Icon(_isLoading ? null : Icons.healing,
                    color: Colors.white),
                label: _isLoading
                    ? Row(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          SizedBox(width: 10),
                          Text(
                            'Analiz ediliyor...',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )
                    : Text('Önerileri Göster',
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        )),
              ),
              SizedBox(height: 20),
              if (_suggestion.isNotEmpty)
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Colors.white, Color(0xFFE3F2FD)],
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                      ),
                      borderRadius: BorderRadius.circular(15),
                      boxShadow: [
                        BoxShadow(
                          color: Colors.blue.withOpacity(0.1),
                          blurRadius: 10,
                          spreadRadius: 5,
                        ),
                      ],
                    ),
                    child: Card(
                      elevation: 0,
                      color: Colors.transparent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Container(
                        width: double.infinity,
                        padding: EdgeInsets.all(16.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Icon(
                                  Icons.medical_services,
                                  color: Color(0xFF1E88E5),
                                  size: 28,
                                ),
                                SizedBox(width: 10),
                                Text(
                                  'Öneriler',
                                  style: TextStyle(
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                    color: Color(0xFF1E88E5),
                                  ),
                                ),
                              ],
                            ),
                            Divider(color: Colors.blue[100]),
                            SizedBox(height: 10),
                            Expanded(
                              child: SingleChildScrollView(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    for (var suggestion
                                        in _suggestion.split('•').skip(1))
                                      Padding(
                                        padding:
                                            EdgeInsets.symmetric(vertical: 8),
                                        child: Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xFF1E88E5)
                                                .withOpacity(0.1),
                                            borderRadius:
                                                BorderRadius.circular(10),
                                          ),
                                          padding: EdgeInsets.all(12),
                                          child: Row(
                                            children: [
                                              Icon(
                                                Icons.check_circle,
                                                color: Color(0xFF1E88E5),
                                                size: 20,
                                              ),
                                              SizedBox(width: 10),
                                              Expanded(
                                                child: Text(
                                                  suggestion.trim(),
                                                  style: TextStyle(
                                                    fontSize: 16,
                                                    height:
                                                        1.8, // Daha rahat okuma için satır aralığını artırdım
                                                    color: Colors.black87,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                  ],
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
