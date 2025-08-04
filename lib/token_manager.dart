import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class TokenManager {
  static const String _tokenKey = 'travelport_token';
  static const String _timeKey = 'token_time';

  /// Fetch and store token from SOAP API
  static Future<String?> fetchAndStoreToken() async {
    const url = 'https://boqoltravel.com/app/b2badminapi.asmx';
    final envelope = '''<?xml version="1.0" encoding="utf-8"?>
<soap:Envelope xmlns:xsi="http://www.w3.org/2001/XMLSchema-instance"
               xmlns:xsd="http://www.w3.org/2001/XMLSchema"
               xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <TravelPort_GetToken xmlns="http://tempuri.org/" />
  </soap:Body>
</soap:Envelope>''';

    try {
      final response = await http.post(
        Uri.parse(url),
        headers: {
          'Content-Type': 'text/xml; charset=utf-8',
          'SOAPAction': 'http://tempuri.org/TravelPort_GetToken',
        },
        body: envelope,
      );

      print('🔍 Raw API Response:\n${response.body}');

      if (response.statusCode == 200) {
        final rawXml = response.body;

        // Extract token from XML response
        final tokenMatch = RegExp(r'<TravelPort_GetTokenResult[^>]*>([^<]*)<\/TravelPort_GetTokenResult>', dotAll: true)
            .firstMatch(rawXml);
        final token = tokenMatch?.group(1)?.trim();

        if (token != null && token.isNotEmpty) {
          final prefs = await SharedPreferences.getInstance();
          await prefs.setString(_tokenKey, token);
          await prefs.setString(_timeKey, DateTime.now().toIso8601String());
          print('✅ Token extracted and stored: $token');
          return token;
        } else {
          print('❌ Token not found in response');
        }
      } else {
        print('❌ API Error: Status Code ${response.statusCode}');
      }
    } catch (e) {
      print('❌ Exception while fetching token: $e');
    }

    return null;
  }

  /// Retrieve stored token
  static Future<String?> getStoredToken() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString(_tokenKey);
    final timeStr = prefs.getString(_timeKey);

    if (token != null && token.isNotEmpty) {
      print('✅ Retrieved stored token: $token');
      if (timeStr != null) {
        final time = DateTime.tryParse(timeStr);
        final now = DateTime.now();

        if (time != null && now.difference(time).inMinutes < 10) {
          print('🕒 Token is still valid');
          return token;
        } else {
          print('⏰ Token expired, refreshing...');
          return await fetchAndStoreToken();
        }
      }
      return token;
    }

    print('❌ No token found locally');
    return await fetchAndStoreToken();
  }

  /// Clear stored token
  static Future<void> clearToken() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(_tokenKey);
    await prefs.remove(_timeKey);
    print('🧹 Token cleared');
  }
}
