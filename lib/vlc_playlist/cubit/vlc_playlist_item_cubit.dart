import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_response.dart';
import 'package:vlc_m_remote/vlc_playlist/data/vlc_playlist_repository.dart';

part 'vlc_playlist_item_state.dart';

class VlcPlaylistItemCubit extends Cubit<VlcPlaylistItemState> {
  final VLCServer connectedVLCServer;
  VlcPlaylistItemCubit(this.connectedVLCServer)
      : super(VlcPlaylistItemInitial()) {
    fetchVLCPlaylist();
  }

  VLCPlaylistRepository? tcpClientForVLCPlaylist;
  StreamSubscription<dynamic>? _vlcStatusResponseSubscription;

  Future fetchVLCPlaylist() async {
    try {
      emit(const VlcPlaylistLoading());
      _vlcStatusResponseSubscription = null;
      tcpClientForVLCPlaylist =
          VLCPlaylistRepository(connectedVLCServer: connectedVLCServer);
      _vlcStatusResponseSubscription =
          tcpClientForVLCPlaylist?.stream?.listen((event) {
        if (!isClosed) {
          if ((event as VlcPlaylistResponse).errorMessage.isEmpty) {
            emit(VlcPlaylistLoaded(event));
          } else if ((event).errorMessage == "VLCNotFound") {
            emit(const VlcPlaylistLoadingFailed());
          }
        }
      });
    } catch (e) {
      //print(e.toString());
    }
  }

  Future stopFetchingVLCPlaylist() async {
    _vlcStatusResponseSubscription
        ?.cancel()
        .then((value) => _vlcStatusResponseSubscription = null);
  }

  Future pauseFetchingVLCPlaylist() async {
    tcpClientForVLCPlaylist?.stopFetchingVLCStatus();
    //emit(VlcStatusDisconnected());
  }

  Future resumeFetchingVLCStatus() async {
    tcpClientForVLCPlaylist?.startFetchingVLCStatus();
    //emit(VlcStatusDisconnected());
  }

  // Future updateVLCPlaylist(String updateRequest) async {
  //   tcpClientForVLCPlaylist?.sendRequestToVLC(updateRequest);
  // }
}
