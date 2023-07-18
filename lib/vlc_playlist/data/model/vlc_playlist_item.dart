class VlcPlaylistItem {
  String? ro;
  String? type;
  String? name;
  String? id;
  int? duration;
  String? uri;
  String? current;

  VlcPlaylistItem(
      {this.ro,
      this.type,
      this.name,
      this.id,
      this.duration,
      this.uri,
      this.current});

  VlcPlaylistItem.fromJson(Map<String, dynamic> json) {
    ro = json['ro'];
    type = json['type'];
    name = json['name'];
    id = json['id'];
    duration = json['duration'];
    uri = json['uri'];
    current = json['current'];
  }
}
