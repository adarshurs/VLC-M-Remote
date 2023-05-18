import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_item.dart';

class VlcPlaylistResponse {
  List<VlcPlaylistItem>? folders;
  String? errorMessage;

  VlcPlaylistResponse({this.folders});

  VlcPlaylistResponse.fromJson(Map<String, dynamic> json) {
    if (json['element'] != null) {
      folders = <VlcPlaylistItem>[];
      errorMessage = null;
      json['element'].forEach((v) {
        folders!.add(VlcPlaylistItem.fromJson(v));
      });
    } else {
      errorMessage = "Error";
    }
  }
}
