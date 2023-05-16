import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/vlc_browse/cubit/vlc_browse_item_state.dart';
import 'package:vlc_m_remote/vlc_browse/data/vlc_browse_repository.dart';

class VlcBrowseItemCubit extends Cubit<VlcBrowseItemState> {
  VlcBrowseItemCubit() : super(VlcBrowseItemInitial());
  VLCBrowseRepository? vlcBrowseRepository;

}