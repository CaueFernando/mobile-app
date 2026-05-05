import 'package:google_sign_in/google_sign_in.dart';

class GoogleUserProfile {
  const GoogleUserProfile({
    required this.id,
    required this.name,
    required this.email,
    this.photoUrl,
  });

  final String id;
  final String name;
  final String email;
  final String? photoUrl;
}

class GoogleAuthService {
  GoogleAuthService({GoogleSignIn? googleSignIn})
      : _googleSignIn = googleSignIn ?? GoogleSignIn.instance;

  final GoogleSignIn _googleSignIn;
  Future<void>? _initializeFuture;

  Future<void> initialize() {
    return _initializeFuture ??= _googleSignIn.initialize();
  }

  Future<GoogleUserProfile> signIn() async {
    await initialize();

    if (!_googleSignIn.supportsAuthenticate()) {
      throw StateError('Google Sign-In nao esta disponivel nesta plataforma.');
    }

    final account = await _googleSignIn.authenticate();
    return GoogleUserProfile(
      id: account.id,
      name: account.displayName ?? account.email,
      email: account.email,
      photoUrl: account.photoUrl,
    );
  }

  Future<void> signOut() async {
    await initialize();
    await _googleSignIn.signOut();
  }
}
