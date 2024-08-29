import 'dart:convert';

String encodeUtf8(String content) {
  return String.fromCharCodes(Utf8Encoder().convert(content));
}
dynamic jDecode(String json) {
  return jsonDecode(convertUtf8(json));
}
String convertUtf8(String content) {
  return Utf8Decoder(allowMalformed: true).convert(content.codeUnits);
}
