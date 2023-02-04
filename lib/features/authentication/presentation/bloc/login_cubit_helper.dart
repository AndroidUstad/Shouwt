import 'package:flutter_login_facebook/flutter_login_facebook.dart';
import 'package:google_sign_in/google_sign_in.dart';

class LoginCubitHelper {
  Future<String> facebookLogin() async {
    final fb = FacebookLogin();

    final res = await fb.logIn(
      permissions: [
        FacebookPermission.publicProfile,
        FacebookPermission.email,
      ],
    );

    switch (res.status) {
      case FacebookLoginStatus.success:
        final FacebookAccessToken accessToken = res.accessToken!;
        return accessToken.token;

      case FacebookLoginStatus.cancel:
        return 'Request cancelled';
      case FacebookLoginStatus.error:
        return res.error!.localizedTitle!;
      default:
        return 'Something wrong happened, please try again later';
    }
  }

  Future<String> googleLogin() async {
    GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
    try {
      final signInResponse = await _googleSignIn.signIn();
      final googleSignInAuthentication = await signInResponse!.authentication;
      return googleSignInAuthentication.accessToken!;
    } catch (e) {
      return e.toString();
    }
  }
}
