abstract class UserEvent {}

class LoadUserEvent extends UserEvent {
  final String userId;

  LoadUserEvent(this.userId);
}

class ClearUserEvent extends UserEvent {}