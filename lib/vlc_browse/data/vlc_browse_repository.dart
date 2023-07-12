import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_response.dart';

class VLCBrowseRepository {
  VLCServer connectedVLCServer;

  final String _vlcBrowsePathPrefix =
      "/requests/browse.json"; //no need to use '?' with the http package

  // final String _vlcBrowseDefaultPath = "file:///";
  // //"uri=file%3A%2F%2F%2F"; //"?uri=file:///";
  // final String _vlcBrowseDrivesPath = "uri=file%3A%2F%2F%2F";

  VLCBrowseRepository({required this.connectedVLCServer});

  String get basicAuth {
    String password = connectedVLCServer.vlcPassword ?? "";
    return 'Basic ${base64.encode(utf8.encode(':$password'))}';
  }

  Future<VlcBrowseResponse?> getFolderData(String? pathToBrowse) async {
    String ipAddress = connectedVLCServer.ipAddress;
    String vlcPort = connectedVLCServer.vlcPort;
    var url = Uri.http("$ipAddress:$vlcPort", _vlcBrowsePathPrefix,
        {'uri': (pathToBrowse ?? VLCBrowseConstants.vlcBrowseDefaultPath)});

    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    //print(response.statusCode);

    if (response.statusCode == 200) {
      try {
        var jsonResponse = jsonDecode(response.body.toString());
        return VlcBrowseResponse.fromJson(jsonResponse);
      } catch (e) {
        VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
        vlcBrowseResponse.errorMessage = "ParsingError";
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

  Future<void> postPlayBrowseItemRequest(String? uriToPlay) async {
    String ipAddress = connectedVLCServer.ipAddress;
    String vlcPort = connectedVLCServer.vlcPort;

    var bb = VLCBrowseConstants.playBrowseItemPrefix;
    var bbb = uriToPlay ?? "";

    var url = Uri.http(
        "$ipAddress:$vlcPort", "/requests/status.json", {bb: uriToPlay ?? ""});

    var response = await http
        .get(url, headers: <String, String>{'authorization': basicAuth});
    //print(response.statusCode);

    if (response.statusCode == 200) {
      print("posted");
    } else if (response.statusCode == 401) {
      VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
      vlcBrowseResponse.errorMessage = "IncorrectPassword";
    } else {
      VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();
      vlcBrowseResponse.errorMessage = "NoResponse";
      // return VlcBrowseResponse();
    }
  }
}

class VLCBrowseConstants {
  static String vlcBrowseDefaultPath = "file:///";
  //"uri=file%3A%2F%2F%2F"; //"?uri=file:///";
  static String vlcBrowseDrivesPath = "file:///"; //"file%3A%2F%2F%2F";

  //no need to add '=' for http package
  // original "command=in_play&input=";
  static String playBrowseItemPrefix = "command=in_play&input=";

  //no need to add '=' for http package
  static String addToPlaylistBrowseItemPrefix =
      "command=in_enqueue&input="; //"command=in_enqueue&input=";

  //no need to add '=' for http package
  static String addSubtitleBrowseItemPrefix =
      "command=addsubtitle&val="; //"command=addsubtitle&val="

  static String playPlaylistIDPrefix = "command=pl_play&id=";

  static String removeFromPlaylistIDPrefix = "command=pl_delete&id=";

  static String emptyPlaylistPrefix = "command=pl_empty";
}
