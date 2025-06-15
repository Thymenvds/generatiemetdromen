import 'dart:io';
// import 'package:geco_app/repository/user_repository.dart';
import 'package:get/get.dart';
import 'package:mijn_visie_app/api/client.dart';
import 'package:mijn_visie_app/models/user.dart';
import 'package:mijn_visie_app/api/login.dart' as api;
// import 'package:google_sign_in/google_sign_in.dart';

class UserController extends GetxController {
  /// user details of the logged in user
  User? user;
  /// bool if user is logged in
  final isLogged = false.obs;
  // UserRepository repository = UserRepository();
  // final GoogleSignIn _googleSignIn = GoogleSignIn();

  static UserController get to => Get.find<UserController>();

  /// fetches the user details of the currently logged in user and update the view
  // fetchUserDetails() async {
  //   User? userTemp = await repository.fetchUserDetails();
  //   if (userTemp != null) {
  //     user = userTemp;
  //     isLogged.value = true;
  //     update();
  //   } else {
  //     isLogged.value = false;
  //     final dir = Directory(appDocPath + '/cookies/');
  //     dir.deleteSync(recursive: true);
  //     bool exists = await Directory(appDocPath + '/cookies/').exists();
  //     if (!exists) {
  //       Directory(appDocPath + '/cookies/').createSync();
  //     }
  //     dioClient = await client(appDocPath);
  //   }
  // }

  /// logs in user using [email], [password], sets correct state and updates the view
  Future<bool> login(String email, String password) async {
    User? userTemp = await api.login(email, password);
    if (userTemp != null) {
      user = userTemp;
      isLogged.value = true;
      // TODO is update necessary?
      update();
      return true;
    }
    return false;
  }

  // registers a new user using [username], [email], [password],  and [password2] and afterwords logs in, sets correct state and updates the view
  Future<bool> register(
      String firstname, String lastname, String email, String password, String password2) async {
    User? userTemp =
        await api.register(firstname, lastname, email, password, password2);
    if (userTemp != null) {
      await login(email, password);
      return true;
    }
    return false;
  }

  // Use google sign in to authenticate user
//   Future<bool> googleLogin() async {
//     // First sign in to google backend
//     GoogleSignInAccount? account = await _googleSignIn.signIn();

//     // If successful, get authentication token
//     GoogleSignInAuthentication googleKey = await account!.authentication;
//     String? token = googleKey.accessToken;
//     // Login to django backend with token
//     if (token != null) {
//       User? receivedUser = await repository
//           .loginTokenUser(token)
//           .whenComplete(() => _googleSignIn.signOut());
//       if (receivedUser != null) {
//         user = receivedUser;
//         isLogged.value = true;
//         return true;
//       }
//     }
//     return false;
//   }

//   /// logout user
//   logout() async {
//     await repository.logoutUser();
//     user = null;
//     isLogged.value = false;
//   }

//   /// delete accoun of logged in user
//   deleteAccount() async {
//     await repository.deleteAccountUser();
//     isLogged.value = false;
//     user = null;
//     final dir = Directory(appDocPath + '/cookies/');
//     dir.deleteSync(recursive: true);
//     bool exists = await Directory(appDocPath + '/cookies/').exists();
//     if (!exists) {
//       Directory(appDocPath + '/cookies/').createSync();
//     }
//     dioClient = await client(appDocPath);
//   }
}
