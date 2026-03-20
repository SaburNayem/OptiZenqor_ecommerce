class AccountModel {
  const AccountModel({
    required this.name,
    required this.email,
    required this.actions,
  });

  final String name;
  final String email;
  final List<String> actions;
}
