import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';
import 'package:vlc_m_remote/vlc_playlist/data/model/vlc_playlist_response.dart';

part 'vlc_playlist_item_state.dart';

class VlcPlaylistItemCubit extends Cubit<VlcPlaylistItemState> {
  VlcPlaylistItemCubit() : super(VlcPlaylistItemInitial());
}