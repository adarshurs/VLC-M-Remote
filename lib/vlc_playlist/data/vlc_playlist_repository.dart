import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/base/utils/utils.dart';
import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_response.dart';

class VLCPlaylistRepository {
  VLCServer connectedVLCServer;
  final String _vlcPlaylistPath = "/requests/playlist.json?";
  Socket? _socket;

  Timer? _getVLCStatusTimer;
  final Duration _playlistUpdateInterval = const Duration(milliseconds: 950);
  bool _keepTryingToConnect = false;

  StreamController? _streamController;
  Stream? get stream => _streamController?.stream;

  int _reTryFetchingCounter = 0;
  int _noResponseDetectionCounter = 0;
  VlcPlaylistResponse _vlcPlaylistResponse = VlcPlaylistResponse();

  VLCPlaylistRepository({required this.connectedVLCServer}) {
    _keepTryingToConnect = true;
    _reTryFetchingCounter = 0;
    _vlcPlaylistResponse = VlcPlaylistResponse();
    _streamController = StreamController<VlcPlaylistResponse>(onListen: () {
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
        sendRequestToVLC();
        _getVLCStatusTimer = Timer.periodic(_playlistUpdateInterval, (timer) {
          sendRequestToVLC();
          _noResponseDetectionCounter++;
          if (_noResponseDetectionCounter == 10) {
            _noResponseDetectionCounter = 0;
            _emitNoResponseError();
          }
        });
      } else {
        if (_keepTryingToConnect) {
          await Future.delayed(const Duration(seconds: 1));
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
        _emitNoResponseError();
        _reTryFetchingCounter = 0;
      }
    }
  }

  _emitNoResponseError() {
    _vlcPlaylistResponse.errorMessage = "VLCNoResponse";
    _streamController?.sink.add(_vlcPlaylistResponse);
  }

  _onDataReceived(String dataReceived) {
    int index = dataReceived.indexOf("{");
    if (index != -1) {
      var body = dataReceived.substring(index);
      try {
        //VLCStatus vlcStatus = VLCStatus.fromJson(jsonDecode(body));
        VlcPlaylistResponse vlcPlaylistResponse =
            VlcPlaylistResponse.fromJson(jsonDecode(body));

        if (_streamController != null && !_streamController!.isClosed) {
          _streamController?.sink.add(vlcPlaylistResponse);
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

  sendRequestToVLC() {
    _noResponseDetectionCounter = 0;
    _socket?.add(getHeaderForVLCRequest(
        _vlcPlaylistPath, connectedVLCServer.vlcPassword ?? ""));
  }
}
