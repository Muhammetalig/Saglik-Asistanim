@override
Widget build(BuildContext context) {
  return Scaffold(
    appBar: AppBar(
        // ... mevcut AppBar kodu aynı kalacak ...
        ),
    body: Stack(
      // Burada Stack ekliyoruz
      children: [
        Container(
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
                    // ... mevcut semptom giriş container'ı aynı kalacak ...
                    ),
                SizedBox(height: 20),
                ElevatedButton.icon(
                    // ... mevcut buton aynı kalacak ...
                    ),
              ],
            ),
          ),
        ),
        if (_suggestion.isNotEmpty)
          DraggableScrollableSheet(
            initialChildSize: 0.4,
            minChildSize: 0.2,
            maxChildSize: 0.8,
            builder: (context, scrollController) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.3),
                      spreadRadius: 5,
                      blurRadius: 7,
                      offset: Offset(0, -3),
                    ),
                  ],
                ),
                child: Column(
                  children: [
                    Container(
                      padding: EdgeInsets.all(8),
                      child: Center(
                        child: Container(
                          width: 40,
                          height: 5,
                          decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 16),
                      child: Row(
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
                    ),
                    Divider(color: Colors.blue[100]),
                    Expanded(
                      child: ListView(
                        controller: scrollController,
                        padding: EdgeInsets.symmetric(horizontal: 16),
                        children:
                            _suggestion.split('•').skip(1).map((suggestion) {
                          if (suggestion.trim().isNotEmpty) {
                            return Padding(
                              padding: EdgeInsets.symmetric(vertical: 8),
                              child: Container(
                                decoration: BoxDecoration(
                                  color: Color(0xFF1E88E5).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(10),
                                  border: Border.all(
                                    color: Color(0xFF1E88E5).withOpacity(0.2),
                                    width: 1,
                                  ),
                                ),
                                padding: EdgeInsets.all(12),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                          height: 1.8,
                                          color: Colors.black87,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        }).toList(),
                      ),
                    ),
                  ],
                ),
              );
            },
          ),
      ],
    ),
  );
}
