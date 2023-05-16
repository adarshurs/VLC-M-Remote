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

class VlcBrowseItem{
  String? type;
  String? path;
  String? name;
  int? accessTime;
  int? uid;
  int? creationTime;
  int? gid;
  int? modificationTime;
  int? mode;
  String? uri;
  int? size;

  VlcBrowseItem(
      {this.type,
      this.path,
      this.name,
      this.accessTime,
      this.uid,
      this.creationTime,
      this.gid,
      this.modificationTime,
      this.mode,
      this.uri,
      this.size});

  VlcBrowseItem.fromJson(Map<String, dynamic> json) {
    type = json['type'];
    path = json['path'];
    name = json['name'];
    accessTime = json['access_time'];
    uid = json['uid'];
    creationTime = json['creation_time'];
    gid = json['gid'];
    modificationTime = json['modification_time'];
    mode = json['mode'];
    uri = json['uri'];
    size = json['size'];
  }

  // Map<String, dynamic> toJson() {
  //   final Map<String, dynamic> data = <String, dynamic>{};
  //   data['type'] = type;
  //   data['path'] = path;
  //   data['name'] = name;
  //   data['access_time'] = accessTime;
  //   data['uid'] = uid;
  //   data['creation_time'] = creationTime;
  //   data['gid'] = gid;
  //   data['modification_time'] = modificationTime;
  //   data['mode'] = mode;
  //   data['uri'] = uri;
  //   data['size'] = size;
  //   return data;
  // }

  // static getVlcBrowseItemsFromJson(Map<String, dynamic> json) {
  //   List<VLCFolderItem>? vlcFolders;
  //   if (json['element'] != null) {
  //     vlcFolders = <VLCFolderItem>[];
  //     json['element'].forEach((v) {
  //       vlcFolders!.add(VLCFolderItem.fromJson(v));
  //     });
  //   }
  //   return vlcFolders;
  // }

}