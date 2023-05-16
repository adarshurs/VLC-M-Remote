// class VLCFolderItem {
//   late int id;
//   String name;
//   String type;
//   String path;
//   String uri;
//   bool hasAdded = false;
//   String? creationTime;
//   String? size;

//   VLCFolderItem(this.id, this.name, this.type, this.path, this.uri);

//   // VLCFolder.fromMap(Map<String, dynamic> map) {}

//   Map<String, dynamic> toMap() {
//     return {};
//   }

//   @override
//   String toString() {
//     return 'VLCFolder{id: $id, name: $name, path: $path}';
//   }

//   static const columnId = 'id';
//   static const columnName = 'name';
//   static const columnType = 'type';
//   static const columnUri = "uri";
//   static const columnHasAdded = "hasAdded";
//   static const columnCreationTime = "creationTime";
//   static const columnSize = "size";
// }

import 'dart:html';

class VlcBrowseResponse {
  List<VlcBrowseItem>? folders;

  VlcBrowseResponse({this.folders});

  VlcBrowseResponse.fromJson(Map<String, dynamic> json) {
    if (json['element'] != null) {
      folders = <VlcBrowseItem>[];
      json['element'].forEach((v) {
        folders!.add(VlcBrowseItem.fromJson(v));
      });
    }
    //return folders;
  }
}

class VlcBrowseItem {
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