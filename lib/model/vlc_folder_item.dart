class VLCFolderItem {
  late int id;
  String name;
  String type;
  String path;
  String uri;
  bool hasAdded = false;
  String? creationTime;
  String? size;

  VLCFolderItem(this.id, this.name, this.type, this.path, this.uri);

  // VLCFolder.fromMap(Map<String, dynamic> map) {}

  Map<String, dynamic> toMap() {
    return {};
  }

  @override
  String toString() {
    return 'VLCFolder{id: $id, name: $name, path: $path}';
  }

  static const columnId = 'id';
  static const columnName = 'name';
  static const columnType = 'type';
  static const columnUri = "uri";
  static const columnHasAdded = "hasAdded";
  static const columnCreationTime = "creationTime";
  static const columnSize = "size";
}
