

import 'package:vlc_m_remote/vlc_status/data/model/vlc_status.dart';

class VLCStatusResponse {
  VLCStatus vlcStatus;
  String errorMessage;
  VLCStatusResponse({
    required this.vlcStatus,
    required this.errorMessage,
  });


  //VLCStatusResponse(this.vlcStatus, this.errorMessage);

  // VLCStatusResponse copyWith({
  //   VLCStatus? vlcStatus,
  //   String? errorMessage,
  // }) {
  //   return VLCStatusResponse(
  //     vlcStatus: vlcStatus ?? this.vlcStatus,
  //     errorMessage: errorMessage ?? this.errorMessage,
  //   );
  // }
}
