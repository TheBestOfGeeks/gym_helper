abstract interface class IAuthRepo {
  Future<void> signIn(String email, String password);
}
