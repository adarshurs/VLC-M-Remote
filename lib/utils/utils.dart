String formatSecondsInHhMmSs(int seconds) {
  var duration = Duration(seconds: seconds);

  // ignore: non_constant_identifier_names
  final HH = (duration.inHours).toString().padLeft(2, '0');
  final mm = (duration.inMinutes % 60).toString().padLeft(2, '0');
  final ss = (duration.inSeconds % 60).toString().padLeft(2, '0');

  return (duration.inSeconds >= 3600) ? '$HH:$mm:$ss' : '$mm:$ss';
}
