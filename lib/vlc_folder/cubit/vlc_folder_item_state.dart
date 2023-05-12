import 'package:flutter/foundation.dart';

@immutable
abstract class VlcFolderItemState {
  const VlcFolderItemState();
}

class VlcFolderItemInitial extends VlcFolderItemState {}

class VlcFolderLoading extends VlcFolderItemState {
  const VlcFolderLoading();
}
class VlcFolderLoaded extends VlcFolderItemState {
  const VlcFolderLoaded();
}

class VlcFolderLoadingFailed extends VlcFolderItemState {
  const VlcFolderLoadingFailed();
}
