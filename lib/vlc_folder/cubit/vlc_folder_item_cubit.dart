import 'package:flutter/foundation.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'vlc_folder_item_state.dart';

class VlcFolderItemCubit extends Cubit<VlcFolderItemState> {
  VlcFolderItemCubit() : super(VlcFolderItemInitial());
}
