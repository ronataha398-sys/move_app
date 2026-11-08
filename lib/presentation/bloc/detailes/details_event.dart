abstract class DetailsEvent {}

class GetDetailsEvent extends DetailsEvent {
  int id;
  GetDetailsEvent({required this.id});
}
