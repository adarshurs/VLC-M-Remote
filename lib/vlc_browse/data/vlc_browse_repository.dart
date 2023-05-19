import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_response.dart';
import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_response.dart';

class VLCBrowseRepository {
  final String ipAddress;
  late final String _password;
  final String vlcPort;
  Socket? _socket;

  final String _vlcBrowsePathPrefix = "/requests/browse.json";

  final String _vlcBrowseDefaultPath =
      "file:///"; //"uri=file%3A%2F%2F%2F"; //"?uri=file:///";
  //final String _vlcBrowseDrivesPath = "uri=file%3A%2F%2F%2F";

  VLCBrowseRepository(
      {required this.ipAddress,
      this.vlcPort = "8080",
      required String vlcPassword}) {
    _password =
        vlcPassword; //base64Url.encode(utf8.encode("" + ":" + vlcPassword));
  }

  String get basicAuth {
    return 'Basic ${base64.encode(utf8.encode(':$_password'))}';
  }

  // Future<VlcBrowseResponse?> getFolderData(String? pathToBrowse) async {
  //   //_socket = Socket
  //   var url = Uri.http("$ipAddress:$vlcPort", _vlcBrowsePathPrefix);
  //   // var url = Uri.http("$ipAddress:$vlcPort", _vlcBrowsePathPrefix,
  //   //     {'uri': (pathToBrowse ?? _vlcBrowseDefaultPath)});
  //   print(url);
  //   var response = await http
  //       .get(url, headers: <String, String>{'authorization': basicAuth});
  //   print(response.statusCode);
  //   if (response.statusCode == 200) {
  //     // try {
  //     var jsonResponse = jsonDecode(response.body.toString());

  //     if (jsonResponse['children'] != null) {
  //       jsonResponse['children'].forEach((v) {
  //         print(v.toString());
  //       });
  //     }

  //     var temp = VlcPlaylistResponse.fromJson(jsonResponse);

  //     return VlcBrowseResponse.fromJson(jsonResponse);
  //     // } catch (e) {
  //     //   VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
  //     //   vlcBrowseResponse.errorMessage = "NoResponse";
  //     //   return VlcBrowseResponse();
  //     // }
  //   } else if (response.statusCode == 401) {
  //     VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
  //     vlcBrowseResponse.errorMessage = "IncorrectPassword";
  //     return vlcBrowseResponse;
  //   } else {
  //     VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
  //     vlcBrowseResponse.errorMessage = "NoResponse";
  //     return VlcBrowseResponse();
  //   }
  // }

  Future<VlcBrowseResponse?> getFolderData(String? pathToBrowse) async {
    var url = Uri.http("$ipAddress:$vlcPort", _vlcBrowsePathPrefix,
        {'uri': (pathToBrowse ?? _vlcBrowseDefaultPath)});

    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    //print(response.statusCode);

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body.toString());
        return VlcBrowseResponse.fromJson(jsonResponse);
      } catch (e) {
        VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
        vlcBrowseResponse.errorMessage = "NoResponse";
        return VlcBrowseResponse();
      }
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
