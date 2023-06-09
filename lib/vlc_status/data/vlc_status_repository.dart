import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/base/utils/utils.dart';

import 'model/vlc_status.dart';
import 'model/vlc_status_response.dart';

class VLCStatusRepository {
  VLCServer connectedVLCServer;
  final String _vlcStatusPath = "/requests/status.json?";
  Socket? _socket;

  Timer? _getVLCStatusTimer;
  final Duration _statusUpdateInterval = const Duration(milliseconds: 950);
  bool _keepTryingToConnect = false;

  StreamController? _streamController;
  Stream? get stream => _streamController?.stream;

  int _reTryFetchingCounter = 0;
  int _noResponseDetectionCounter = 0;

  VLCStatusResponse _vlcStatusResponse =
      VLCStatusResponse(vlcStatus: VLCStatus(), errorMessage: '');

  VLCStatusRepository({required this.connectedVLCServer}) {
    // _password =
    //     vlcPassword; //base64Url.encode(utf8.encode("" + ":" + vlcPassword));
    _keepTryingToConnect = true;
    _reTryFetchingCounter = 0;
    _vlcStatusResponse =
        VLCStatusResponse(vlcStatus: VLCStatus(), errorMessage: "");
    _streamController = StreamController<VLCStatusResponse>(onListen: () {
      startFetchingVLCStatus();
    }, onCancel: () {
      stopFetchingVLCStatus();
    }, onPause: () {
      stopFetchingVLCStatus();
    }, onResume: () {
      stopFetchingVLCStatus();
    });
  }

  startFetchingVLCStatus() async {
    _noResponseDetectionCounter = 0;
    _getVLCStatusTimer = null;
    await connectToVLC().then((isConnected) async {
      if (isConnected) {
        //print("Socket Connected");
        sendRequestToVLC(null);
        _getVLCStatusTimer = Timer.periodic(_statusUpdateInterval, (timer) {
          sendRequestToVLC(null);
          _noResponseDetectionCounter++;
          if (_noResponseDetectionCounter == 10) {
            _noResponseDetectionCounter = 0;
            _emitVLCNotFoundError();
          }
        });
      } else {
        if (_keepTryingToConnect) {
          await Future.delayed(const Duration(seconds: 1));
          //print("Socket retrying connection");
          startFetchingVLCStatus();
        }
      }
    });
  }

  stopFetchingVLCStatus() {
    _keepTryingToConnect = false;
    _getVLCStatusTimer?.cancel();
    _socket?.close();
    _socket = null;
  }

  _reTryFetching() async {
    _getVLCStatusTimer?.cancel();
    _socket?.close();
    _socket = null;
    if (_keepTryingToConnect) {
      await Future.delayed(const Duration(seconds: 1));
      startFetchingVLCStatus();
      _reTryFetchingCounter++;

      if (_reTryFetchingCounter >= 5) {
        _emitVLCNotFoundError();
        _reTryFetchingCounter = 0;
      }
    }
  }

  _emitVLCNotFoundError() {
    _vlcStatusResponse.errorMessage = "VLCNotFound";
    _streamController?.sink.add(_vlcStatusResponse);
  }

  _onDataReceived(String dataReceived) {
    //print("dataReceived");
    int index = dataReceived.indexOf("{");
    //print(index);
    if (index != -1) {
      var body = dataReceived.substring(index);
      try {
        VLCStatus vlcStatus = VLCStatus.fromJson(jsonDecode(body));
        _vlcStatusResponse =
            VLCStatusResponse(vlcStatus: vlcStatus, errorMessage: "");

        if (_streamController != null && !_streamController!.isClosed) {
          _streamController?.sink.add(_vlcStatusResponse);
        }
      } catch (e) {
        print(e.toString());
      }
    } else {
      // print(dataReceived);
    }
  }

  Future<bool> connectToVLC() async {
    bool isConnected = false;
    try {
      _socket = await Socket.connect(
          connectedVLCServer.ipAddress, int.parse(connectedVLCServer.vlcPort),
          timeout: const Duration(milliseconds: 2000));
      isConnected = true;
      _socket!.listen((event) {
        _onDataReceived(utf8.decode(event));
      }, onError: (error) {
        //This may not get called all the time
        print(error);
      }, onDone: () {
        //This will get called when socket gets closed due to error, so retrying connection from here
        _reTryFetching();
        print("Socket Closed");
      });
    } catch (e) {
      isConnected = false;
    }
    return isConnected;
  }

  //passing a null to requestToSend, gets the vlc status
  sendRequestToVLC(String? requestToSend) {
    _noResponseDetectionCounter = 0;
    _socket?.add(getHeaderForVLCRequest(_vlcStatusPath + (requestToSend ?? ""),
        connectedVLCServer.vlcPassword ?? ""));
  }
}
