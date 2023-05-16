import 'package:flutter/foundation.dart';

@immutable
abstract class VlcBrowseItemState {
  const VlcBrowseItemState();
}

class VlcBrowseItemInitial extends VlcBrowseItemState {}

class VlcBrowseLoading extends VlcBrowseItemState {
  const VlcBrowseLoading();
}
class VlcBrowseLoaded extends VlcBrowseItemState {
  const VlcBrowseLoaded();
}

class VlcBrowseLoadingFailed extends VlcBrowseItemState {
  const VlcBrowseLoadingFailed();
}
