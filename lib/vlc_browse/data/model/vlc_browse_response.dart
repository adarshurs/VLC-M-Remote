import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';

class VlcBrowseResponse {
  List<VlcBrowseItem>? folders;
  String? errorMessage;
  bool showAllFiles = false;

  VlcBrowseResponse({this.folders});

  final List<String> vlcSupportedFileExtensions = [
    ".asf",
    ".wmv",
    ".asf",
    ".wmv",
    ".au",
    ".avi",
    ".flv",
    ".mov",
    ".mp4",
    ".ogm",
    ".ogg",
    ".mkv",
    ".mka",
    ".ts",
    ".mpg",
    ".mpg",
    ".mp3",
    ".mp2",
    ".nsc",
    ".nsv",
    ".nut",
    ".ra",
    ".ram",
    ".rm",
    ".rv",
    ".rmbv",
    ".a52",
    ".dts",
    ".aac",
    ".flac",
    ".dv",
    ".vid",
    ".tta",
    ".tac",
    ".ty",
    ".wav",
    ".dts",
    ".wma",
    ".xa",
    ".dat",
    ".iso",
    ".m3u",
    ".pls",
    ".wpl",
    ".m4v",
    ".xspf",
    ".webm",
    ".rmvb",
    ".m3u8",
    ".rar",
    ".m4a",
    ".3gp",
    ".srt"
  ];

  VlcBrowseResponse.fromJson(Map<String, dynamic> json) {
    if (json['element'] != null) {
      folders = <VlcBrowseItem>[];
      errorMessage = null;
      json['element'].forEach((v) {
        var browseItemTemp = VlcBrowseItem.fromJson(v);
        if (browseItemTemp.type == "file") {
          var fileExtension = browseItemTemp.name
              ?.substring(browseItemTemp.name?.lastIndexOf(".") ?? 0);
          if (fileExtension == ".srt") {
            browseItemTemp.type = "subtitle";
          }
          // if (!showAllFiles) {
          //   if (vlcSupportedFileExtensions.contains(fileExtension)) {
          //     folders!.add(browseItemTemp);
          //   }
          // } else {
          //   folders!.add(browseItemTemp);
          // }

          if (showAllFiles ||
              vlcSupportedFileExtensions.contains(fileExtension)) {
            folders!.add(browseItemTemp);
          }
        } else {
          folders!.add(browseItemTemp);
        }
      });

      folders?.sort((a, b) {
        return a.name
            .toString()
            .toLowerCase()
            .compareTo(b.name.toString().toLowerCase());
      });

      folders?.sort((a, b) {
        return a.type
            .toString()
            .toLowerCase()
            .compareTo(b.type.toString().toLowerCase());
      });

      var backDirectoryPath = folders?[0]
          .path
          ?.substring(0, folders?[0].path?.lastIndexOf("/..") ?? 0);

      print(backDirectoryPath);

      //folders = folders?..reversed.toList();
    } else {
      errorMessage = "Error";
    }
  }
}
