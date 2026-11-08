abstract class RegisterEvent {}

class RegisterSubmitted extends RegisterEvent {
  final String name;
  final String email;
  final String password;
  final String phone;

  RegisterSubmitted({
    required this.name,
    required this.email,
    required this.password,
    required this.phone,
  });
}