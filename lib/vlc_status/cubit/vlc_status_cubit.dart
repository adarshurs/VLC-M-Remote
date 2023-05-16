// ignore: depend_on_referenced_packages
import 'dart:async';

import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/vlc_server.dart';
import 'package:vlc_m_remote/vlc_status/data/model/vlc_status_response.dart';
import 'package:vlc_m_remote/vlc_status/data/vlc_status_repository.dart';


part 'vlc_status_state.dart';

class VlcStatusCubit extends Cubit<VlcStatusState> {
  final VLCServer vlcServerToToConnect;

  VlcStatusCubit(this.vlcServerToToConnect) : super(const VlcStatusInitial());

  VLCStatusRepository? tcpClientForVLC;
  StreamSubscription<dynamic>? _vlcStatusResponseSubscription;

  Future fetchVLCStatus() async {
    try {
      emit(const VlcStatusConnecting());
      _vlcStatusResponseSubscription = null;
      tcpClientForVLC = VLCStatusRepository(
          ipAddress: vlcServerToToConnect.ipAddress,
          vlcPort: vlcServerToToConnect.vlcPort,
          vlcPassword: vlcServerToToConnect.vlcPassword!);
      _vlcStatusResponseSubscription = tcpClientForVLC?.stream?.listen((event) {
        if(!isClosed){
          if((event as VLCStatusResponse).errorMessage.isEmpty){
            emit(VlcStatusLoaded(event));
          } else if ((event).errorMessage  == "VLCNotFound"){
            emit(const VlcStatusNotFound());
          }
        }
      });
    } catch (e) {
      //print(e.toString());
    }
  }

  Future stopFetchingVLCStatus() async {
    print("stopped");
    _vlcStatusResponseSubscription
        ?.cancel()
        .then((value) => _vlcStatusResponseSubscription = null);
  }


  Future pauseFetchingVLCStatus() async{
    tcpClientForVLC?.stopFetchingVLCStatus();
    //emit(VlcStatusDisconnected());
  }

  Future resumeFetchingVLCStatus() async{
    tcpClientForVLC?.startFetchingVLCStatus();
    //emit(VlcStatusDisconnected());
  }

  Future updateVLCStatus(String updateRequest) async{
    tcpClientForVLC?.sendRequestToVLC(updateRequest);
  }

}
