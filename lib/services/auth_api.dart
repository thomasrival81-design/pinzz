import 'dart:convert';
import 'package:http/http.dart' as http;

/// Set this to your deployed HTTPS API URL before building the APK.
const String apiBaseUrl = String.fromEnvironment(
  'PINZX_API_URL',
  defaultValue: 'http://127.0.0.1:4113',
);

class AuthResult {
  const AuthResult({required this.ok, required this.message, this.token});
  final bool ok;
  final String message;
  final String? token;
}

class AuthApi {
  static Future<AuthResult> login(String username, String password) async {
    if (apiBaseUrl.contains('http://127.0.0.1:4113')) {
      return const AuthResult(ok: false, message: 'API belum dikonfigurasi.');
    }
    try {
      final response = await http
          .post(Uri.parse('$apiBaseUrl/auth/login'),
              headers: {'Content-Type': 'application/json', 'Accept': 'application/json'},
              body: jsonEncode({'username': username.trim(), 'password': password}))
          .timeout(const Duration(seconds: 15));
      final Map<String, dynamic> data = jsonDecode(response.body) as Map<String, dynamic>;
      return AuthResult(
        ok: response.statusCode == 200 && data['ok'] == true,
        message: (data['message'] ?? 'Login gagal.').toString(),
        token: data['token']?.toString(),
      );
    } catch (_) {
      return const AuthResult(ok: false, message: 'API tidak dapat dihubungi. Coba lagi.');
    }
  }
}
