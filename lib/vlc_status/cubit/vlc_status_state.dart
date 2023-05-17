part of 'vlc_status_cubit.dart';

@immutable
abstract class VlcStatusState {
  const VlcStatusState();
}

class VlcStatusInitial extends VlcStatusState {
  const VlcStatusInitial();
}

class VlcStatusConnecting extends VlcStatusState {
  const VlcStatusConnecting();
}

class VlcStatusConnected extends VlcStatusState {
  const VlcStatusConnected();
}

class VlcStatusDisconnected extends VlcStatusState {
  const VlcStatusDisconnected();
}

class VlcStatusNotFound extends VlcStatusState {
  const VlcStatusNotFound();
}

class VlcStatusIncorrectPassword extends VlcStatusState {
  const VlcStatusIncorrectPassword();
}

class VlcStatusLoaded extends VlcStatusState {
  final VLCStatusResponse vlcStatusResponse;
  const VlcStatusLoaded(this.vlcStatusResponse);

  @override
  bool operator ==(Object other) {
    //if(identical(this, 0)) return true;
    if (identical(this, other)) return true;
    return other is VlcStatusLoaded &&
        other.vlcStatusResponse == vlcStatusResponse;
  }

  @override
  int get hashCode => vlcStatusResponse.hashCode;
}
