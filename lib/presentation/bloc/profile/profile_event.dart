abstract class ProfileEvent {}

class LoadProfileEvent extends ProfileEvent {
  final String userId;

  LoadProfileEvent(this.userId);
}

class RefreshProfileEvent extends ProfileEvent {
  final String userId;

  RefreshProfileEvent(this.userId);
}