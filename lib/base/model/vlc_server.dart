
class VLCServer {
  //late String name;
  late String name;
  late String ipAddress;
  String? vlcPassword;
  String vlcPort;

  bool isDefault = false;
  String vlcHomeFolderPath = "uri=file%3A%2F%2F%2F";
  bool isPreviouslyConnected = false;

  VLCServer(
      {required this.ipAddress,
      this.vlcPort = "8080",
      required this.vlcPassword});
}
