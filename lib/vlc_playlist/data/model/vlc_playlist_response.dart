import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_item.dart';

class VlcPlaylistResponse {
  List<VlcPlaylistItem>? playlist;
  List<VlcPlaylistItem>? mediaLibrary;
  List<VlcPlaylistItem>? somethingElse;
  String errorMessage = "";

  VlcPlaylistResponse();

  VlcPlaylistResponse.fromJson(Map<String, dynamic> json) {
    if (json['children'] != null) {
      json['children'].forEach((v) {
        var childJson = v; //jsonDecode(v.toString());
        if (childJson['name'] == "Playlist") {
          if (childJson['children'] != null) {
            playlist = <VlcPlaylistItem>[];
            childJson['children'].forEach((v) {
              playlist!.add(VlcPlaylistItem.fromJson(v));
            });
          }
        } else if (childJson['name'] == "Media Library") {
          if (childJson['children'] != null) {
            mediaLibrary = <VlcPlaylistItem>[];
            childJson['children'].forEach((v) {
              mediaLibrary!.add(VlcPlaylistItem.fromJson(v));
            });
          }
        }
      });
    }
  }
}
