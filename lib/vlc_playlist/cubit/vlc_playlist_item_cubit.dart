import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vlc_playlist_item_state.dart';

class VlcPlaylistItemCubit extends Cubit<VlcPlaylistItemState> {
  VlcPlaylistItemCubit() : super(VlcPlaylistItemInitial());
}
