part of 'vlc_playlist_item_cubit.dart';

@immutable
abstract class VlcPlaylistItemState {
  const VlcPlaylistItemState();
}

class VlcPlaylistItemInitial extends VlcPlaylistItemState {}

class VlcPlaylistLoading extends VlcPlaylistItemState {
  const VlcPlaylistLoading();
}

class VlcPlaylistLoaded extends VlcPlaylistItemState {
  final VlcPlaylistResponse vlcPlaylistResponse;
  const VlcPlaylistLoaded(this.vlcPlaylistResponse);
}

class VlcPlaylistLoadingFailed extends VlcPlaylistItemState {
  const VlcPlaylistLoadingFailed();
}
