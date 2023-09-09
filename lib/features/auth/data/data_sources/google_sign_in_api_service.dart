import 'dart:io';

import 'package:google_sign_in/google_sign_in.dart';

class GoogleSignInApi {
  static final _googleSignIn = GoogleSignIn(
      clientId: Platform.isIOS
          ? '651723805267-qe5cq4j47t1ffl3s9uk743nsbahip4ff.apps.googleusercontent.com'
          : null,
      scopes: [
        'email',
        'https://www.googleapis.com/auth/userinfo.profile',
      ]);

  static Future<GoogleSignInAccount?> login() => _googleSignIn.signIn();

  static Future<void> logout() => _googleSignIn.disconnect();
}
