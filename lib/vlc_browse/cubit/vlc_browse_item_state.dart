import 'package:flutter/foundation.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';

@immutable
abstract class VlcBrowseItemState {
  const VlcBrowseItemState();
}

class VlcBrowseItemInitial extends VlcBrowseItemState {}

class VlcBrowseLoading extends VlcBrowseItemState {
  const VlcBrowseLoading();
}
class VlcBrowseLoaded extends VlcBrowseItemState {
  final VlcBrowseResponse vlcBrowseResponse;
  const VlcBrowseLoaded(this.vlcBrowseResponse);
}

class VlcBrowseLoadingFailed extends VlcBrowseItemState {
  const VlcBrowseLoadingFailed();
}
