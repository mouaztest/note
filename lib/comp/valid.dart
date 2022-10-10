import 'package:sql_note/comp/message.dart';

validate(String val, int min, int max) {
  if (val.length > max) {
    return "$maxmessage $max";
  }
  if (val.isEmpty) {
    return "$emptymessage";
  }
  if (val.length < min) {
    return "$minmessage $min";
  }
}
