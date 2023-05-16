import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/vlc_browse/cubit/vlc_browse_item_state.dart';
import 'package:vlc_m_remote/vlc_browse/data/model/vlc_browse_item.dart';
import 'package:vlc_m_remote/vlc_browse/data/vlc_browse_repository.dart';
import 'package:vlc_m_remote/vlc_server.dart';

class VlcBrowseItemCubit extends Cubit<VlcBrowseItemState> {
  final VLCServer vlcServerToToConnect;
  VlcBrowseItemCubit(this.vlcServerToToConnect) : super(VlcBrowseItemInitial());
  VLCBrowseRepository? vlcBrowseRepository;

Future fetchVlcBrowseItems() async {
    try {
      emit(const VlcBrowseLoading());
      vlcBrowseRepository = VLCBrowseRepository(ipAddress: vlcServerToToConnect.ipAddress, vlcPort: vlcServerToToConnect.vlcPort, vlcPassword: vlcServerToToConnect.vlcPassword!);
      vlcBrowseRepository?.getFolderData().then((value) {
        if(value is VlcBrowseResponse){
          emit(VlcBrowseLoaded(value));
        }
      } );      
    } catch (e) {
      //print(e.toString());
    }
  }
}