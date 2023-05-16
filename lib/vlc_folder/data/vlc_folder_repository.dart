import 'dart:convert';
import 'package:http/http.dart' as http;

class VLCStatusRepository{
  final String ipAddress;
  late final String _password;
  final String vlcPort;
  final String _vlcBrowsePathPrefix = "requests/browse.json?";    //"/requests/browse.json?";
  final String _vlcBrowseDefaultPath = "uri=file%3A%2F%2F%2F";
  final String _vlcBrowseDrivesPath = "uri=file%3A%2F%2F%2F";

VLCStatusRepository(
      {required this.ipAddress,
      this.vlcPort = "8080",
      required String vlcPassword}) {
    _password = base64Url.encode(utf8.encode("" + ":" + vlcPassword));
  }


  

Future<void> getHomeFolderData() async {
  var url = Uri.https("$ipAddress:$vlcPort", _vlcBrowsePathPrefix+_vlcBrowseDefaultPath);
  // var response = http.post(url);
  // var getResponse = http.get(url);
  // print(getResponse);
  print(await http.read(url));
}

}