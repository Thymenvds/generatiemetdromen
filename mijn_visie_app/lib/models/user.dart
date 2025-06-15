
enum UserType {admin, ambassador, user}
/// Corresponds to the User relation in the Database
class User {
  late String firstname;
  late String lastname;
  late String email;
  late UserType type;

  // User(
  //     {required this.firstname,
  //     required this.lastname,
  //     required this.email,
  //     required this.username,
  //     required this.pk});

  /// Constructor for a User instance from [json] (JSON format)
  User.fromJson(Map<String, dynamic> json) {
    firstname = json["first_name"];
    lastname = json["last_name"];
    email = json["email"];
    type = UserType.values.byName(json["user_type"]);
  }
}
