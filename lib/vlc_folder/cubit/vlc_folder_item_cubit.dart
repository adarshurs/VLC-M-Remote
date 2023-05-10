import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

part 'vlc_folder_item_state.dart';

class VlcFolderItemCubit extends Cubit<VlcFolderItemState> {
  VlcFolderItemCubit() : super(VlcFolderItemInitial());
}
