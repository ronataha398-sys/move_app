abstract class HomeEvent {}

class HomeInitialEvent extends HomeEvent {
  HomeInitialEvent();
}

class ChangeBackgroundImageEvent extends HomeEvent {
  final String image;
  ChangeBackgroundImageEvent({required this.image});
}
