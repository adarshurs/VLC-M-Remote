import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';

class VLCBrowseRepository {
  final String ipAddress;
  late final String _password;
  final String vlcPort;
  final String _vlcBrowsePathPrefix =
      "/requests/status.json?"; //"/requests/browse.json?";
  final String _vlcBrowseDefaultPath = "uri=file%3A%2F%2F%2F"; //"uri=file:///";
  //final String _vlcBrowseDrivesPath = "uri=file%3A%2F%2F%2F";

  VLCBrowseRepository(
      {required this.ipAddress,
      this.vlcPort = "8080",
      required String vlcPassword}) {
    _password = base64Url.encode(utf8.encode("" + ":" + vlcPassword));
  }

  String get basicAuth {
    return 'Basic ${base64.encode(utf8.encode(':$_password'))}';
  }

  Future<VlcBrowseResponse?> getFolderData(String? pathToBrowse) async {
    var url = Uri.http("$ipAddress:$vlcPort",
        _vlcBrowsePathPrefix); //+ (pathToBrowse ?? _vlcBrowseDefaultPath));
    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    print(response.statusCode);
    if (response.statusCode == 200) {
      print(response.body);
      var jsonResponse =
          jsonDecode(response.body.toString()) as Map<String, dynamic>;
      return VlcBrowseResponse.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
      vlcBrowseResponse.errorMessage = "IncorrectPassword";
      return vlcBrowseResponse;
    } else {
      VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
      vlcBrowseResponse.errorMessage = "NoResponse";
      return VlcBrowseResponse();
    }
  }
}
