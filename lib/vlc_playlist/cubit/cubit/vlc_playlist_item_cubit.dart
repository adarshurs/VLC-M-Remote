import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vlc_playlist_item_state.dart';

class VlcPlaylistItemCubit extends Cubit<VlcPlaylistItemState> {
  VlcPlaylistItemCubit() : super(VlcPlaylistItemInitial());
}
