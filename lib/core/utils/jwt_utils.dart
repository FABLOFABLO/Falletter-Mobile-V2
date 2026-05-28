import 'dart:convert';

class JwtUtils {
  static bool isExpired(
      String jwt, {
        Duration clockSkew = const Duration(seconds: 30),
      }) {
    try {
      final parts = jwt.split('.');
      if (parts.length != 3) return true;

      final payload = _decodeBase64Url(parts[1]);
      final map = jsonDecode(payload) as Map<String, dynamic>;
      final exp = map['exp'];
      if (exp is! num) return true;

      final expMs = (exp * 1000).toInt();
      final nowMs = DateTime.now().millisecondsSinceEpoch;

      return nowMs > (expMs - clockSkew.inMilliseconds);
    } catch (_) {
      return true;
    }
  }

  static String _decodeBase64Url(String input) {
    var normalized = input.replaceAll('-', '+').replaceAll('_', '/');
    while (normalized.length % 4 != 0) {
      normalized += '=';
    }
    return utf8.decode(base64Decode(normalized));
  }
}
