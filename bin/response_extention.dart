
import 'package:http/http.dart';
import 'helper.dart';

extension ResponseExtention on Response {
  dynamic get data => jDecode(this.body)["data"];

  dynamic get countData => jDecode(this.body)["data"]["count"];

  bool isSuccess() => this.statusCode < 300;
}
