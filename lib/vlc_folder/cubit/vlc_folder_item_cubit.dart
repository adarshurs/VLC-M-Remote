import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:vlc_m_remote/vlc_folder/cubit/vlc_folder_item_state.dart';


class VlcFolderItemCubit extends Cubit<VlcFolderItemState> {
  VlcFolderItemCubit() : super(VlcFolderItemInitial());
}