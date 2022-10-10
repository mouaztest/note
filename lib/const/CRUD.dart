import 'dart:io';

import 'package:http/http.dart' as http;
import 'dart:convert';
import 'package:path/path.dart';

String _basicAuth = 'Basic ' + base64Encode(utf8.encode('mouaz:mouaz12345'));

Map<String, String> myheaders = {'authorization': _basicAuth};

class CRUD {
  getRequest(String url) async {
    try {
      var response = await http.get(Uri.parse(url));
      if (response.statusCode == 200) {
        var bodyresponse = jsonDecode(response.body);
        return bodyresponse;
      } else {
        print('error${response.statusCode}');
      }
    } catch (e) {
      print('ERRoR $e');
    }
  }

  postRequest(String url, Map data) async {
    try {
      var response =
          await http.post(Uri.parse(url), body: data, headers: myheaders);
      if (response.statusCode == 200) {
        var bodyresponse = jsonDecode(response.body);
        return bodyresponse;
      } else {
        print('error${response.statusCode}');
      }
    } catch (e) {
      print('ERRoR $e');
    }
  }

  postRequestFile(String url, Map data, File file) async {
    var request = http.MultipartRequest("POST", Uri.parse(url));
    var length = await file.length();
    var stream = http.ByteStream(file.openRead());
    var multifile = http.MultipartFile("file", stream, length,
        filename: basename(file.path));
    request.files.add(multifile);
    request.headers.addAll(myheaders);
    data.forEach((key, value) {
      request.fields[key] = value;
    });

    var myrequest = await request.send();

    var myRespon = await http.Response.fromStream(myrequest);
    if (myrequest.statusCode == 200) {
      return jsonDecode(myRespon.body);
    } else {
      print("Error${myrequest.statusCode}");
    }
  }
}
