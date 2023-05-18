class VlcPlaylistItem {
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

  VlcPlaylistItem(
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

  VlcPlaylistItem.fromJson(Map<String, dynamic> json) {
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
}
