import 'dart:convert';

String formatSecondsInHhMmSs(int seconds) {
  var duration = Duration(seconds: seconds);

  // ignore: non_constant_identifier_names
  final HH = (duration.inHours).toString().padLeft(2, '0');
  final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

  return (duration.inSeconds >= 3600) ? '$HH:$mm:$ss' : '$mm:$ss';
}

List<int> getHeaderForVLCRequest(String requestToSend, String vlcPassword) {
  String data = "GET $requestToSend HTTP/1.1\r\n";
  List<List<String>> requestHeaders = [
    ["Authorization", "Basic${base64Url.encode(utf8.encode("" + ":" + vlcPassword))}"]
  ];
  for (var element in requestHeaders) {
    data += "${element[0]}:${element[1]}\r\n";
  }
  data += "\r\n";
  return utf8.encode(data);
}
