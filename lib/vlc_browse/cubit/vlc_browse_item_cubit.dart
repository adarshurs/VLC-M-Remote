import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/base/model/vlc_server.dart';
import 'package:vlc_m_remote/vlc_browse/cubit/vlc_browse_item_state.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';
import 'package:vlc_m_remote/vlc_browse/data/vlc_browse_repository.dart';

class VlcBrowseItemCubit extends Cubit<VlcBrowseItemState> {
  final VLCServer vlcServerToToConnect;
  VlcBrowseItemCubit(this.vlcServerToToConnect)
      : super(VlcBrowseItemInitial()) {
    fetchVlcBrowseItems(null);
  }

  VLCBrowseRepository? vlcBrowseRepository;
  VlcBrowseResponse vlcBrowseResponse = VlcBrowseResponse();

  Future fetchVlcBrowseItems(String? pathToBrowse) async {
    try {
      emit(const VlcBrowseLoading());
      vlcBrowseRepository = VLCBrowseRepository(
          ipAddress: vlcServerToToConnect.ipAddress,
          vlcPort: vlcServerToToConnect.vlcPort,
          vlcPassword: vlcServerToToConnect.vlcPassword!);
      vlcBrowseRepository?.getFolderData(pathToBrowse).then((value) {
        if (value is VlcBrowseResponse) {
          emit(VlcBrowseLoaded(value));
        } else {
          emit(const VlcBrowseLoadingFailed());
        }
      });
    } catch (e) {
      emit(const VlcBrowseLoadingFailed());
      //print(e.toString());
    }
  }
}
