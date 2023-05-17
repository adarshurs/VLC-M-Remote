import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';

class VLCBrowseRepository {
  final String ipAddress;
  late final String _password;
  final String vlcPort;
  final String _vlcBrowsePathPrefix =
      "requests/browse.json?"; //"/requests/browse.json?";
  final String _vlcBrowseDefaultPath = "uri=file%3A%2F%2F%2F";
  final String _vlcBrowseDrivesPath = "uri=file%3A%2F%2F%2F";

  VLCBrowseRepository(
      {required this.ipAddress,
      this.vlcPort = "8080",
      required String vlcPassword}) {
    _password = base64Url.encode(utf8.encode("" + ":" + vlcPassword));
  }

  Future<VlcBrowseResponse?> getFolderData(String? pathToBrowse) async {
    var url = Uri.https("$ipAddress:$vlcPort",
        _vlcBrowsePathPrefix + (pathToBrowse ?? _vlcBrowseDefaultPath));
    var response = await http.get(url);

    if (response.statusCode == 200) {
      var jsonResponse =
          jsonDecode(response.toString()) as Map<String, dynamic>;
      return VlcBrowseResponse.fromJson(jsonResponse);
    } else if (response.statusCode == 401) {
      VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
      vlcBrowseResponse.errorMessage = "IncorrectPassword";
      return vlcBrowseResponse;
    }
    VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
    vlcBrowseResponse.errorMessage = "NoResponse";
    return VlcBrowseResponse();
  }
}
