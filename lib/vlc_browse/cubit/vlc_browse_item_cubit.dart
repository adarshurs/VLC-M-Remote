import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/vlc_browse/cubit/vlc_browse_item_state.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_response.dart';
import 'package:vlc_m_remote/vlc_browse/data/vlc_browse_repository.dart';

class VlcBrowseItemCubit extends Cubit<VlcBrowseItemState> {
  final VLCServer connectedVLCServer;
  VlcBrowseItemCubit(this.connectedVLCServer) : super(VlcBrowseItemInitial()) {
    vlcBrowseRepository =
        VLCBrowseRepository(connectedVLCServer: connectedVLCServer);
    fetchVlcBrowseItems(null);
  }

  VLCBrowseRepository? vlcBrowseRepository;
  VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();

  Future playVlcBrowseItem(String browseItemPath) async {
    _getBrowseItems(VLCBrowseConstants.playBrowseItemPrefix + browseItemPath);
  }

  Future addToPlaylistVlcBrowseItem(String browseItemPath) async {
    _getBrowseItems(
        VLCBrowseConstants.addToPlaylistBrowseItemPrefix + browseItemPath);
  }

  addAsSubtitleVlcBrowseItem(String browseItemPath) {
    _getBrowseItems(
        VLCBrowseConstants.addSubtitleBrowseItemPrefix + browseItemPath);
  }

  Future fetchVlcBrowseItems(String? request) async {
    _getBrowseItems(request);
  }

  _getBrowseItems(String? pathToBrowse) {
    try {
      emit(const VlcBrowseLoading());
      vlcBrowseRepository?.getFolderData(pathToBrowse).then((value) {
        if (value is VlcBrowseResponse) {
          emit(VlcBrowseLoaded(value));
        } else {
          emit(const VlcBrowseLoadingFailed());
        }
      });
    } catch (e) {
      emit(const VlcBrowseLoadingFailed());
    }
  }
}
