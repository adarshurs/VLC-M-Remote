import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';

class VlcBrowseResponse {
  List<VlcBrowseItem>? folders;
  String? errorMessage;

  VlcBrowseResponse({this.folders});

  VlcBrowseResponse.fromJson(Map<String, dynamic> json) {
    if (json['element'] != null) {
      folders = <VlcBrowseItem>[];
      errorMessage = null;
      json['element'].forEach((v) {
        folders!.add(VlcBrowseItem.fromJson(v));
      });
    } else {
      errorMessage = "Error";
    }
  }
}
