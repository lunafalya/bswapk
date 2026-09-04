import '../widgets/language_toggle.dart';

/// Kumpulan teks untuk halaman Login/Register/Reset Password
/// dalam 2 bahasa: English (en) dan Indonesia (id).
class AuthStrings {
  final AppLanguage language;
  const AuthStrings(this.language);

  bool get _isId => language == AppLanguage.id;

  // Login
  String get welcomeTitle => _isId ? 'Selamat Datang di BSW' : 'Welcome to BSW';
  String get welcomeSubtitle => _isId
      ? 'Temukan layanan terbaik Kota Bogor dalam satu superapp!'
      : "Discover Bogor's top services in one easy-to-use superapp!";
  String get loginWithGoogle =>
      _isId ? 'Masuk dengan Google' : 'Login with Google';
  String get or => _isId ? 'Atau' : 'Or';
  String get usernameHint => _isId ? 'Username/Email' : 'Username/Email';
  String get passwordHint => _isId ? 'Kata Sandi' : 'Password';
  String get loginButton => _isId ? 'Masuk' : 'Login';
  String get forgotPassword => _isId ? 'Lupa Kata Sandi?' : 'Forgot Password?';
  String get termsPrefix => _isId
      ? 'Dengan masuk ke BSW, Anda menyetujui seluruh'
      : "By logging in to BSW, you agree to all of BSW's";
  String get termsAnd => _isId ? 'dan' : 'and';
  String get termsConditions =>
      _isId ? 'Syarat dan Ketentuan' : 'Terms and Conditions';
  String get privacyPolicy => _isId ? 'Kebijakan Privasi.' : 'Privacy Policy.';
  String get noAccount =>
      _isId ? 'Belum punya akun? ' : "Don't have an account yet? ";
  String get signUp => _isId ? 'Daftar' : 'Sign up';
  String get usernameRequired =>
      _isId ? 'Username/Email wajib diisi' : 'Username/Email is required';
  String get passwordRequired =>
      _isId ? 'Kata sandi wajib diisi' : 'Password is required';
  String loginFailed(Object e) =>
      _isId ? 'Masuk gagal: $e' : 'Login failed: $e';
  String googleLoginFailed(Object e) =>
      _isId ? 'Masuk dengan Google gagal: $e' : 'Google login failed: $e';

  // Register
  String get registerTitle =>
      _isId ? 'Buat Akun BSW' : 'Create your BSW Account';
  String get registerSubtitle => _isId
      ? 'Daftar untuk mengakses seluruh layanan Bogor Single Window.'
      : 'Sign up to access all Bogor Single Window services.';
  String get registerWithGoogle =>
      _isId ? 'Daftar dengan Google' : 'Sign up with Google';
  String get fullNameHint => _isId ? 'Nama Lengkap' : 'Full Name';
  String get emailHint => _isId ? 'Email' : 'Email';
  String get confirmPasswordHint =>
      _isId ? 'Konfirmasi Kata Sandi' : 'Confirm Password';
  String get registerButton => _isId ? 'Daftar' : 'Sign up';
  String get alreadyHaveAccount =>
      _isId ? 'Sudah punya akun? ' : 'Already have an account? ';
  String get loginLink => _isId ? 'Masuk' : 'Login';
  String get nameRequired => _isId ? 'Nama wajib diisi' : 'Name is required';
  String get emailRequired => _isId ? 'Email wajib diisi' : 'Email is required';
  String get emailInvalid =>
      _isId ? 'Format email tidak valid' : 'Invalid email format';
  String get passwordMinLength => _isId
      ? 'Kata sandi minimal 8 karakter'
      : 'Password must be at least 8 characters';
  String get confirmPasswordMismatch =>
      _isId ? 'Konfirmasi kata sandi tidak sama' : 'Passwords do not match';
  String registerFailed(Object e) =>
      _isId ? 'Registrasi gagal: $e' : 'Registration failed: $e';
  String googleRegisterFailed(Object e) =>
      _isId ? 'Daftar dengan Google gagal: $e' : 'Google sign up failed: $e';

  // Reset password
  String get resetTitle => _isId ? 'Lupa Kata Sandi?' : 'Forgot Password?';
  String get resetSubtitle => _isId
      ? 'Masukkan email akun Anda, kami akan mengirimkan link untuk mengatur ulang kata sandi.'
      : "Enter your account email and we'll send you a link to reset your password.";
  String get sendResetLink => _isId ? 'Kirim Link Reset' : 'Send Reset Link';
  String get backToLogin => _isId ? 'Kembali ke Login' : 'Back to Login';
  String get emailSentTitle => _isId ? 'Email Terkirim' : 'Email Sent';
  String emailSentBody(String email) => _isId
      ? 'Kami telah mengirim link reset kata sandi ke $email. Silakan cek kotak masuk email Anda.'
      : "We've sent a password reset link to $email. Please check your inbox.";
  String resetFailed(Object e) =>
      _isId ? 'Gagal mengirim link reset: $e' : 'Failed to send reset link: $e';
}
